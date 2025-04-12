package lang
import Trees._
import stainless.annotation.*
import stainless.lang.*
import lang.Trees.Expr.complexity

sealed trait Operation

case object Add extends Operation
case object Mul extends Operation
case object Div extends Operation
case object Sub extends Operation


object Eval {


  def pow(base: BigInt, exp: BigInt) : BigInt = {
    decreases(exp)
    require(exp >= 0)
    base
  }.ensuring(res => (base == 0 && res == 0) || res >= 1)

  def evalBinaryHelper(e1: Expr, e2: Expr, op: Operation) : Option[BigInt] = {
    (evalInt(e1), evalInt(e2)) match
      case (Some(a), Some(b)) => 
        op match
          case Add => Some(a + b)
          case Mul => Some(a * b)
          case Div if b != 0 => Some(a / b)
          case Sub => Some(a - b) 
          case _ => None[BigInt]()
      case _ => None[BigInt]()
  }

  def evalInt(e: Expr): Option[BigInt] = {
    decreases(complexity(e))
    e match {
      case Plus(x, y) => evalBinaryHelper(x, y, Add)
      case Minus(x, y) => evalBinaryHelper(x, y, Sub)
      case Times(x, y) => evalBinaryHelper(x, y, Mul)
      case Division(x, y) => evalBinaryHelper(x, y, Div)
      case IntPow(x, y) => {
        val base = evalInt(x)
        base match
          case Some(v) => Some(pow(v, y))
          case None() => None()
      }
      case UMinus(x) => evalInt(x).map(-_)
      case IntegerLiteral(value) => Some(value)
      case _ => None[BigInt]()
    }
  }
}
