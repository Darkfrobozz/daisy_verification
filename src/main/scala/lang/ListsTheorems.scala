package lang

import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation._
import lang.Trees._

object ListsTheorems { 
  @opaque
  def list_size[T](a: T, b : T) = {

  }.ensuring(List(a, b).size == 2)

  @opaque
  def listsizePositive[T](l : List[T]) = {

  }.ensuring(l.size >= 0)

  @opaque
  def listOfForm[T](l : List[T]) = {
    require(l match
        case Cons(_, Cons(_, _)) => true
        case _ => false
    )

  }.ensuring(l.size >= 2)


  @opaque
  def treeSize(e: Expr) : BigInt = {
    BigInt(1) + (e match
      case NoTree(tpe) => 0
      case IntegerLiteral(value) => 0
      case BooleanLiteral(value) => 0
      case UnitLiteral() => 0
      case Equals(lhs, rhs) => treeSize(lhs) + treeSize(rhs) 
      // These will make things difficult...
      case And(exprs) => 1
        // exprs.map(treeSize).foldLeft(BigInt(0))((ack, i) => ack + i)
      case Or(exprs) => 1
        // exprs.map(treeSize).foldLeft(BigInt(0))((ack, i) => ack + i)
      case Implies(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case Not(expr) => treeSize(expr)
      case Plus(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case Minus(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case UMinus(expr) => treeSize(expr)
      case Times(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case FMA(fac1, fac2, s) => treeSize(fac1) + treeSize(fac2) + treeSize(s)
      case Division(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case IntPow(base, exp) => 1
        // treeSize(base)
      case LessThan(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case GreaterThan(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case LessEquals(lhs, rhs) => treeSize(lhs) + treeSize(rhs)
      case GreaterEquals(lhs, rhs) => treeSize(lhs) + treeSize(rhs))
  }.ensuring(res => res > 0)

}
