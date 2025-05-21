// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import stainless.collection.*
import stainless.collection.List.*
import stainless.collection.ListOps
import stainless.annotation.*
import stainless.lang.*

// These should be removed
object Trees {
  sealed trait TypeTree

  case object Untyped extends TypeTree
  case object BooleanType extends TypeTree
  case object UnitType extends TypeTree
  case object IntegerType extends TypeTree

  // sealed trait Tree {
  //   def getType : TypeTree
  // }

  /** Represents an expression in Leon. */
  sealed trait Expr

  object Helpers {
    // @library
    def complexity(expr: Expr) : BigInt = {
      decreases(expr)
      BigInt(1) + (expr match
        case _: Terminal => 0
        case And(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Or(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Equals(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Implies(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Not(expr) => complexity(expr)
        case Plus(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Minus(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case UMinus(expr) => complexity(expr)
        case Times(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case FMA(fac1, fac2, s) => complexity(fac1) + complexity(fac2) + complexity(s)
        case Division(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case IntPow(base, exp) => complexity(base)
        case LessThan(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case GreaterThan(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case LessEquals(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case GreaterEquals(lhs, rhs) => complexity(lhs) + complexity(rhs)) 
    }.ensuring(res => res > 0)
    
  }

  object Expr {
    def Plus(t: Expr, that: Expr): Expr = Trees.Plus(t, that)
    def Minus(t: Expr, that: Expr): Expr = Trees.Minus(t, that)
    def Times(t: Expr, that: Expr): Expr = Trees.Times(t, that)
    def Division(t: Expr, that: Expr): Expr = Trees.Division(t, that)
    def IntPow(t: Expr, n: BigInt): Expr = {
      require(n > 0)
      Trees.IntPow(t, n)
    }

    // @library
    def getType(expr: Expr) : TypeTree = {
      expr match
        case IntegerLiteral(value) => IntegerType
        case BooleanLiteral(value) => BooleanType
        case UnitLiteral() => UnitType
        case DivisionError(tpe) => tpe match
          case UnitType => Untyped
          case _ => tpe
        case TypeError() => Untyped
        case LessThan(lhs, rhs) => BooleanType
        case GreaterThan(lhs, rhs) => BooleanType
        case LessEquals(lhs, rhs) => BooleanType
        case GreaterEquals(lhs, rhs) => BooleanType  
        case Equals(lhs, rhs) => if (getType(lhs) == getType(rhs)) BooleanType else Untyped 
        // This should assume that list terminates
        case And(lhs, rhs) => BooleanType
        case Or(lhs, rhs) => BooleanType
        case Implies(lhs, rhs) => if (getType(lhs) == BooleanType && getType(rhs) == BooleanType) BooleanType else Untyped
        case Not(expr) => if (getType(expr) == BooleanType) BooleanType else Untyped
        case Plus(lhs, rhs) => getType(lhs)
        case Minus(lhs, rhs) => getType(lhs)
        case UMinus(expr) => getType(expr)
        case Times(lhs, rhs) => getType(lhs)
        case FMA(fac1, fac2, s) => getType(fac1)
        case Division(lhs, rhs) => getType(lhs)
        case IntPow(base, exp) => getType(base)
    }
  }

  sealed trait Terminal extends Expr
  /** $encodingof an infinite precision integer literal */
  case class IntegerLiteral(value: BigInt) extends Terminal

  /** $encodingof a boolean literal '''true''' or '''false''' */
  case class BooleanLiteral(value: Boolean) extends Terminal

  /** $encodingof the unit literal `()` */
  case class UnitLiteral() extends Terminal

  // TypeError
  // DivisionError
  case class TypeError() extends Terminal

  case class DivisionError(tpe: TypeTree) extends Terminal

  /* Propositional logic */

  /** $encodingof `... == ...` */
  case class Equals(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `... && ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#and purescala's constructor and]]
   * or [[purescala.Constructors#andJoin purescala's constructor andJoin]]
   */
  case class And(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `... || ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#or purescala's constructor or]] or
   * [[purescala.Constructors#orJoin purescala's constructor orJoin]]
   */
  case class Or(lhs : Expr, rhs: Expr) extends Expr


  /** $encodingof `... ==> ...` (logical implication).
   *
   * This is not a standard Scala operator, but it results from an implicit
   * conversion in the Leon library.
   *
   * @see [[leon.purescala.Constructors.implies]]
   */
  case class Implies(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `!...`
   *
   * @see [[leon.purescala.Constructors.not]]
   */
  case class Not(expr: Expr) extends Expr

  /* Arithmetic */

  /** $encodingof `... +  ...` */
  case class Plus(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `... -  ...` */
  case class Minus(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `- ... for BigInts` */
  case class UMinus(expr: Expr) extends Expr

  /** $encodingof `... * ...` */
  case class Times(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `(... * ...) + ...` */
  case class FMA(fac1: Expr, fac2: Expr, s: Expr) extends Expr


  // Binaries with ints, this is to control for arthimetic problems
  /** $encodingof `... / ...` */
  case class Division(lhs: Expr, rhs: Expr) extends Expr 


  case class IntPow(base: Expr, exp: BigInt) extends Expr

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
