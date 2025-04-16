package lang
import Trees._
import stainless.annotation.*
import stainless.lang.*

case class BooleanResult(val result: Boolean) extends Result
case class IntResult(val result: BigInt) extends Result
case object ArthErr extends Result
case object TypeErr extends Result

// Results are made such that they can be chained together
// The primary aim of this is to be able to handle errors
// For example, if we have a BooleanResult and an IntResult combined in a plus, we get a TypeError
// If we have a well-typed expression, but we have division by zero, we get an ArthErr
// We aim to eventually prove that if it is well-typed, the only error possible is ArthErr.
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
        case IntPow(_, _) if b < 0 => ArthErr 
        case _ => TypeErr

      case IntOrArth(()) => e match
        case Equals(_, _) => ArthErr
        case Plus(_, _) => ArthErr
        case Minus(_, _) => ArthErr
        case Times(_, _) => ArthErr
        case Division(_, _) => ArthErr
        case IntPow(_, _) => ArthErr
        case LessThan(_, _) => ArthErr
        case GreaterThan(_, _) => ArthErr
        case LessEquals(_, _) => ArthErr
        case GreaterEquals(_, _) => ArthErr
        case _ => TypeErr 

      case _ => TypeErr
  }


  def op(e: Expr) : Result = {
    this match
      case BooleanResult(a) => e match
        case Not(_) => BooleanResult(!a)
        case _ => TypeErr 
      case IntResult(a) => e match
        case UMinus(_) => IntResult(-a) 
        case _ => TypeErr
      case ArthErr => e match
        case UMinus(_) => ArthErr
        case _ => TypeErr
      case TypeErr => TypeErr
  }

  def op(x: Result, y: Result, e: Expr): Result = {
    (this, x, y) match
      case (IntResult(a) , IntResult(b) , IntResult(c)) => e match
        case FMA(_, _, _) => IntResult(a * b + c)
        case _ => TypeErr
      case IntOrArth(()) => e match
        case FMA(_, _, _) => ArthErr
        case _ => TypeErr
      
      case _ => TypeErr
      
  }

}

object IntOrArth {
  def unapply(res: (Result, Result, Result)): Option[Unit] = {
    val (x, y, z) = res
    x match
      case IntOrArth(()) => y match
        case IntOrArth(()) => z match
          case IntOrArth(()) => Some(())
          case _ => None() 
        case _ => None() 
      case _ => None()
  }

  def unapply(res: (Result, Result)): Option[Unit] = {
    val (x, y) = res
    x match 
      case IntOrArth(()) => y match 
        case IntOrArth(()) => Some(())
        case _ => None() 
      case _ => None() 
  }

  def unapply(res : Result) : Option[Unit] = {
    val x = res
    x match
      case IntResult(result) => Some(())
      case ArthErr => Some(())
      case _ => None()
  }
}

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
