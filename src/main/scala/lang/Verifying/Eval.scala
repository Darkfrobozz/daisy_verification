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


  // Handle 0 ^ 0 by setting it equal 1
  def pow(base: BigInt, exp: BigInt) : BigInt = {
    decreases(exp)
    require(exp >= 0)
    if (exp == 0) BigInt(1) else base * pow(base, exp - 1)
  }.ensuring(res => 
    ((base == 0 && res == 0 && exp > 0) 
      || (base == 0 && res == 1 && exp == 0) 
      || (res != 0 && base != 0))
    )

  @library
  def evalBinaryHelper(e1: Option[BigInt], e2: Option[BigInt], op: Operation) : Option[BigInt] = {
    e1 match
      case Some(a) => e2 match
        case Some(b) => 
          op match
            case Add => Some(a + b)
            case Mul => Some(a * b)
            case Div if b != 0 => Some(a / b)
            case Sub => Some(a - b) 
            case _ => None[BigInt]()
        case None() => None()
      case None() => None()
  }

  @library
  def evalInt(e: Expr): Option[BigInt] = {
    decreases(complexity(e))
    e match {
      case Plus(x, y) => evalBinaryHelper(evalInt(x), evalInt(y), Add)
      case Minus(x, y) => evalBinaryHelper(evalInt(x), evalInt(y), Sub)
      case Times(x, y) => evalBinaryHelper(evalInt(x), evalInt(y), Mul)
      case Division(x, y) => evalBinaryHelper(evalInt(x), evalInt(y), Div)
      case IntPow(x, y) => {
        val base = evalInt(x)
        base match
          case Some(v) => if (y >= 0) Some(pow(v, y)) else None()
          case None() => None()
      }
      case UMinus(x) => evalInt(x).map(-_)
      case IntegerLiteral(value) => Some(value)
      case _ => None[BigInt]()
    }
  }
}

// All the evaluation functions but commented:
//   def evalRational(expr: Expr, _valMap: Map[Identifier, Rational]): Rational = {
//     var valMap = _valMap

//     def eval(e: Expr): Rational = (e: @unchecked) match {

//       case Variable(id) => valMap(id)
//       case RealLiteral(r) => r
//       case Plus(x, y) => eval(x) + eval(y)
//       case Minus(x, y) => eval(x) - eval(y)
//       case Times(x, y) => eval(x) * eval(y)
//       case Division(x, y) => eval(x) / eval(y)
// //      case Pow(x, y) => eval(x) ^ eval(y)
//       case IntPow(x, y) => eval(x) ^ y
//       case UMinus(x) => - eval(x)
//       case Let(id, v, b) =>
//         valMap += (id -> eval(v))
//         eval(b)

//     }
//     eval(expr)

//   }

//   def evalDouble(expr: Expr, _valMap: Map[Identifier, Double]): Double = {
//     var valMap = _valMap

//     def eval(e: Expr): Double = (e: @unchecked) match {

//       case Variable(id) => valMap(id)
//       case RealLiteral(r) => r.toDouble
//       case Plus(x, y) => eval(x) + eval(y)
//       case Minus(x, y) => eval(x) - eval(y)
//       case Times(x, y) => eval(x) * eval(y)
//       case Division(x, y) => eval(x) / eval(y)
// //      case Pow(x, y) => math.pow(eval(x), eval(y))
//       case IntPow(x, y) => math.pow(eval(x), y)
//       case UMinus(x) => - eval(x)
//       case Sqrt(x) => math.sqrt(eval(x))
//       case Sin(x) => math.sin(eval(x))
//       case Cos(x) => math.cos(eval(x))
//       case Tan(x) => math.tan(eval(x))
//       case Asin(x) => math.asin(eval(x))
//       case Acos(x) => math.acos(eval(x))
//       case Atan(x) => math.atan(eval(x))
//       case Exp(x) => math.exp(eval(x))
//       case Log(x) => math.log(eval(x))
//       case Let(id, v, b) =>
//         valMap += (id -> eval(v))
//         eval(b)

//     }
//     eval(expr)

//   }

//   def evalMPFR(expr: Expr, _valMap: Map[Identifier, MPFRFloat]): MPFRFloat = {
//     var valMap = _valMap

//     def eval(e: Expr): MPFRFloat = (e: @unchecked) match {

//       case Variable(id) => valMap(id)
//       case r: RealLiteral => MPFRFloat.fromString(r.stringValue)
//       case Plus(x, y) => eval(x) + eval(y)
//       case Minus(x, y) => eval(x) - eval(y)
//       case Times(x, y) => eval(x) * eval(y)
//       case Division(x, y) => eval(x) / eval(y)
// //      case Pow(x, y) => MPFRFloat.pow(eval(x), eval(y))
//       case IntPow(x, y) => MPFRFloat.pow(eval(x), MPFRFloat.fromDouble(y))
//       case UMinus(x) => - eval(x)
//       case Sqrt(x) => MPFRFloat.sqrt(eval(x) )
//       case Sin(x) => MPFRFloat.sin(eval(x))
//       case Cos(x) => MPFRFloat.cos(eval(x))
//       case Tan(x) => MPFRFloat.tan(eval(x))
//       case Asin(x) => MPFRFloat.asin(eval(x))
//       case Acos(x) => MPFRFloat.acos(eval(x))
//       case Atan(x) => MPFRFloat.atan(eval(x))
//       case Exp(x) => MPFRFloat.exp(eval(x))
//       case Log(x) => MPFRFloat.log(eval(x))
//       case Let(id, v, b) =>
//         valMap += (id -> eval(v))
//         eval(b)

//     }
//     eval(expr)
//   }
