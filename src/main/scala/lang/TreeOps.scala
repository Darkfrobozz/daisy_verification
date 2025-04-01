// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

import scala.collection.immutable.Seq

import Extractors._
import Trees._
import Constructors._

import lang.Identifiers._

/**
  Various useful functions for manipulating trees.
 */
object TreeOps {

  /** Does a right tree fold
   *
   * A right tree fold applies the input function to the subnodes first (from left
   * to right), and combine the results along with the current node value.
   *
   * @param f a function that takes the current node and the seq
   *        of results form the subtrees.
   * @param e The Expr on which to apply the fold.
   * @return The expression after applying `f` on all subtrees.
   * @note the computation is lazy, hence you should not rely on side-effects of `f`
   */
  def fold[T](f: (Expr, Seq[T]) => T)(e: Expr): T = {
    val rec = fold(f) _
    val Operator(es, _) = e

    // Usages of views makes the computation lazy. (which is useful for
    // contains-like operations)
    f(e, Seq(es.view.map[T](rec).toSeq: _*))
    // f(e, es.map(rec))
  }

  /** Pre-traversal of the tree.
   *
   * Invokes the input function on every node '''before''' visiting
   * children. Traverse children from left to right subtrees.
   *
   * e.g.
   * {{{
   *   Add(a, Minus(b, c))
   * }}}
   * will yield, in order:
   * {{{
   *   f(Add(a, Minus(b, c))); f(a); f(Minus(b, c)); f(b); f(c)
   * }}}
   *
   * @param f a function to apply on each node of the expression
   * @param e the expression to traverse
   */
  def preTraversal(f: Expr => Unit)(e: Expr): Unit = {
    val rec = preTraversal(f) _
    val Operator(es, _) = e
    f(e)
    es.foreach(rec)
  }


  /** Post-traversal of the tree.
   *
   * Invokes the input function on every node '''after''' visiting
   * children.
   *
   * e.g.
   * {{{
   *   Add(a, Minus(b, c))
   * }}}
   * will yield, in order:
   * {{{
   *   f(a), f(b), f(c), f(Minus(b, c)), f(Add(a, Minus(b, c)))
   * }}}
   *
   * @param f a function to apply on each node of the expression
   * @param e the expression to traverse
   */
  def postTraversal(f: Expr => Unit)(e: Expr): Unit = {
    val rec = postTraversal(f) _
    val Operator(es, _) = e
    es.foreach(rec)
    f(e)
  }

  /** Post-transformation of the tree.
   *
   * Takes a partial function of replacements.
   * Substitutes '''after''' recursing down the trees.
   *
   * Supports two modes :
   *
   *   - If applyRec is false (default), will only substitute once on each level.
   *   e.g.
   *   {{{
   *     Add(a, Minus(b, c)) with replacements: Minus(b,c) -> z, Minus(e,c) -> d, b -> e
   *   }}}
   *   will yield:
   *   {{{
   *     Add(a, Minus(e, c))
   *   }}}
   *
   *   - If applyRec is true, it will substitute multiple times on each level:
   *   e.g.
   *   {{{
   *     Add(a, Minus(b, c)) with replacements: Minus(e,c) -> d, b -> e, d -> f
   *   }}}
   *   will yield:
   *   {{{
   *     Add(a, f)
   *   }}}
   *
   * @note The mode with applyRec true can diverge if f is not well formed (i.e. not convergent)
   */
  def postMap(f: Expr => Option[Expr], applyRec: Boolean = false)(e: Expr): Expr =
    if (applyRec) {
      var prev = e
      var curr = postMap(f,false)(e)
      while (prev != curr) {
        prev = curr
        curr = postMap(f,false)(curr)
      }
      curr
    } else {
      val rec = postMap(f, applyRec)

      val Operator(es, builder) = e
      val newEs = es.map(rec)
      val newV = {
        if ((newEs zip es).exists { case (bef, aft) => aft ne bef }) {
          builder(newEs)
        } else {
          e
        }
      }
      f(newV) getOrElse newV
    }

  // Returns all sub-expression in an expression in a list
  def getSubExpr(e: Expr): Seq[Expr] = {
    val Operator(es, _) = e
    if(es.size >0){
      es.flatMap(getSubExpr(_)) :+ e
    } else {
      Seq()
    }
  }


  /** Checks if the predicate holds in some sub-expression */
  def exists(matcher: PartialFunction[Expr, Boolean])(e: Expr): Boolean = {
    fold[Boolean]({(e, subs) => PartialFunction.cond(e)(matcher) || subs.contains(true)})(e)
  }

  /** Computes the negation of a boolean formula, with some simplifications. */
  def negate(expr: Expr): Expr = {
    // require(expr.getType == BooleanType)
    (expr match {
      case Not(e) => e
      case Implies(e1,e2) => and(e1, negate(e2))
      case Or(exs) => and(exs map negate: _*)
      case And(exs) => or(exs map negate: _*)
      case LessThan(e1,e2) => GreaterEquals(e1,e2)
      case LessEquals(e1,e2) => GreaterThan(e1,e2)
      case GreaterThan(e1,e2) => LessEquals(e1,e2)
      case GreaterEquals(e1,e2) => LessThan(e1,e2)
      case BooleanLiteral(b) => BooleanLiteral(!b)
      case e => Not(e)
    })
  }

  /** Replaces bottom-up sub-expressions by looking up for them in a map */
  def replace(substs: PartialFunction[Expr,Expr], applyRec: Boolean = false)(expr: Expr): Expr = {
    postMap(substs.lift, applyRec)(expr)
  }


  /**
    A term is an expression which (for our purposes) does not contain
    propositional logic connectives.
   */
  def isBooleanTerm(e: Expr): Boolean = e match {
    case GreaterEquals(_, _) | GreaterThan(_,_) | LessThan(_, _) | LessEquals(_,_) => true
    case Equals(_, _) => true
    case BooleanLiteral(_) => true
    case _ => false
  }

  /**
    * Returns size of the tree, counting the operators and the terminal nodes
    */
  def size(e: Expr): Int = e match {
    case Operator(es, _) =>
      es.map(size).sum + 1
  }
}
