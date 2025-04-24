package lang

import Trees.*
import stainless.lang.*
import Trees.Helpers.*
import Trees.Expr.getType
import lang.Typing.inferredType
import lang.Eval.eval
import lang.Typing.typeEquality
import lang.Typing.typeInsurance
import lang.Eval.smallstep
import stainless.annotation.*
import lang.Eval.evaleq
import lang.Eval.equivalentAST
import lang.Eval.smallstepHelper

object ConstructIter {
  /** Computes the negation of a boolean formula, with some simplifications. */
  @library
  def negate(expr: Expr): Expr = {
    require(inferredType(expr) == BooleanType)
    decreases(complexity(expr))
    (expr match {
      case Not(e) => e

      // todo: This here needs to be changed to the optimized and version later on
      // when and is proven to be correct, although given that and is correct this should be correct.
      // That is given that the semantics is preserved by and function.
      case Implies(e1,e2) => And(e1, negate(e2))
      case Or(lhs, rhs) => And(negate(lhs), negate(rhs))
      case And(lhs, rhs) => And(negate(lhs), negate(rhs))

      
      case LessThan(e1,e2) => GreaterEquals(e1,e2)
      case LessEquals(e1,e2) => GreaterThan(e1,e2)
      case GreaterThan(e1,e2) => LessEquals(e1,e2)
      case GreaterEquals(e1,e2) => LessThan(e1,e2)
      case BooleanLiteral(b) => BooleanLiteral(!b)

      // I replaced e -> Not(e) to make things easier to reason on
      case DivisionError(tpe) => Not(DivisionError(tpe))
      case Equals(lhs, rhs) => Not(Equals(lhs, rhs))
    })
  }.ensuring(res => inferredType(res) == BooleanType)

  /** $encodingof simplified `!`-expressions .
   * @see [[purescala.Expressions.Not Not]]
   */
  def not(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)
    negate(e)
  }

  def booleanNegated(b : Boolean) : Unit = {
    
  }.ensuring(isNegation(Not(BooleanLiteral(b)), BooleanLiteral(b)))

  @library
  def divisionEvaluated(b : DivisionError) : Unit = {
    require(b.tpe == BooleanType)
  }.ensuring(eval(Not(b)) == BooleanResult(None()))

  @library
  def divisionNegated(b : DivisionError) : Unit = {
    require(b.tpe == BooleanType)
    divisionEvaluated(b)
    
  }.ensuring(isNegation(Not(b), b))

  def resultNegated(e : BooleanResult) = {
    e.result match
      case Some(v) => equivalentAST(e) match
        case BooleanLiteral(value) =>
          booleanNegated(value)
      case None() => equivalentAST(e) match
        case t : DivisionError => divisionNegated(t) 
  }.ensuring(isNegation(Not(equivalentAST(e)), equivalentAST(e)))


  @library
  def notNegation(e : Not) : Unit = {
    require(inferredType(e) == BooleanType)
    e match
      case Not(expr) =>
        typeInsurance(expr)
        eval(expr) match
          case t : BooleanResult =>
            resultNegated(t)
            assert(eval(e) == eval(Not(evaleq(expr))))
  }.ensuring(isNegation(negate(e), e))


  // This proves that given a result, Not of that result's equivalentAST is negative.
  // Indeed I should probably prove this for each result first and then simply use smallstep
  // to ensure that yes the eval is also not because we can break it up into an evaluation of the expression first
  // and then Not(res), which is proven to be the negation
  @library
  def doubleNeg(e : Not) : Boolean = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)
    eval(e) match
      case BooleanResult(result) => result match
        case Some(v) => BooleanResult(Some(!v)) == eval(Not(equivalentAST(BooleanResult(Some(v)))))
        case None() => BooleanResult(None()) == eval(Not(equivalentAST(BooleanResult(None()))))
  }.ensuring(res => true)

  @library
  def isNegation(e1 : Expr, e2 : Expr) : Boolean = {
    require(inferredType(e1) == BooleanType)
    require(inferredType(e2) == BooleanType)
    typeInsurance(e1)
    typeInsurance(e2)
    (eval(e1), eval(e2)) match
      case (BooleanResult(opt1), BooleanResult(opt2)) => (opt1, opt2) match
        case (Some(res1), Some(res2)) => res1 == !res2
        case (None(), None()) => true
        case _ => false
  }

  @ignore
  def notNegated(e : Not) : Unit = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)    
    // We need to claim that Not(e) is the same as Not(evaleq(e))
    eval(e) match
      case BooleanResult(result) => result match
        case Some(v) =>
          assert(BooleanResult(Some(!v)) == eval(Not(equivalentAST(BooleanResult(Some(v))))))
        case None() =>
          assert(BooleanResult(None()) == eval(Not(equivalentAST(BooleanResult(None())))))
  }.ensuring(isNegation(negate(e), e))

  @ignore
  def negateGivesNegation(expr : Expr) : Unit = {
    require(inferredType(expr) == BooleanType)
    decreases(complexity(expr))
    expr match
      case Not(e) => ()
      case Implies(e1,e2) =>
        negateGivesNegation(e2)
      case Or(lhs, rhs) =>
        negateGivesNegation(lhs)
        negateGivesNegation(rhs)
      case And(lhs, rhs) =>
        negateGivesNegation(lhs)
        negateGivesNegation(rhs)
      case LessThan(e1,e2) => ()
      case LessEquals(e1,e2) => ()
      case GreaterThan(e1,e2) => ()
      case GreaterEquals(e1,e2) => ()
      case BooleanLiteral(b) => ()
      case e => ()
  }.ensuring(isNegation(negate(expr), expr))
}
