import lang.Trees._
import lang.Constructors.times
import lang.Constructors
import lang.TreeOps._
import lang.TreeOps
import lang.Eval.eval
import lang.Trees.Helpers.*

import stainless.collection.*
import stainless.collection.List.*
import lang.IntResult
import lang.TypeErr
import lang.Typing.inferredType
import lang.ArthErr
// For more information on writing tests, see
// https://scalameta.org/munit/docs/getting-started.html

class MyFocusSuite extends munit.FunSuite {
}
  
class MySuite extends munit.FunSuite {
  test("Testing 5 * 1") {
    val k = Times(IntegerLiteral(5), IntegerLiteral(1))
    assertEquals(Constructors.times(k.lhs, k.rhs), IntegerLiteral(5))
  }

  def transform(e : Expr) : Option[Expr] = {
    e match
      case Minus(lhs, rhs) => Some(rhs)
      case IntegerLiteral(3) => Some(IntegerLiteral(2))
      case _ => None 
  }


  // test("Testing  PostMap 5 - (4 - 2) => 5 - 2") {
  //   val k = Plus(IntegerLiteral(5), Minus(IntegerLiteral(4), IntegerLiteral(3)))
  //   val res1 = TreeOps.postMap(transform, false)(k)
  //   assertEquals(res1, Plus(IntegerLiteral(5), IntegerLiteral(2)))
  // }

  def transform2(e : Expr) : Option[Expr] = {
    e match
      case Minus(IntegerLiteral(4), IntegerLiteral(3)) => Some(IntegerLiteral(1))
      case Minus(IntegerLiteral(7), IntegerLiteral(3)) => Some(IntegerLiteral(4))
      case IntegerLiteral(4) => Some(IntegerLiteral(7))
      case _ => None 
  }

  test("Testing andConverter 1") {
    val a = BooleanLiteral(true)
    val b = BooleanLiteral(true)
    val c = BooleanLiteral(true)
    val d = BooleanLiteral(false)
    val res1 = andConverter(And(a,And(b, And(c, d))))
    assertEquals(res1, List[Expr](a, b, c, d))
  }

  // test("Testing  PostMap example") {
  //   val a = IntegerLiteral(5)
  //   val b = IntegerLiteral(4)
  //   val c = IntegerLiteral(3)
  //   val d = IntegerLiteral(7)
  //   val k = Plus(a, Minus(b, c))
  //   val res1 = TreeOps.postMap(transform2, false)(k)
  //   assertEquals(res1, Plus(a, b))
  // }

  test("Testing and optimization 1") {
    val a = BooleanLiteral(true)
    val b = BooleanLiteral(true)
    val c = BooleanLiteral(true)
    val d = BooleanLiteral(false)
    val res1 = Constructors.and(List(a, b, c, d))
    assertEquals(res1, BooleanLiteral(false))
  }


  test("Testing and optimization 2") {
    val a = BooleanLiteral(true)
    val b = BooleanLiteral(true)
    val c = BooleanLiteral(true)
    val d = listToAnd(List(a, b, c, BooleanLiteral(false)))
    val e = BooleanLiteral(false)
    val res1 = Constructors.and(List(a, b, c, d, e))
    assertEquals(res1, BooleanLiteral(false))
  }

  test("Testing and optimization 3") {
    val a = BooleanLiteral(true)
    val b = BooleanLiteral(true)
    val c = BooleanLiteral(true)
    val d = BooleanLiteral(false)
    val res1 = Constructors.and(List(a, b, c, a, listToAnd(List(a, b, c, d))))
    assertEquals(res1, BooleanLiteral(false))
  }

  test("Testing or optimization") {
    val a = BooleanLiteral(false)
    val b = BooleanLiteral(false)
    val c = BooleanLiteral(true)
    val d = BooleanLiteral(false)
    val res1 = Constructors.or(List(a, b, c, d))
    assertEquals(res1, BooleanLiteral(true))
  }

  test("Subexpressions from Plus") {
    val a = IntegerLiteral(5)
    val b = IntegerLiteral(4)
    val res1 = TreeOps.getSubExpr(Plus(a, b))
    assertEquals(res1, List[Expr](Plus(a,b)))
  }


  test("Using eval") {
    val a = IntegerLiteral(5)
    val b = IntegerLiteral(4)
    assertEquals(eval(Plus(a, b)), IntResult(BigInt(9)))
  }

  test("Counter-example: -1 => 1") {
    val a = IntegerLiteral(-1)
    val b = IntegerLiteral(1)
    assertEquals(eval(Implies(a, b)), TypeErr)
    assertEquals(inferredType(Implies(a,b)), Untyped)
  }
// [Warning ]   e: Expr -> Equals(Equals(IntegerLiteral(BigInt("1")), IntegerLiteral(BigInt("0"))), Equals(IntegerLiteral(BigInt("3")), IntegerLiteral(BigInt("5"))))
  test("Counter-example: ((1 == 0) == (3 == 5))") {
    val counter = Equals(Equals(IntegerLiteral(BigInt(1)), IntegerLiteral(BigInt(0))), Equals(IntegerLiteral(BigInt(3)), IntegerLiteral(BigInt(5))))    

    assertEquals(eval(counter), TypeErr)
    assertEquals(inferredType(counter), Untyped)
  }

  
  test("Counter-example: ((1 / 0) < (3 / 0) || (1 / 0) < (3 / 0))") {
    val counter = Or(
      LessThan(Division(IntegerLiteral(BigInt(1)), IntegerLiteral(BigInt(0))), Division(IntegerLiteral(BigInt(3)), IntegerLiteral(BigInt(0)))),
      LessThan(Division(IntegerLiteral(BigInt(1)), IntegerLiteral(BigInt(0))), Division(IntegerLiteral(BigInt(3)), IntegerLiteral(BigInt(0))))
    )    

    assertEquals(eval(counter), ArthErr)
    assertEquals(inferredType(counter), BooleanType)
  }
}
