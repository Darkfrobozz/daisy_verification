package lang

import stainless.collection.*
import stainless.collection.List.*
import stainless.annotation._

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
}
