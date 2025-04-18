package lang
import Trees._
import Trees.Helpers.*
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
    decreases(complexity(e))
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

object Typing {

  // I want to prove on an inferred typing that if it is true that eval is true.
  /**
      * This is the inferred typing
      *
      * @param e : This is the expression to find the type on.
      * @return Returns a typetree that is based on all the information
      */
  def inferredType(e: Expr): TypeTree = {
    decreases(complexity(e))
    e match
      case IntegerLiteral(value) => IntegerType
      case BooleanLiteral(value) => BooleanType
      case UnitLiteral() => UnitType
      case Equals(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case And(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == BooleanType) k else Untyped 
      }
      case Or(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == BooleanType) k else Untyped 
      }
      case Implies(lhs, rhs) => {        
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == BooleanType) k else Untyped 
      }
      case Not(expr) => {        
        val k = inferredType(expr)
        if (k == BooleanType) k else Untyped 
      }
      case Plus(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case Minus(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case UMinus(expr) => {
        val k = inferredType(expr)
        if (k == IntegerType) k else Untyped 
      }
      case Times(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case FMA(fac1, fac2, s) => {
        val k = inferredType(fac1)
        if (k == inferredType(fac2) && k == inferredType(s) && k == IntegerType) k else Untyped 
      }
      case Division(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case IntPow(base, exp) => {
        val k = inferredType(base)
        if (k == IntegerType) k else Untyped 
      }
      case LessThan(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case GreaterThan(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case LessEquals(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
      case GreaterEquals(lhs, rhs) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) k else Untyped 
      }
    
  }
}
