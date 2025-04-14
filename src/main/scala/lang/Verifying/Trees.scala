// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import stainless.annotation._
import stainless.lang._

// These should be removed
object Trees {

  /** Represents an expression in Leon. */
  sealed trait Expr

  object Expr {

    // This is easily verified
    // Big problems come from And
    def complexity(expr: Expr) : BigInt = {
      decreases(expr)
      expr match
        case IntegerLiteral(value) => BigInt(1)
        case lang.Trees.Minus(lhs, rhs) => BigInt(1) + complexity(lhs) + complexity(rhs)
        case UMinus(expr) => BigInt(1) +complexity(expr)
        case lang.Trees.Times(lhs, rhs) => BigInt(1) +complexity(lhs) + complexity(rhs)
        case FMA(fac1, fac2, s) => BigInt(1) +complexity(fac1) + complexity(fac2) + complexity(s)
        case lang.Trees.Division(lhs, rhs) => BigInt(1) + complexity(lhs) + complexity(rhs)
        case lang.Trees.IntPow(base, exp) => BigInt(1) +complexity(base)
        case LessThan(lhs, rhs) => BigInt(1) +complexity(lhs) + complexity(rhs)
        case GreaterThan(lhs, rhs) => BigInt(1) + complexity(lhs) + complexity(rhs)
        case LessEquals(lhs, rhs) => BigInt(1)+ complexity(lhs) + complexity(rhs)
        case GreaterEquals(lhs, rhs) => BigInt(1) + complexity(lhs) + complexity(rhs)
      
    }.ensuring(res => res > 0)
  }


  /** $encodingof an infinite precision integer literal */
  case class IntegerLiteral(value: BigInt) extends Expr

  /** $encodingof `... -  ...` */
  case class Minus(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `- ... for BigInts` */
  case class UMinus(expr: Expr) extends Expr

  /** $encodingof `... * ...` */
  case class Times(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `(... * ...) + ...` */
  case class FMA(fac1: Expr, fac2: Expr, s: Expr) extends Expr

  /** $encodingof `... / ...` */
  case class Division(lhs: Expr, rhs: Expr) extends Expr 


  case class IntPow(base: Expr, exp: BigInt) extends Expr {
    require(exp >= 0)
  }
  /*  Comparisons */

  /** $encodingof `... < ...` */
  case class LessThan(lhs: Expr, rhs: Expr) extends Expr
  /** $encodingof `... > ...` */
  case class GreaterThan(lhs: Expr, rhs: Expr) extends Expr
  /** $encodingof `... <= ...` */
  case class LessEquals(lhs: Expr, rhs: Expr) extends Expr
  /** $encodingof `... >= ...` */
  case class GreaterEquals(lhs: Expr, rhs: Expr) extends Expr
}
