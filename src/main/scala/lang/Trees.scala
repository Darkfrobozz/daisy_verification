// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation._
import ListsTheorems._
import stainless.lang._

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
  sealed trait Expr {
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

    @library
    def complexity(@induct expr: Expr) : BigInt = {
      BigInt(1) + (expr match
        case IntegerLiteral(value) => 0
        case BooleanLiteral(value) => 0
        case UnitLiteral() => 0
        case And(exprs) => 0
        case Or(exprs) => 0
        case Equals(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Implies(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Not(expr) => complexity(expr)
        case lang.Trees.Plus(lhs, rhs) => complexity(lhs)
        case lang.Trees.Minus(lhs, rhs) => complexity(lhs)
        case UMinus(expr) => complexity(expr)
        case lang.Trees.Times(lhs, rhs) => complexity(lhs)
        case FMA(fac1, fac2, s) => complexity(fac1)
        case lang.Trees.Division(lhs, rhs) => complexity(lhs)
        case lang.Trees.IntPow(base, exp) => complexity(base)
        case LessThan(lhs, rhs) => 0
        case GreaterThan(lhs, rhs) => 0
        case LessEquals(lhs, rhs) => 0
        case GreaterEquals(lhs, rhs) => 0)
      
    }.ensuring(res => res > 0)

    def getType(expr: Expr) : TypeTree = {
      decreases(1, complexity(expr))
      expr match
        case IntegerLiteral(value) => IntegerType
        case BooleanLiteral(value) => BooleanType
        case UnitLiteral() => UnitType
        case LessThan(lhs, rhs) => BooleanType
        case GreaterThan(lhs, rhs) => BooleanType
        case LessEquals(lhs, rhs) => BooleanType
        case GreaterEquals(lhs, rhs) => BooleanType  
        case Equals(lhs, rhs) => if (getType(lhs) == getType(rhs)) BooleanType else Untyped 
        // This should assume that list terminates
        case And(exprs) => getListType(exprs)
        case Or(exprs) => getListType(exprs)
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

    def getListType(lExpr: List[Expr]) : TypeTree = {
      // When this calls getType, getType can call it...
      decreases(0, lExpr.size)
      lExpr match
        // This should assume that getType terminates
        case Cons(h, t) => if (getType(h) == getListType(t) && getType(h) == BooleanType) BooleanType else Untyped 
        case Nil() => BooleanType
      }

    
  }

  /* Stands for an undefined Expr, similar to `???` or `null`
   *
   * During code generation, it gets compiled to `null`, or the 0 of the
   * respective type for value types.
   */

  /** $encodingof an infinite precision integer literal */
  case class IntegerLiteral(value: BigInt) extends Expr

  /** $encodingof a boolean literal '''true''' or '''false''' */
  case class BooleanLiteral(value: Boolean) extends Expr

  /** $encodingof the unit literal `()` */
  case class UnitLiteral() extends Expr

  /* Propositional logic */

  /** $encodingof `... == ...` */
  case class Equals(lhs: Expr, rhs: Expr) extends Expr

  /** $encodingof `... && ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#and purescala's constructor and]]
   * or [[purescala.Constructors#andJoin purescala's constructor andJoin]]
   */
  case class And(exprs: List[Expr]) extends Expr {
    // require(exprs.size >= 2)
  }


  // object And {
  //   def apply(a: Expr, b: Expr): Expr = {
  //     list_size(a, b)
  //     val k = List(a, b)
  //     // It can't prove the size of the list...
  //     assert(k.head == a)
  //     assert(k.tail.head == b)
  //     assert(k.size == 2)
  //     And(k)
  //   }

  //   def apply(exprs: List[Expr]) = {
  //     require(exprs.size >= 2)
  //     new And(exprs)
  //   }

  //   def make(exprs: List[Expr]): Expr = exprs match {
  //     case Nil() => BooleanLiteral(true)
  //     case Cons(e, Nil()) => e
  //     case Cons(_, Cons(_, _)) => {
  //       listOfForm(exprs)
  //       assert(exprs.size >= 2)
  //       new And(exprs)
  //     }
  //   }

  //   def unapply(e: Expr): Option[List[Expr]] = {
  //     e match
  //       case t : And => Some(t.exprs)
  //       case _ => None()
  //   }
  // }

  /** $encodingof `... || ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#or purescala's constructor or]] or
   * [[purescala.Constructors#orJoin purescala's constructor orJoin]]
   */
  case class Or(exprs: List[Expr]) extends Expr {
    // require(exprs.size >= 2)
  }

  // object Or {
  //   def apply(a: Expr, b: Expr): Expr = {
  //     list_size(a, b)
  //     Or(List(a, b))
  //   }
  //   def apply(exprs: List[Expr]) = {
  //     require(exprs.size >= 2)
  //     new Or(exprs)
  //   }

  //   def unapply(e: Expr): Option[List[Expr]] = {
  //     e match
  //       case t : Or => Some(t.exprs)
  //       case _ => None() 
  //   }
  // }

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

  /** $encodingof `... / ...` */
  case class Division(lhs: Expr, rhs: Expr) extends Expr 


  case class IntPow(base: Expr, exp: BigInt) extends Expr

  // object IntPow {
  //   def apply(base: Expr, exp: BigInt) = {
  //     require(exp > 0)
  //     new IntPow(base, exp)
  //   }

  //   def unapply(e: Expr): Option[(Expr, BigInt)] = {
  //     e match
  //       case t : IntPow => Some(t.base, t.exp) 
  //       case _ => None()
  //   }

  // }


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
