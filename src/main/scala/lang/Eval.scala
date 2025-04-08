package lang
import Trees._

object Eval {
    def eval(e: Expr): BigInt = e match {
      case Plus(x, y) => eval(x) + eval(y)
      case Minus(x, y) => eval(x) - eval(y)
      case Times(x, y) => eval(x) * eval(y)
      case Division(x, y) => eval(x) / eval(y)
      case IntPow(x, y) => eval(x) ^ y
      case UMinus(x) => - eval(x)
      case IntegerLiteral(value) => value
    }
}
