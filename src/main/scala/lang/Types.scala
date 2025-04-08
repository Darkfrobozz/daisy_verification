// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany
package lang



// This should be removed

import Trees._

object Types {

  trait Typed {
    val getType: TypeTree
    def isTyped: Boolean = getType != Untyped
  }

  abstract class TypeTree extends Tree with Typed {
    val getType = this

    // Checks whether the subtypes of this type contain Untyped,
    // and if so sets this to Untyped.
    // Assumes the subtypes are correctly formed, so it does not descend
    // deep into the TypeTree.
    def deepCopy: TypeTree = this
  }

  case object Untyped extends TypeTree
  case object BooleanType extends TypeTree
  case object UnitType extends TypeTree
  case object IntegerType extends TypeTree
}