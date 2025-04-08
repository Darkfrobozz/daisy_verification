// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation._
import ListsTheorems._

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
    def getType : TypeTree
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
  }

  /* Stands for an undefined Expr, similar to `???` or `null`
   *
   * During code generation, it gets compiled to `null`, or the 0 of the
   * respective type for value types.
   */
  case class NoTree(tpe: TypeTree) extends Expr {
    def getType = tpe
  }

  /** Literals */
  sealed trait Literal extends Expr {
  }

  /** $encodingof an infinite precision integer literal */
  case class IntegerLiteral(value: BigInt) extends Literal {
    def getType = IntegerType
  }

  /** $encodingof a boolean literal '''true''' or '''false''' */
  case class BooleanLiteral(value: Boolean) extends Literal{
    def getType = BooleanType
  }

  /** $encodingof the unit literal `()` */
  case class UnitLiteral() extends Literal {
    def getType = UnitType
  }

  /* Propositional logic */

  /** $encodingof `... == ...` */
  case class Equals(lhs: Expr, rhs: Expr) extends Expr {
    def getType = {
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
  case class And(exprs: List[Expr]) extends Expr {
    require(exprs.size >= 2)
    def getType = {
      if (exprs.forall(_.getType == BooleanType)) {
        BooleanType
      } else {
        Untyped
      }
    }
  }


  object And {
    def apply(a: Expr, b: Expr): Expr = {
      list_size(a, b)
      val k = List(a, b)
      // It can't prove the size of the list...
      assert(k.head == a)
      assert(k.tail.head == b)
      assert(k.size == 2)
      And(k)
    }

    def apply(exprs: List[Expr]) = {
      require(exprs.size >= 2)
      new And(exprs)
    }

    def make(exprs: List[Expr]): Expr = exprs match {
      case Nil() => BooleanLiteral(true)
      case Cons(e, Nil()) => e
      case Cons(_, Cons(_, _)) => {
        listOfForm(exprs)
        assert(exprs.size >= 2)
        new And(exprs)
      }
    }
  }

  /** $encodingof `... || ...`
   *
   * [[exprs]] must contain at least two elements; if you are not sure about this,
   * you should use [[purescala.Constructors#or purescala's constructor or]] or
   * [[purescala.Constructors#orJoin purescala's constructor orJoin]]
   */
  case class Or(exprs: List[Expr]) extends Expr {
    def getType = {
      if (exprs.forall(_.getType == BooleanType)) {
        BooleanType
      } else {
        Untyped
      }
    }
  }

  object Or {
    def apply(a: Expr, b: Expr): Expr = {
      list_size(a, b)
      Or(List(a, b))
    }
    def apply(exprs: List[Expr]) = {
      require(exprs.size >= 2)
      new Or(exprs)
    }
  }

  /** $encodingof `... ==> ...` (logical implication).
   *
   * This is not a standard Scala operator, but it results from an implicit
   * conversion in the Leon library.
   *
   * @see [[leon.purescala.Constructors.implies]]
   */
  case class Implies(lhs: Expr, rhs: Expr) extends Expr {
    def getType = {
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
    def getType = {
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
    def getType = lhs.getType
  }

  /** $encodingof `... -  ...` */
  case class Minus(lhs: Expr, rhs: Expr) extends Expr {
    def getType = lhs.getType
  }

  /** $encodingof `- ... for BigInts` */
  case class UMinus(expr: Expr) extends Expr {
    def getType = expr.getType
  }

  /** $encodingof `... * ...` */
  case class Times(lhs: Expr, rhs: Expr) extends Expr {
    def getType = lhs.getType
  }

  /** $encodingof `(... * ...) + ...` */
  case class FMA(fac1: Expr, fac2: Expr, s: Expr) extends Expr {
    def getType = fac1.getType
  }

  /** $encodingof `... / ...` */
  case class Division(lhs: Expr, rhs: Expr) extends Expr {
    def getType = lhs.getType
  }


  case class IntPow(base: Expr, exp: BigInt) extends Expr {
    override def getType: TypeTree = base.getType
  }

  object IntPow {
    def apply(base: Expr, exp: BigInt) = {
      require(exp > 0)
      new IntPow(base, exp)
    }

  }


  /*  Comparisons */

  /** $encodingof `... < ...` */
  case class LessThan(lhs: Expr, rhs: Expr) extends Expr {
    def getType = BooleanType
  }
  /** $encodingof `... > ...` */
  case class GreaterThan(lhs: Expr, rhs: Expr) extends Expr {
    def getType = BooleanType
  }
  /** $encodingof `... <= ...` */
  case class LessEquals(lhs: Expr, rhs: Expr) extends Expr {
    def getType = BooleanType
  }
  /** $encodingof `... >= ...` */
  case class GreaterEquals(lhs: Expr, rhs: Expr) extends Expr {
    def getType = BooleanType
  }
}
