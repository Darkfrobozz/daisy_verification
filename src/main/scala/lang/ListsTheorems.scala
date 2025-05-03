package lang

import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation._
import lang.Trees._

object ListsTheorems { 
  @opaque
  @library
  def list_size[T](a: T, b : T) = {

  }.ensuring(List(a, b).size == 2)

  @opaque
  @library
  def listsizePositive[T](l : List[T]) = {

  }.ensuring(l.size >= 0)

  @opaque
  @library
  def listOfForm[T](l : List[T]) = {
    require(l match
        case Cons(_, Cons(_, _)) => true
        case _ => false
    )

  }.ensuring(l.size >= 2)

  @opaque
  @library
  def addedLists(l1 : List[Expr], l2 : List[Expr], t : Expr => Boolean) : Unit = {
    require(l1.forall(t) && l2.forall(t))
    l1 match
      case Cons(h, tl) =>
        assert(t(h))
        addedLists(tl, l2, t)
      case Nil() =>
        assert(l2.forall(t))  
  }.ensuring((l1 ++ l2).forall(t))
}
