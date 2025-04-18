// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

import stainless.collection.*
import stainless.collection.List.*
import Trees.*
import TreeOps.*
import Trees.Helpers.*

object Constructors {
  /** $encodingof `&&`-expressions with arbitrary number of operands, and simplified.
   * @see [[lang.Trees.And And]]
   */
  def and(exprs: List[Expr]): Expr = {
    // mutable
    val flat : List[Expr] = exprs.flatMap {
      // This flattens and:s
      case And(lhs, rhs) => andConverter(And(lhs, rhs))
      case o => List(o)
    }

    // This code collects all except true literals or takes first false.

    // Immutable version
    val preSimpler:List[Expr] = flat.takeWhile(p => p != BooleanLiteral(false))

    val simpler = if (preSimpler.length == flat.length) {
      preSimpler
    } else {
      preSimpler ++ List(BooleanLiteral(false))
    }.filter(p => p != BooleanLiteral(true))

    // var stop = false
    // val simpler:List[Expr] = for(e <- flat if !stop && e != BooleanLiteral(true)) yield {
    //   if (e == BooleanLiteral(false)) {
    //     stop = true
    //   }
    //   e
    // }

    if (simpler.length == 0) BooleanLiteral(true)
    else if (simpler.length == 1) simpler.head
    else listToAnd(simpler)

  }

  /** $encodingof `&&`-expressions with arbitrary number of operands as a sequence, and simplified.
   * @see [[purescala.Expressions.And And]]
   */

  /** $encodingof `||`-expressions with arbitrary number of operands, and simplified.
   * @see [[purescala.Expressions.Or Or]]
   */
  def or(exprs: List[Expr]): Expr = {
    val flat = exprs.flatMap {
      case Or(rhs, lhs) => orConverter(Or(rhs, lhs))
      case o => List(o)
    }

    // Immutable Version
    val preSimpler:List[Expr] = flat.takeWhile(p => p != BooleanLiteral(true))

    val simpler = if (preSimpler.length == flat.length) {
      preSimpler
    } else {
      preSimpler ++ List(BooleanLiteral(true))
    }.filter(p => p != BooleanLiteral(false))

    // Mutable
    // var stop = false
    // val simpler:List[Expr] = for(e <- flat if !stop && e != BooleanLiteral(false)) yield {
    //   if (e == BooleanLiteral(true)) {
    //     stop = true
    //   }
    //   e
    // }

    // What are these other matches here?
    // This looks like the make method
    simpler match {
      case Nil()  => BooleanLiteral(false)
      case Cons(x, Nil()) => x
      case _      => listToOr(simpler)
    }
  }

  /** $encodingof `&&`-expressions with arbitrary number of operands as a sequence, and simplified.
   * @see [[purescala.Expressions.And And]]
   */
  def andJoin(es: List[Expr]): Expr = and(es)

  /** $encodingof `||`-expressions with arbitrary number of operands as a sequence, and simplified.
   * @see [[purescala.Expressions.Or Or]]
   */
  def orJoin(es: List[Expr]): Expr = or(es)

  /** $encodingof simplified `!`-expressions .
   * @see [[purescala.Expressions.Not Not]]
   */
  def not(e: Expr): Expr = negate(e)

  /** $encodingof simplified `... + ...` (plus).
   * @see [[purescala.Expressions.Plus Plus]]
   * @see [[purescala.Expressions.BVPlus BVPlus]]
   * @see [[purescala.Expressions.RealPlus RealPlus]]
   */
  def plus(lhs: Expr, rhs: Expr): Expr = (lhs, rhs) match {
    case (IntegerLiteral(bi), _) if bi == 0 => rhs
    case (_, IntegerLiteral(bi)) if bi == 0 => lhs
    case _ => Plus(lhs, rhs)
  }

  /** $encodingof simplified `... - ...` (minus).
   * @see [[purescala.Expressions.Minus Minus]]
   * @see [[purescala.Expressions.BVMinus BVMinus]]
   * @see [[purescala.Expressions.RealMinus RealMinus]]
   */
  def minus(lhs: Expr, rhs: Expr): Expr = (lhs, rhs) match {
    case (_, IntegerLiteral(bi)) if bi == 0 => lhs
    case (IntegerLiteral(bi), _) if bi == 0 => UMinus(rhs)
    // case (IntLiteral(0), _) => BVUMinus(rhs)
    // case (IsTyped(_, Int32Type), IsTyped(_, Int32Type)) => BVMinus(lhs, rhs)
    // case (IsTyped(_, RealType), IsTyped(_, RealType)) => RealMinus(lhs, rhs)
    case _ => Minus(lhs, rhs)
  }

  /** $encodingof simplified `... * ...` (times).
   * @see [[purescala.Expressions.Times Times]]
   * @see [[purescala.Expressions.BVTimes BVTimes]]
   * @see [[purescala.Expressions.RealTimes RealTimes]]
   */
  def times(lhs: Expr, rhs: Expr): Expr = (lhs, rhs) match {
    case (IntegerLiteral(bi), _) if bi == 1 => rhs
    case (_, IntegerLiteral(bi)) if bi == 1 => lhs
    case (IntegerLiteral(bi), _) if bi == 0 => IntegerLiteral(0)
    case (_, IntegerLiteral(bi)) if bi == 0 => IntegerLiteral(0)
    // case (IsTyped(_, Int32Type), IsTyped(_, Int32Type)) => BVTimes(lhs, rhs)
    // case (IsTyped(_, RealType), IsTyped(_, RealType)) => RealTimes(lhs, rhs)
    case _ => Times(lhs, rhs)
  }
}
