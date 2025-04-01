import lang.Trees._
import lang.Constructors.times
import lang.Constructors
import lang.TreeOps._
import lang.TreeOps
// For more information on writing tests, see
// https://scalameta.org/munit/docs/getting-started.html
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


  test("Testing  PostMap 5 - (4 - 2) => 5 - 2") {
    val k = Plus(IntegerLiteral(5), Minus(IntegerLiteral(4), IntegerLiteral(3)))
    val res1 = TreeOps.postMap(transform, false)(k)
    assertEquals(res1, Plus(IntegerLiteral(5), IntegerLiteral(2)))
  }

  def transform2(e : Expr) : Option[Expr] = {
    e match
      case Minus(IntegerLiteral(4), IntegerLiteral(3)) => Some(IntegerLiteral(1))
      case Minus(IntegerLiteral(7), IntegerLiteral(3)) => Some(IntegerLiteral(4))
      case IntegerLiteral(4) => Some(IntegerLiteral(7))
      case _ => None 
  }

  test("Testing  PostMap example") {
    val a = IntegerLiteral(5)
    val b = IntegerLiteral(4)
    val c = IntegerLiteral(3)
    val d = IntegerLiteral(7)
    val k = Plus(a, Minus(b, c))
    val res1 = TreeOps.postMap(transform2, false)(k)
    assertEquals(res1, Plus(a, b))
  }
}
