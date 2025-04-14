package lang
import Trees._
import stainless.annotation.*
import stainless.lang.*

case class BooleanResult(val result: Boolean) extends Result

case class IntResult(val result: BigInt) extends Result
case object ArthErr extends Result


case object TypeErr extends Result



sealed trait Result {
  def op(x: Result, e: Expr) : Result  = {
    (this, x) match
      case (BooleanResult(a), BooleanResult(b)) => e match
        case Implies(_, _) => BooleanResult(!a || b)
        case And(_, _) => BooleanResult(a && b)
        case Or(_, _) => BooleanResult(a && b)
        case _ => TypeErr
      
      case (IntResult(a), IntResult(b)) => e match 
        case Plus(_, _) => IntResult(a + b)
        case Minus(_, _) => IntResult(a - b)
        case Times(_, _) => IntResult(a * b)
        case Division(_, _) if b != 0 => IntResult(a / b)
        case IntPow(_, _) if b >= 0 => IntResult(Eval.pow(a, b))
        case Equals(_, _) => BooleanResult(a == b)
        case LessThan(_, _) => BooleanResult(a < b)
        case GreaterThan(_, _) => BooleanResult(a > b)
        case LessEquals(_, _) => BooleanResult(a <= b)
        case GreaterEquals(_, _) => BooleanResult(a >= b)
        case Division(_, _) if b == 0 => ArthErr
        case _ => TypeErr
      
      case (IntResult(_), ArthErr) => Eval.arthdealer(e)
      case (ArthErr, ArthErr) => Eval.arthdealer(e)
      case (ArthErr, IntResult(_)) => Eval.arthdealer(e)
       
      case _ => TypeErr
  }


  def op(e: Expr) : Result = {
    this match
      case BooleanResult(a) => e match
        case Not(expr) => BooleanResult(!a)
        case _ => TypeErr 
      case IntResult(a) => e match
        case UMinus(expr) => IntResult(-a) 
        case _ => TypeErr
      case ArthErr => e match
        case UMinus(_) => ArthErr
        case _ => TypeErr
      case TypeErr => TypeErr
  }

  def op(x: Result, y: Result, e: Expr): Result = {
    (this, x, y) match
      case (IntResult(a), IntResult(b), IntResult(c)) => e match
        case FMA(fac1, fac2, s) => IntResult(a * b + c)
        case _ => TypeErr
      case _ => TypeErr
      
  }

}

object Eval {

  def arthdealer(e: Expr) : Result = e match
    case Equals(lhs, rhs) => ArthErr
    case Plus(lhs, rhs) => ArthErr
    case Minus(lhs, rhs) => ArthErr
    case Times(lhs, rhs) => ArthErr
    case Division(lhs, rhs) => ArthErr
    case IntPow(base, exp) => ArthErr
    case LessThan(lhs, rhs) => ArthErr
    case GreaterThan(lhs, rhs) => ArthErr
    case LessEquals(lhs, rhs) => ArthErr
    case GreaterEquals(lhs, rhs) => ArthErr
    case _ => TypeErr 

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

  def eval(e: Expr): Result = {
    decreases(Expr.complexity(e))
    e match
      case IntegerLiteral(value) => IntResult(value)
      case BooleanLiteral(value) => BooleanResult(value)
      case UnitLiteral() => TypeErr
      case Equals(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case And(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case Or(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case Implies(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case Not(expr) => eval(expr).op(e)
      case Plus(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case Minus(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case UMinus(expr) => eval(expr).op(e)
      case Times(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case FMA(fac1, fac2, s) => eval(fac1).op(eval(fac2), eval(s), e)
      case Division(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case IntPow(base, exp) => eval(base).op(IntResult(exp), e)
      case LessThan(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case GreaterThan(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case LessEquals(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case GreaterEquals(lhs, rhs) => eval(lhs).op(eval(rhs), e)
    
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
