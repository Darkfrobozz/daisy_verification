// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang

// This should be replaced with list
import stainless.collection.*
import stainless.collection.List.*
import stainless.collection.ListOps
import stainless.annotation.*
import stainless.lang.*
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
  sealed trait Expr

  object Helpers {
    // We should try to make this into a flat list that contains all possible Ands.
    /**
          * This should give us a flatmap for all the ands present.
          * This can be applied for each loop.
          *
          * @param expr
          * @return
          */
    @library
    def andConverter(expr: Expr) : List[Expr] = {
      decreases(complexity(expr))
      require(expr match
        case And(lhs, rhs) => true
        case _ => false
      )
      expr match {
        case And(lhs, rhs) => (lhs, rhs) match
          case (And(_, _), And(_, _)) => 
            addedLists(andConverter(lhs), andConverter(rhs), p => p match {
              case And(_, _) => false
              case _ => true
            })
            andConverter(lhs) ++ andConverter(rhs)
          case (And(_, _), _) => Cons(rhs, andConverter(lhs))
          case (_, And(_, _)) => Cons(lhs, andConverter(rhs))
          case _ => Cons(lhs, Cons(rhs, Nil()))
      }
    }.ensuring(res => res.forall(p => p match
      case And(_, _) => false
      case _ => true
    ))

    @library
    def orConverter(expr: Expr) : List[Expr] = {
      decreases(complexity(expr))
      require(expr match
        case Or(lhs, rhs) => true
        case _ => false
      )
      expr match {
        case Or(lhs, rhs) => (lhs, rhs) match
          case (Or(_, _), Or(_, _)) => 
            addedLists(orConverter(lhs), orConverter(rhs), p => p match {
              case Or(_, _) => false
              case _ => true
            })
            orConverter(lhs) ++ orConverter(rhs)
          case (Or(_, _), _) => Cons(rhs, orConverter(lhs))
          case (_, Or(_, _)) => Cons(lhs, orConverter(rhs))
          case _ => Cons(lhs, Cons(rhs, Nil()))
      }
    }.ensuring(res => res.forall(p => p match
      case Or(_, _) => false
      case _ => true
    ))

    @library
    def listToAnd(l: List[Expr]) : Expr = {
      require(l.size >= 2)
      decreases(l.size)
      l match
        case Cons(h, t) => t match
          case Cons(h2, t2) => t2 match
            case Cons(h3, t3) => And(h, listToAnd(t))
            case Nil() => And(h, h2) 
    }

    @library
    def listToOr(l: List[Expr]) : Expr = {
      require(l.size >= 2)
      decreases(l.size)
      l match
        case Cons(h, t) => t match
          case Cons(h2, t2) => t2 match
            case Cons(h3, t3) => Or(h, listToAnd(t))
            case Nil() => Or(h, h2) 
    }

    // This is easily verified
    // Big problems come from And
    @library
    def complexity(@induct expr: Expr) : BigInt = {
      BigInt(1) + (expr match
        case IntegerLiteral(value) => 0
        case BooleanLiteral(value) => 0
        case UnitLiteral() => 0
        case And(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Or(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Equals(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Implies(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case Not(expr) => complexity(expr)
        case lang.Trees.Plus(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case lang.Trees.Minus(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case UMinus(expr) => complexity(expr)
        case lang.Trees.Times(lhs, rhs) => complexity(lhs) + complexity(rhs)
        case FMA(fac1, fac2, s) => complexity(fac1) + complexity(fac2) + complexity(s)
        case lang.Trees.Division(lhs, rhs) => complexity(lhs)
        case lang.Trees.IntPow(base, exp) => complexity(base)
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

    @library
    def getType(expr: Expr) : TypeTree = {
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
