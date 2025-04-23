package lang

import Trees.*
import stainless.lang.*
import Trees.Helpers.*
import Trees.Expr.getType
import lang.Typing.inferredType
import lang.Eval.eval
import lang.Typing.typeEquality
import lang.Typing.typeInsurance

object ConstructIter {
  /** Computes the negation of a boolean formula, with some simplifications. */
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
      case e => Not(e)
    })
  }

  /** $encodingof simplified `!`-expressions .
   * @see [[purescala.Expressions.Not Not]]
   */
  def not(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)
    negate(e)
  }

  def semanticsNegate(e : Expr) : Unit = {
    require(inferredType(e) == BooleanType)
    
  }.ensuring(eval(e) == eval(Not(e)))

  def doubleNeg(e : Not) = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)
    eval(e) match
      case BooleanResult(result) => result match
        case Some(v) => ()
        case None() => ()
      
  }.ensuring(eval(e) == eval(Not(e)))
}
