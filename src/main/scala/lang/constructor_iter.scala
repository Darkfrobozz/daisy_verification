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
import javax.swing.UnsupportedLookAndFeelException
object NegateProof {
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
      case And(lhs, rhs) => Or(negate(lhs), negate(rhs))

      
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


  @library
  def easyProofs(b1: BooleanLiteral, b2: BooleanLiteral) : Unit = {
    assert(eval(And(b1, b2)) == BooleanResult(Some(b1.value && b2.value)))
    assert(evaleq(Or(b1, b2)) == BooleanLiteral(b1.value || b2.value))
    assert(evaleq(Implies(b1, b2)) == BooleanLiteral(!b1.value || b2.value))
  }

  @library
  def easyProofs2(b1: IntegerLiteral, b2: IntegerLiteral) : Unit = {
    assert(evaleq(LessThan(b1, b2)) == BooleanLiteral(b1.value < b2.value))
    assert(evaleq(Equals(b1, b2)) == BooleanLiteral(b1.value == b2.value))
    assert(evaleq(LessEquals(b1, b2)) == BooleanLiteral(b1.value <= b2.value))
    assert(evaleq(GreaterThan(b1, b2)) == BooleanLiteral(b1.value > b2.value))
    assert(evaleq(GreaterEquals(b1, b2)) == BooleanLiteral(b1.value >= b2.value))
  }

  @library
  def booleanNegated(b : Boolean) : Unit = {
    assert(evaleq(Not(BooleanLiteral(b))) == BooleanLiteral(!b))
    
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

  @library
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

  @library
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
        assert(isNegation(negate(rhs), rhs))
        assert(isNegation(negate(lhs), lhs))
        orNegation(Or(lhs, rhs), negate(lhs), negate(rhs))
      case And(lhs, rhs) =>
        negateGivesNegation(lhs)
        negateGivesNegation(rhs)
        assert(isNegation(negate(rhs), rhs))
        assert(isNegation(negate(lhs), lhs))
        andNegation(And(lhs, rhs), negate(lhs), negate(rhs))
      case LessThan(e1,e2) => ()
      case LessEquals(e1,e2) => ()
      case GreaterThan(e1,e2) => ()
      case GreaterEquals(e1,e2) => ()
      case BooleanLiteral(b) => ()
      // I replaced e -> Not(e) to make things easier to reason on
      case DivisionError(tpe) => ()
      case Equals(lhs, rhs) => ()
  }.ensuring(isNegation(negate(expr), expr))

  @library
  def depthOneAnd(lhs : BooleanLiteral, rhs: BooleanLiteral) = {
    
  }.ensuring(isNegation(And(lhs, rhs), Or(negate(lhs), negate(rhs))))

  @library
  def andNegation(expr : And, lhsNeg: Expr, rhsNeg: Expr) : Unit = {
    // One or both of the branches could have a division error.
    // They do not need to equal eachother
    require(inferredType(expr) == BooleanType)
    require(inferredType(lhsNeg) == BooleanType)
    require(inferredType(rhsNeg) == BooleanType)
    require(isNegation(expr.lhs, lhsNeg))
    require(isNegation(expr.rhs, rhsNeg))

    // evaleq could result in divisionError, but a divisionError has the correct type...
    typeInsurance(lhsNeg)
    typeInsurance(expr.lhs)
    assert(isNegation(evaleq(lhsNeg), evaleq(expr.lhs)))

    typeInsurance(rhsNeg)
    typeInsurance(expr.rhs)
    assert(isNegation(evaleq(rhsNeg), evaleq(expr.rhs)))

    smallstep(Or(lhsNeg, rhsNeg))    
    smallstep(expr)
    val rhs = expr.rhs
    val lhs = expr.lhs
    assert(eval(expr) == eval(And(evaleq(rhs), evaleq(lhs))))
    assert(eval(Or(lhsNeg, rhsNeg)) == eval(Or(evaleq(rhsNeg), evaleq(lhsNeg))))
    
  }.ensuring(isNegation(expr, Or(lhsNeg, rhsNeg))) 


  @library
  def orNegation(expr : Or, lhsNeg: Expr, rhsNeg: Expr) : Unit = {
    // One or both of the branches could have a division error.
    // They do not need to equal eachother
    require(inferredType(expr) == BooleanType)
    require(inferredType(lhsNeg) == BooleanType)
    require(inferredType(rhsNeg) == BooleanType)
    require(isNegation(expr.lhs, lhsNeg))
    require(isNegation(expr.rhs, rhsNeg))

    // evaleq could result in divisionError, but a divisionError has the correct type...
    typeInsurance(lhsNeg)
    typeInsurance(expr.lhs)
    assert(isNegation(evaleq(lhsNeg), evaleq(expr.lhs)))

    typeInsurance(rhsNeg)
    typeInsurance(expr.rhs)
    assert(isNegation(evaleq(rhsNeg), evaleq(expr.rhs)))

    smallstep(And(lhsNeg, rhsNeg))    
    smallstep(expr)
    val rhs = expr.rhs
    val lhs = expr.lhs
    assert(eval(expr) == eval(Or(evaleq(rhs), evaleq(lhs))))
    assert(eval(And(lhsNeg, rhsNeg)) == eval(And(evaleq(rhsNeg), evaleq(lhsNeg))))
    
  }.ensuring(isNegation(expr, And(lhsNeg, rhsNeg))) 
}

object ArthSimple {
  /** $encodingof simplified `... + ...` (plus).
   * @see [[purescala.Expressions.Plus Plus]]
   * @see [[purescala.Expressions.BVPlus BVPlus]]
   * @see [[purescala.Expressions.RealPlus RealPlus]]
   */
  def plus(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (IntegerLiteral(bi), _) if bi == 0 => rhs
      case (_, IntegerLiteral(bi)) if bi == 0 => lhs
      case _ => Plus(lhs, rhs)
    }
  }

  @library
  def conservationPlusTheorem(lhs: Expr, rhs: Expr) : Unit = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match
        case (IntegerLiteral(bi), _) if bi == 0 => ()
        case (_, IntegerLiteral(bi)) if bi == 0 => ()
        case _ => ()
  }.ensuring(eval(plus(lhs, rhs)) == eval(Plus(lhs, rhs)))

  /** $encodingof simplified `... - ...` (minus).
   * @see [[purescala.Expressions.Minus Minus]]
   * @see [[purescala.Expressions.BVMinus BVMinus]]
   * @see [[purescala.Expressions.RealMinus RealMinus]]
   */
  def minus(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (_, IntegerLiteral(bi)) if bi == 0 => lhs
      case (IntegerLiteral(bi), _) if bi == 0 => UMinus(rhs)
      case _ => Minus(lhs, rhs)
    }
  }

  @library
  def conservationMinus(lhs: Expr, rhs: Expr): Unit = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (_, IntegerLiteral(bi)) if bi == 0 => ()
      case (IntegerLiteral(bi), _) if bi == 0 => ()
      case _ => ()
    }
  }.ensuring(eval(minus(lhs, rhs)) == eval(Minus(lhs, rhs)))

  /** $encodingof simplified `... * ...` (times).
   * @see [[purescala.Expressions.Times Times]]
   * @see [[purescala.Expressions.BVTimes BVTimes]]
   * @see [[purescala.Expressions.RealTimes RealTimes]]
   */
  def times(lhs: Expr, rhs: Expr): Expr = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (IntegerLiteral(bi), _) if bi == 1 => rhs
      case (_, IntegerLiteral(bi)) if bi == 1 => lhs
      case (IntegerLiteral(bi), _) if bi == 0 => IntegerLiteral(0)
      case (_, IntegerLiteral(bi)) if bi == 0 => IntegerLiteral(0)
      case _ => Times(lhs, rhs)
    }
  }
  
  @ignore
  def conservationTimes(lhs: Expr, rhs: Expr): Unit = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (IntegerLiteral(bi), _) if bi == 1 => ()
      case (_, IntegerLiteral(bi)) if bi == 1 => ()
      case (IntegerLiteral(bi), _) if bi == 0 => ()
      case (_, IntegerLiteral(bi)) if bi == 0 => ()
      case _ => ()
    }
  }.ensuring(eval(times(lhs, rhs)) == eval(Times(lhs, rhs)))
}

object AndOptimization {

  /**
      * Ensures the flat trait.
      * The flat trait is basically that there can be no And:s in the right hand side
      *
      * @param e
      * @return
      */
  @library
  def isAndFlat(e: Expr) : Boolean = {
    decreases(complexity(e))
    e match
      case And(lhs, rhs) => lhs match
        case And(_, _) => false
        case _ => isAndFlat(rhs)
      case _ => true
  }

  /**
      * Is needed because we have to flatten a tree
      *
      * @param lhs - should be flat
      * @param rhs - should be flat
      * @return lhs and then rhs in an And chain
      */
  @library
  def chainTwoFlattened(left : Expr, right: Expr) : Expr = {
    require(isAndFlat(left))
    require(isAndFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case And(lleft, rleft) => And(lleft, chainTwoFlattened(rleft, right))
      case _ => And(left, right)
  }.ensuring(res => isAndFlat(res))
  
  @library
  def chainConservation(left: Expr, right: Expr) : Unit = {
    require(isAndFlat(left))
    require(isAndFlat(right))
    decreases(complexity(left))
    left match
      case And(llhs, rrhs) =>
        chainConservation(rrhs, right)
        assert(eval(chainTwoFlattened(rrhs, right)) == eval(And(rrhs, right)))
        smallstep(And(left, right))
        assert(eval(And(left, right)) == eval(And(evaleq(left),evaleq(right))))
        assert(eval(left) == eval(And(evaleq(llhs),evaleq(rrhs))))
        // This is what I need to prove
        // And(lhs1, chainTwoFlattened(lhs1, rhs1))
        // We know that the right hand side equals eval(And(lhs1, rhs1))
        // This is wrong, eval is not proven because we are doing something else entirely
      case _ => ()
    
  }.ensuring(eval(chainTwoFlattened(left, right)) == eval(And(left, right)))
  /**
      * Takes an And expression and turns it into a flat And
      * According to definition isAndFlat
      * @param e : Must be And
      * @return Must be flat
      */
  @library
  def flatten(e: Expr) : Expr = {
    decreases(complexity(e))
    e match
      case And(lhs, rhs) => lhs match
        case And(lhs1, rhs1) => chainTwoFlattened(flatten(lhs), flatten(rhs))
        case _ => rhs match
          case And(lhs1, rhs1) => And(lhs, flatten(rhs))
          case _ => e
      case _ => e
  // Ensuring tells us that it is flat
  }.ensuring(res => isAndFlat(res))

  @ignore
  def flattenConservationTheorem(e : Expr) : Unit = {
    e match
      case And(lhs, rhs) => ()
      case _ => ()
  }.ensuring(eval(flatten(e)) == eval(e))

  
}
