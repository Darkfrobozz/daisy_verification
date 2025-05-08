// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

import stainless.lang.*
import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation.*
import Trees.*
import Trees.Helpers.*
import Eval.*
import lang.Trees.Expr.getType
import lang.AndOptimization.*
import lang.OrOptimization.*
import lang.Eval.*
import lang.Typing.*

object Constructors {
  /** $encodingof `&&`-expressions with arbitrary number of operands, and simplified.
   * @see [[lang.Trees.And And]]
   */

  @library
  def and(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)

    AndOptimization.flattenConservationTheorem(e)
    AndOptimization.flattenComplexityPreserve(e)
    // mutable
    val flat : Expr = flatten(e)
    assert(eval(flat) == eval(e))

    typeInsurance(e)
    typeInsurance(flat)
    // This says that flatAndTakewhile of flat conserves value
    flatATWTConserve(flat)
    flatATWTSizeConserve(flat)
    // This code collects all except true literals or takes first false.
    val simpler = flatAndTakeWhileTrue(flat)
    assert(eval(simpler) == eval(e))

    simpler
  }.ensuring(res => eval(res) == eval(e) && complexity(res) <= complexity(e))
   
  /** $encodingof `&&`-expressions with arbitrary number of operands as a sequence, and simplified.
   * @see [[purescala.Expressions.And And]]
   */

  /** $encodingof `||`-expressions with arbitrary number of operands, and simplified.
   * @see [[purescala.Expressions.Or Or]]
   */

  
  @library
  def or(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)

    OrOptimization.flattenConservationTheorem(e)
    OrOptimization.flattenComplexityPreserve(e)
    // mutable
    val flat : Expr = flattenOr(e)
    assert(eval(flat) == eval(e))

    typeInsurance(e)
    typeInsurance(flat)
    // This says that flatAndTakewhile of flat conserves value
    flatOTWTConserveSize(flat)
    flatOTWTConserve(flat)
    // This code collects all except true literals or takes first false.
    val simpler = flatOrTakeWhileTrue(flat)
    assert(eval(simpler) == eval(e))

    simpler
  }.ensuring(res => eval(res) == eval(e) && complexity(res) <= complexity(e))


  /** Computes the negation of a boolean formula, with some simplifications. */
  @library
  def negate(expr: Expr): Expr = {
    require(inferredType(expr) == BooleanType)
    decreases(complexity(expr))
    (expr match {
      case Not(e) => e

      // todo: This here needs to be changed to the optimized and version later on
      // when and is proven to be correct, although given that and is correct this should be correct.
      // That is given that the semantics is preserved by and function.
      case Implies(e1,e2) => And(e1, negate(e2))
      case Or(lhs, rhs) => And(negate(lhs), negate(rhs))
      case And(lhs, rhs) => Or(negate(lhs), negate(rhs))

      
      case LessThan(e1,e2) => GreaterEquals(e1,e2)
      case LessEquals(e1,e2) => GreaterThan(e1,e2)
      case GreaterThan(e1,e2) => LessEquals(e1,e2)
      case GreaterEquals(e1,e2) => LessThan(e1,e2)
      case BooleanLiteral(b) => BooleanLiteral(!b)

      // I replaced e -> Not(e) to make things easier to reason on
      case DivisionError(tpe) => Not(DivisionError(tpe))
      case Equals(lhs, rhs) => Not(Equals(lhs, rhs))
    })
  }.ensuring(res => inferredType(res) == BooleanType)

  // def or(exprs: List[Expr]): Expr = {
  //   val flat = exprs.flatMap {
  //     case Or(rhs, lhs) => orConverter(Or(rhs, lhs))
  //     case o => List(o)
  //   }

  //   // Immutable Version
  //   val preSimpler:List[Expr] = flat.takeWhile(p => p != BooleanLiteral(true))

  //   val simpler = if (preSimpler.length == flat.length) {
  //     preSimpler
  //   } else {
  //     preSimpler ++ List(BooleanLiteral(true))
  //   }.filter(p => p != BooleanLiteral(false))

  //   // Mutable
  //   // var stop = false
  //   // val simpler:List[Expr] = for(e <- flat if !stop && e != BooleanLiteral(false)) yield {
  //   //   if (e == BooleanLiteral(true)) {
  //   //     stop = true
  //   //   }
  //   //   e
  //   // }

  //   // What are these other matches here?
  //   // This looks like the make method
  //   simpler match {
  //     case Nil()  => BooleanLiteral(false)
  //     case Cons(x, Nil()) => x
  //     case _      => listToOr(simpler)
  //   }
  // }

  /** $encodingof simplified `... + ...` (plus).
   * @see [[purescala.Expressions.Plus Plus]]
   * @see [[purescala.Expressions.BVPlus BVPlus]]
   * @see [[purescala.Expressions.RealPlus RealPlus]]
   */
  @library
  def plus(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (IntegerLiteral(bi), _) if bi == 0 => rhs
      case (_, IntegerLiteral(bi)) if bi == 0 => lhs
      case _ => Plus(lhs, rhs)
    }
  }.ensuring(res => complexity(res) <= complexity(Plus(lhs, rhs)))

  
  /** $encodingof simplified `... - ...` (minus).
   * @see [[purescala.Expressions.Minus Minus]]
   * @see [[purescala.Expressions.BVMinus BVMinus]]
   * @see [[purescala.Expressions.RealMinus RealMinus]]
   */
  @library
  def minus(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (_, IntegerLiteral(bi)) if bi == 0 => lhs
      case (IntegerLiteral(bi), _) if bi == 0 => UMinus(rhs)
      case _ => Minus(lhs, rhs)
    }
  }.ensuring(res => complexity(res) <= complexity(Minus(lhs, rhs)))

  
  /** $encodingof simplified `... * ...` (times).
   * @see [[purescala.Expressions.Times Times]]
   * @see [[purescala.Expressions.BVTimes BVTimes]]
   * @see [[purescala.Expressions.RealTimes RealTimes]]
   */
  @library
  def times(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (IntegerLiteral(bi), _) if bi == 1 => rhs
      case (_, IntegerLiteral(bi)) if bi == 1 => lhs
      // case (IntegerLiteral(bi), _) if bi == 0 => IntegerLiteral(0)
      // case (_, IntegerLiteral(bi)) if bi == 0 => IntegerLiteral(0)
      case _ => Times(lhs, rhs)
    }
  }.ensuring(res => complexity(res) <= complexity(Times(lhs, rhs)))
}
