// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

import Trees._
import Constructors._
import Extractors._

import stainless.collection.*
import stainless.collection.List.*
/**
  Various useful functions for manipulating trees.
 */
object TreeOps {

  // Returns all sub-expression in an expression in a list
  def getSubExpr(e: Expr): List[Expr] = {
    val Operator(es, _) = e
    if(es.size >0){
      es.flatMap(getSubExpr(_)) :+ e
    } else {
      List()
    }
  }

  /** Computes the negation of a boolean formula, with some simplifications. */
  def negate(expr: Expr): Expr = {
    // require(expr.getType == BooleanType)
    (expr match {
      case Not(e) => e
      case Implies(e1,e2) => and(List(e1, negate(e2)))
      case Or(lhs, rhs) => and(List(negate(lhs), negate(rhs)))
      case And(lhs, rhs) => and(List(negate(lhs), negate(rhs)))
      case LessThan(e1,e2) => GreaterEquals(e1,e2)
      case LessEquals(e1,e2) => GreaterThan(e1,e2)
      case GreaterThan(e1,e2) => LessEquals(e1,e2)
      case GreaterEquals(e1,e2) => LessThan(e1,e2)
      case BooleanLiteral(b) => BooleanLiteral(!b)
      case e => Not(e)
    })
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
  def size(e: Expr): BigInt = e match {

    // This takes List of subexpressions finds the size of each their subexpressions and then add them up
    case Operator(es, _) =>
      es.map(size).foldLeft(BigInt(0))((ack, i) => ack + i) + 1
  }
}
