package lang
import Trees._
import Trees.Helpers.*
import stainless.annotation.*
import stainless.lang.*
import lang.Eval.eval
import lang.Typing.typeResultEq
import lang.Typing.inferredType
import lang.Typing.typeInsurance
import lang.Eval.smallstepHelper
import lang.Eval.evaleq

case class BooleanResult(val result: Option[Boolean]) extends Result
case class IntResult(val result: Option[BigInt]) extends Result
case object UnitResult extends Result
case object TypeErr extends Result

// Results are made such that they can be chained together
// The primary aim of this is to be able to handle errors
// For example, if we have a BooleanResult and an IntResult combined in a plus, we get a TypeError
// If we have a well-typed expression, but we have division by zero, we get an ArthErr
// We aim to eventually prove that if it is well-typed, the only error possible is ArthErr.
sealed trait Result {

  @library
  def op(x: Result, e: Expr) : Result  = {
    (this, x) match
      case (BooleanResult(a), BooleanResult(b)) => e match
        case Implies(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(!a1 || b1) 
            case None() => if (a1 == false) Some(!a1) else None()
          case None() => None())

        case And(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 && b1) 
            case None() => if (a1 == false) Some(a1) else None()          
          case None() => None())

        case Or(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 || b1) 
            case None() => if (a1 == true) Some(a1) else None()
          case None() => None())

        case _ => TypeErr
      
      case (IntResult(a), IntResult(b)) => e match 

        case Plus(_, _) => IntResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 + b1) 
            case None() => None()          
          case None() => None())

        case Minus(_, _) => IntResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 - b1) 
            case None() => None()          
          case None() => None())

        case Times(_, _) => IntResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 * b1) 
            case None() => None()          
          case None() => None())

        case Division(_, _) => IntResult(
          a match
            case Some(a1) => b match
              case Some(b1) => if (b1 == 0) None() else Some(a1 / b1)
              case None() => None()
            case None() => None()
        )

        case IntPow(_, _) if b.getOrElse(-1) >= 0 => IntResult(
          a match
            case Some(a1) => b match
              case Some(b1) => Some(Eval.pow(a1, b1))
              case None() => None()
            case None() => None()
        )

        case Equals(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 == b1) 
            case None() => None()          
          case None() => None())

        case LessThan(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 < b1) 
            case None() => None()          
          case None() => None())

        case GreaterThan(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 > b1) 
            case None() => None()          
          case None() => None())
        

        case LessEquals(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 <= b1) 
            case None() => None()          
          case None() => None())

        case GreaterEquals(_, _) => BooleanResult(a match
          case Some(a1) => b match
            case Some(b1) => Some(a1 >= b1) 
            case None() => None()          
          case None() => None())

        case _ => TypeErr

      case _ => TypeErr
  }


  @library
  def op(e: Expr) : Result = {
    this match
      case BooleanResult(a) => e match
        case Not(_) => BooleanResult(a match
          case Some(v) => Some(!v)
          case None() => None()
        )
        case _ => TypeErr 

      case IntResult(a) => e match
        case UMinus(_) => IntResult(a match
          case Some(v) => Some(-v)
          case None() => None()
        )
         
        case _ => TypeErr
      case TypeErr => TypeErr
      case UnitResult => TypeErr
  }

  def op(x: Result, y: Result, e: Expr): Result = {
    (this, x, y) match
      case (IntResult(a) , IntResult(b) , IntResult(c)) => e match
        case FMA(_, _, _) => IntResult(
          a match
            case Some(a1) => b match
              case Some(b1) => c match
                case Some(c1) => Some(a1 * b1 + c1)
                case None() => None()
              case None() => None()
            case None() => None()
        )
        case _ => TypeErr      
      case _ => TypeErr
      
  }

}

object Eval {

  // Handle 0 ^ 0 by setting it equal 1
  @library
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
      case IntegerLiteral(value) => IntResult(Some(value))
      case BooleanLiteral(value) => BooleanResult(Some(value))
      case UnitLiteral() => UnitResult
      case DivisionError(tpe) => tpe match
        case Untyped => TypeErr
        case BooleanType => BooleanResult(None())
        case UnitType => TypeErr
        case IntegerType => IntResult(None())
      case TypeError() => TypeErr
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
      case IntPow(base, exp) => {
        eval(base) match
          case IntResult(result) =>
            if (exp >= 0) {
              result match
                case Some(v) => IntResult(Some(pow(v, exp)))
                case None() => IntResult(None())
            } else {
              TypeErr
            }
          case BooleanResult(result) => TypeErr
          case UnitResult => TypeErr
          case TypeErr => TypeErr        
      }
      case LessThan(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case GreaterThan(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case LessEquals(lhs, rhs) => eval(lhs).op(eval(rhs), e)
      case GreaterEquals(lhs, rhs) => eval(lhs).op(eval(rhs), e)
    
  }

  @library
  def equivalentAST(e: Result) : Expr = {
    e match
      case BooleanResult(result) => result match
        case Some(v) => BooleanLiteral(v)
        case None() => DivisionError(BooleanType)
      case IntResult(result) => result match
        case Some(v) => IntegerLiteral(v)
        case None() => DivisionError(IntegerType)
      case UnitResult => UnitLiteral()
      case TypeErr => TypeError()
  }.ensuring(res => eval(res) == e)

  def evaleq(e : Expr) : Expr = {
    equivalentAST(eval(e))
  }

  

  @library
  def smallstep(e : Expr) : Unit = {
    
  }.ensuring(smallstepHelper(e))

  // With this I want to prove that we can eval the sub expressions first.
  // Super easy for it to verify!
  @library
  def smallstepHelper(e: Expr) : Boolean = {
    e match
      case _: Terminal => true
      case Equals(lhs, rhs) => eval(e) == eval(Equals(evaleq(lhs), evaleq(rhs)))
      case And(lhs, rhs) => eval(e) == eval(And(evaleq(lhs), evaleq(rhs)))
      case Or(lhs, rhs) => eval(e) == eval(Or(evaleq(lhs), evaleq(rhs)))
      case Implies(lhs, rhs) => eval(e) == eval(Implies(evaleq(lhs), evaleq(rhs)))
      case Plus(lhs, rhs) => eval(e) == eval(Plus(evaleq(lhs), evaleq(rhs)))
      case Minus(lhs, rhs) => eval(e) == eval(Minus(evaleq(lhs), evaleq(rhs)))
      case Times(lhs, rhs) => eval(e) == eval(Times(evaleq(lhs), evaleq(rhs)))
      case Division(lhs, rhs) => eval(e) == eval(Division(evaleq(lhs), evaleq(rhs)))
      case LessThan(lhs, rhs) => eval(e) == eval(LessThan(evaleq(lhs), evaleq(rhs)))
      case GreaterThan(lhs, rhs) => eval(e) == eval(GreaterThan(evaleq(lhs), evaleq(rhs)))
      case LessEquals(lhs, rhs) => eval(e) == eval(LessEquals(evaleq(lhs), evaleq(rhs)))
      case GreaterEquals(lhs, rhs) => eval(e) == eval(GreaterEquals(evaleq(lhs), evaleq(rhs)))
    
      case Not(expr) => eval(e) == eval(Not(evaleq(expr)))
      case UMinus(expr) => eval(e) == eval(UMinus(evaleq(expr)))
      case FMA(fac1, fac2, s) => eval(e) == eval(FMA(evaleq(fac1), evaleq(fac2), evaleq(s)))
      case IntPow(base, exp) => eval(e) == eval(IntPow(evaleq(base), exp))
  }.ensuring(res => true)
}

object Typing {

  // I want to prove on an inferred typing that if it is true that eval is true.
  /**
      * This is the inferred typing
      *
      * @param e : This is the expression to find the type on.
      * @return Returns a typetree that is based on all the information
      */
  @library
  def inferredType(e: Expr): TypeTree = {
    decreases(complexity(e))
    e match
      case IntegerLiteral(value) => IntegerType
      case BooleanLiteral(value) => BooleanType
      case UnitLiteral() => UnitType
      case DivisionError(tpe) => tpe match
        case UnitType => Untyped
        case _ => tpe
      case TypeError() => Untyped
      case IntBinaryExtractor(lhs, rhs, r) => {
        val k = inferredType(lhs)
        if (k == inferredType(rhs) && k == IntegerType) r else Untyped 
      }
      case Division(lhs, rhs) => {
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
      case UMinus(expr) => {
        val k = inferredType(expr)
        if (k == IntegerType) k else Untyped 
      }
      case FMA(fac1, fac2, s) => {
        val k = inferredType(fac1)
        if (k == inferredType(fac2) && k == inferredType(s) && k == IntegerType) k else Untyped 
      }
      case IntPow(base, exp) => {
        val k = inferredType(base)
        if (k == IntegerType && exp >= 0) k else Untyped 
      }    
  }

  def typeResultEq(t1: Result, t2: TypeTree) : Boolean = {
    (t1, t2) match
      case (UnitResult, UnitType) => true
      case (IntResult(_), IntegerType) => true
      case (BooleanResult(_), BooleanType) => true
      case (TypeErr, Untyped) => true
      case _ => false
  }

  /**
      * This is the problem, it is unable to see that and equals is just the eval of its expressions
      * So, if the evals don't give a typed error.
      * Actually, it kind of makes sense...
      * The problem comes from inferredType...
      *
      * @param lhs
      * @param rhs
      */
  @library
  def equalsProof(lhs : Expr, rhs: Expr) = {
    // Inferred type tells us that none of the subexpressions are untyped
    require(inferredType(Equals(lhs, rhs)) != Untyped)

    // It also via induction says that the subexpressions do not evaluate to typeErr
    require(typeResultEq(eval(lhs), inferredType(lhs)))
    require(typeResultEq(eval(rhs), inferredType(rhs)))
    // We now need to prove that inferrType ensures that there can be no typeErr.
    
  }.ensuring(eval(Equals(lhs, rhs)) != TypeErr)

  // Its able to prove that the type of an expression is equal to the result type
  // This is awesome!!!
  // This means that untyped => typeErr
  // It also means that IntegerType => intResult
  // Finally it means that BooleanType => BooleanResult (and unitResult => unitType)
  @library
  @opaque
  def typeInsurance(e : Expr) : Unit = {
    decreases(complexity(e))

    e match
      // Obvious base cases
      case _: Terminal => ()
      // If eval works on each subexpression and remains true
      // then if current is typed and we know eval gives one of the three.
      // Then it must also give one of the three for this expression...
      case Equals(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case And(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }

      case Or(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)        
      }
      case Implies(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case Not(expr) => {
        typeInsurance(expr)
      }
      case Plus(lhs, rhs) => {        
        typeInsurance(lhs)
        typeInsurance(rhs)        
      }
      case Minus(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)        
      }
      case UMinus(expr) => {
        typeInsurance(expr)
      }
      case Times(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case FMA(fac1, fac2, s) => {
        typeInsurance(fac1)
        typeInsurance(fac2)
        typeInsurance(s)
      }
      case Division(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case IntPow(base, exp) => {
        typeInsurance(base)
        assert(typeResultEq(eval(e), inferredType(e)))
      }
      case LessThan(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case GreaterThan(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case LessEquals(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
      case GreaterEquals(lhs, rhs) => {
        typeInsurance(lhs)
        typeInsurance(rhs)
      }
  }.ensuring(typeResultEq(eval(e), inferredType(e)))

  @library
  def typeEquality(e : Expr) : Unit = {
    require(inferredType(e) != Untyped)
    e match
      // Very simple getType
      case _: Terminal => ()      
      case LessThan(lhs, rhs) => ()
      case GreaterThan(lhs, rhs) => ()
      case LessEquals(lhs, rhs) => ()
      case GreaterEquals(lhs, rhs) => ()
      case And(lhs, rhs) => ()
      case Or(lhs, rhs) => ()

      // One sided getType
      case Not(expr) => typeEquality(expr)
      case Plus(lhs, rhs) => typeEquality(lhs)
      case Minus(lhs, rhs) => typeEquality(lhs)
      case UMinus(expr) => typeEquality(expr)
      case Times(lhs, rhs) => typeEquality(lhs)
      case FMA(fac1, fac2, s) => typeEquality(fac1)
      case Division(lhs, n) => typeEquality(lhs)
      case IntPow(base, exp) => typeEquality(base)

      // Slightly more complex getType
      case Equals(lhs, rhs) => {
        typeEquality(lhs)
        typeEquality(rhs)
      }
      case Implies(lhs, rhs) => {
        typeEquality(lhs)
        typeEquality(rhs)
      }
    
  }.ensuring(inferredType(e) == Expr.getType(e))
}


object IntBinaryExtractor {
  def unapply(e : Expr) : Option[(Expr, Expr, TypeTree)] = {
    e match
      // Returns ints
      case Plus(lhs, rhs) =>Some(lhs, rhs, IntegerType)
      case Minus(lhs, rhs) => Some(lhs, rhs, IntegerType)
      case Times(lhs, rhs) => Some(lhs, rhs, IntegerType)

      // Returns bools
      case Equals(lhs, rhs) => Some(lhs, rhs, BooleanType)
      case GreaterThan(lhs, rhs) => Some(lhs, rhs, BooleanType)
      case LessEquals(lhs, rhs) => Some(lhs, rhs, BooleanType)
      case GreaterEquals(lhs, rhs) => Some(lhs, rhs, BooleanType)
      case LessThan(lhs, rhs) => Some(lhs, rhs, BooleanType)

      // Not applicable
      case Division(lhs, rhs) => None()
      case Implies(lhs, rhs) => None()
      case FMA(fac1, fac2, s) => None()
      case IntPow(base, exp) => None()
      case IntegerLiteral(value) => None()
      case BooleanLiteral(value) => None()
      case UnitLiteral() => None()
      case Not(expr) => None()
      case UMinus(expr) => None()
      case And(lhs, rhs) => None()
      case Or(lhs, rhs) => None()
      case DivisionError(tpe) => None()
      case TypeError() => None()
  }
}
