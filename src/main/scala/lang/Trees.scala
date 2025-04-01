// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import scala.collection.immutable.Seq

import Types._
import Identifiers._

// These should be removed
object Trees {

  abstract class Tree

  /** Represents an expression in Leon. */
  sealed abstract class Expr extends Tree with Typed {
    def Plus(that: Expr): Expr = Trees.Plus(this, that)
    def Minus(that: Expr): Expr = Trees.Minus(this, that)
    def Times(that: Expr): Expr = Trees.Times(this, that)
    def Division(that: Expr): Expr = Trees.Division(this, that)
//    def Pow(that: Expr): Expr = Trees.Pow(this, that)
    def IntPow(n: Int): Expr = Trees.IntPow(this, n)
  }

  /** Trait which gets mixed-in to expressions without subexpressions */
  trait Terminal {
    self: Expr =>
  }

  /** Stands for an undefined Expr, similar to `???` or `null`
   *
   * During code generation, it gets compiled to `null`, or the 0 of the
   * respective type for value types.
   */
  case class NoTree(tpe: TypeTree) extends Expr with Terminal {
    val getType = tpe
  }

  /** Literals */
  sealed abstract class Literal[+T] extends Expr with Terminal {
    val value: T
  }

  /** $encodingof an infinite precision integer literal */
  case class IntegerLiteral(value: BigInt) extends Literal[BigInt] {
    val getType = IntegerType
  }

  /** $encodingof a boolean literal '''true''' or '''false''' */
  case class BooleanLiteral(value: Boolean) extends Literal[Boolean] {
    val getType = BooleanType
  }

  /** $encodingof the unit literal `()` */
  case class UnitLiteral() extends Literal[Unit] {
    val getType = UnitType
    val value = ()
  }

  /* Propositional logic */

  /** $encodingof `... == ...` */
  case class Equals(lhs: Expr, rhs: Expr) extends Expr {
    val getType = {
      if (lhs.getType == rhs.getType) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  /** $encodingof `... && ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#and purescala's constructor and]]
   * or [[purescala.Constructors#andJoin purescala's constructor andJoin]]
   */
  case class And(exprs: Seq[Expr]) extends Expr {
    require(exprs.size >= 2)
    val getType = {
      if (exprs forall (_.getType == BooleanType)) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  object And {
    def apply(a: Expr, b: Expr): Expr = And(Seq(a, b))

    def make(exprs: Seq[Expr]): Expr = exprs match {
      case Seq() => BooleanLiteral(true)
      case Seq(e) => e
      case _ => new And(exprs)
    }
  }

  /** $encodingof `... || ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#or purescala's constructor or]] or
   * [[purescala.Constructors#orJoin purescala's constructor orJoin]]
   */
  case class Or(exprs: Seq[Expr]) extends Expr {
    require(exprs.size >= 2)
    val getType = {
      if (exprs forall (_.getType == BooleanType)) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  object Or {
    def apply(a: Expr, b: Expr): Expr = Or(Seq(a, b))
  }

  /** $encodingof `... ==> ...` (logical implication).
   *
   * This is not a standard Scala operator, but it results from an implicit
   * conversion in the Leon library.
   *
   * @see [[leon.purescala.Constructors.implies]]
   */
  case class Implies(lhs: Expr, rhs: Expr) extends Expr {
    val getType = {
      if (lhs.getType == BooleanType && rhs.getType == BooleanType) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  /** $encodingof `!...`
   *
   * @see [[leon.purescala.Constructors.not]]
   */
  case class Not(expr: Expr) extends Expr {
    val getType = {
      if (expr.getType == BooleanType) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  /* Arithmetic */

  /** $encodingof `... +  ...` */
  case class Plus(lhs: Expr, rhs: Expr) extends Expr {
    val getType = lhs.getType
  }

  /** $encodingof `... -  ...` */
  case class Minus(lhs: Expr, rhs: Expr) extends Expr {
    val getType = lhs.getType
  }

  /** $encodingof `- ... for BigInts` */
  case class UMinus(expr: Expr) extends Expr {
    val getType = expr.getType
  }

  /** $encodingof `... * ...` */
  case class Times(lhs: Expr, rhs: Expr) extends Expr {
    val getType = lhs.getType
  }

  /** $encodingof `(... * ...) + ...` */
  case class FMA(fac1: Expr, fac2: Expr, s: Expr) extends Expr {
    val getType = fac1.getType
  }

  /** $encodingof `... / ...` */
  case class Division(lhs: Expr, rhs: Expr) extends Expr {
    val getType = lhs.getType
  }


  case class IntPow(base: Expr, exp: Int) extends Expr {
    assert(exp > 0)
    override val getType: TypeTree = base.getType
  }


  /*  Comparisons */

  /** $encodingof `... < ...` */
  case class LessThan(lhs: Expr, rhs: Expr) extends Expr {
    val getType = BooleanType
  }
  /** $encodingof `... > ...` */
  case class GreaterThan(lhs: Expr, rhs: Expr) extends Expr {
    val getType = BooleanType
  }
  /** $encodingof `... <= ...` */
  case class LessEquals(lhs: Expr, rhs: Expr) extends Expr {
    val getType = BooleanType
  }
  /** $encodingof `... >= ...` */
  case class GreaterEquals(lhs: Expr, rhs: Expr) extends Expr {
    val getType = BooleanType
  }
}
