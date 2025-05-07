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

    val rhs = expr.rhs
    val lhs = expr.lhs
    smallstep(expr)
    assert(eval(expr) == eval(And(evaleq(lhs), evaleq(rhs))))
    smallstep(Or(lhsNeg, rhsNeg))    
    assert(eval(Or(lhsNeg, rhsNeg)) == eval(Or(evaleq(lhsNeg), evaleq(rhsNeg))))

    assert(isNegation(And(evaleq(lhs), evaleq(rhs)), Or(evaleq(lhsNeg), evaleq(rhsNeg))))
    
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

    val rhs = expr.rhs
    val lhs = expr.lhs
    smallstep(And(lhsNeg, rhsNeg))
    smallstep(expr)
    assert(eval(expr) == eval(Or(evaleq(lhs), evaleq(rhs))))
    assert(eval(And(lhsNeg, rhsNeg)) == eval(And(evaleq(lhsNeg), evaleq(rhsNeg))))
    
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

  @library
  def flattenConservationTheorem(e : Expr) : Unit = {
    decreases(complexity(e))
    e match
      case And(lhs, rhs) => lhs match
        case And(lhs1, rhs1) =>
          flattenConservationTheorem(lhs)
          assert(eval(flatten(lhs)) == eval(lhs))
          flattenConservationTheorem(rhs)
          assert(eval(flatten(rhs)) == eval(rhs))
          chainConservation(flatten(lhs), flatten(rhs))
          assert(eval(chainTwoFlattened(flatten(lhs), flatten(rhs))) == eval(And(flatten(lhs), flatten(rhs))))
        case _ => rhs match
          case And(lhs1, rhs1) =>
            flattenConservationTheorem(rhs)
          case _ => ()
      case _ => ()
  }.ensuring(eval(flatten(e)) == eval(e))

  @library
  def simpleAndSimplify(e : And) : Expr = {
    require(inferredType(e) != Untyped)
    (e.lhs, e.rhs) match
      case (BooleanLiteral(false), t) => BooleanLiteral(false)
      case (BooleanLiteral(true), t) => t
      case (t, BooleanLiteral(true)) => t
      case _ => e
  }

  @library
  def isNotError(e : Expr) : Boolean = {
    eval(e) match
      case BooleanResult(result) => result match
        case Some(v) => true
        case None() => false
    
      case IntResult(result) => result match
        case Some(v) => true
        case None() => false
    
      case UnitResult => true
      case TypeErr => false
  }

  @library
  def simpleAndConserve(e : And) : Unit = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)

    (e.lhs, e.rhs) match
      case (BooleanLiteral(false), t) => ()
      case (BooleanLiteral(true), t) => ()
      case (t, BooleanLiteral(true)) => ()
      case _ => ()
  }.ensuring(eval(e) == eval(simpleAndSimplify(e)))

  @library
  def flatAndTakeWhileTrue(e : Expr) : Expr = {
    require(isAndFlat(e))
    e match
      case And(lhs, rhs) => lhs match
        case BooleanLiteral(false) => lhs
        case BooleanLiteral(true) => flatAndTakeWhileTrue(rhs)
        case _ => And(lhs, flatAndTakeWhileTrue(rhs))
      case _ => e
  }.ensuring(res => isAndFlat(res))

  /**
      * This theorem states that flatAndTakeWhileTrue if called on e conserves the value of e
      * If e is evaluated to a non error and has booleantype
      *
      * @param e
      */
  @library
  def flatATWTConserve(e : Expr) : Unit = {
    require(isAndFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case And(lhs, rhs) => lhs match
        case BooleanLiteral(false) => simpleAndConserve(And(lhs, rhs))
        case BooleanLiteral(true) =>
          simpleAndConserve(And(lhs, rhs))
          flatATWTConserve(rhs)
        case _ => flatATWTConserve(rhs)
      case _ => ()
  }.ensuring(eval(flatAndTakeWhileTrue(e)) == eval(e))

  @library
  def truthsOrFalse(e : Expr) : BigInt = {
    decreases(complexity(e))
    e match
      case BooleanLiteral(value) => 1
      case And(lhs, rhs) => truthsOrFalse(lhs) + truthsOrFalse(rhs)
      case _ => 0
  }

  @library
  def flatATWTOneTrue(e : Expr) : Unit = {
    require(isAndFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case And(lhs, rhs) => lhs match
        case BooleanLiteral(false) => ()
        case BooleanLiteral(true) =>
          flatATWTOneTrue(rhs)
        case _ =>
          flatATWTOneTrue(rhs)
      case _ => ()
  }.ensuring(truthsOrFalse(flatAndTakeWhileTrue(e)) <= 1)

  
  /** $encodingof `&&`-expressions with arbitrary number of operands, and simplified.
   * @see [[lang.Trees.And And]]
   */
  @library
  def and(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)
    require(isNotError(e))

    flattenConservationTheorem(e)
    // mutable
    val flat : Expr = flatten(e)
    assert(eval(flat) == eval(e))

    typeInsurance(flat)
    // This says that flatAndTakewhile of flat conserves value
    flatATWTConserve(flat)
    // This code collects all except true literals or takes first false.
    val simpler = flatAndTakeWhileTrue(flat)
    assert(eval(simpler) == eval(e))

    simpler
  }.ensuring(res => eval(res) == eval(e))

}


object OrOptimization {
  import AndOptimization.isNotError

  /**
      * Ensures the flat trait.
      * The flat trait is basically that there can be no And:s in the right hand side
      *
      * @param e
      * @return
      */
  @library
  def isOrFlat(e: Expr) : Boolean = {
    decreases(complexity(e))
    e match
      case Or(lhs, rhs) => lhs match
        case Or(_, _) => false
        case _ => isOrFlat(rhs)
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
    require(isOrFlat(left))
    require(isOrFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case Or(lleft, rleft) => Or(lleft, chainTwoFlattened(rleft, right))
      case _ => Or(left, right)
  }.ensuring(res => isOrFlat(res))
  
  @library
  def chainOrConservation(left: Expr, right: Expr) : Unit = {
    require(isOrFlat(left))
    require(isOrFlat(right))
    decreases(complexity(left))
    left match
      case Or(llhs, rrhs) =>
        chainOrConservation(rrhs, right)
        assert(eval(chainTwoFlattened(rrhs, right)) == eval(Or(rrhs, right)))
        smallstep(Or(left, right))
        assert(eval(Or(left, right)) == eval(Or(evaleq(left),evaleq(right))))
        assert(eval(left) == eval(Or(evaleq(llhs),evaleq(rrhs))))
        // This is what I need to prove
        // Or(lhs1, chainTwoFlattened(lhs1, rhs1))
        // We know that the right hand side equals eval(Or(lhs1, rhs1))
        // This is wrong, eval is not proven because we are doing something else entirely
      case _ => ()
    
  }.ensuring(eval(chainTwoFlattened(left, right)) == eval(Or(left, right)))
  /**
      * Takes an And expression and turns it into a flat And
      * According to definition isAndFlat
      * @param e : Must be And
      * @return Must be flat
      */
  @library
  def flattenOr(e: Expr) : Expr = {
    decreases(complexity(e))
    e match
      case Or(lhs, rhs) => lhs match
        case Or(lhs1, rhs1) => chainTwoFlattened(flattenOr(lhs), flattenOr(rhs))
        case _ => rhs match
          case Or(lhs1, rhs1) => Or(lhs, flattenOr(rhs))
          case _ => e
      case _ => e
  // Ensuring tells us that it is flat
  }.ensuring(res => isOrFlat(res))

  @library
  def flattenConservationTheorem(e : Expr) : Unit = {
    decreases(complexity(e))
    e match
      case Or(lhs, rhs) => lhs match
        case Or(lhs1, rhs1) =>
          flattenConservationTheorem(lhs)
          assert(eval(flattenOr(lhs)) == eval(lhs))
          flattenConservationTheorem(rhs)
          assert(eval(flattenOr(rhs)) == eval(rhs))
          chainOrConservation(flattenOr(lhs), flattenOr(rhs))
          assert(eval(chainTwoFlattened(flattenOr(lhs), flattenOr(rhs))) == eval(Or(flattenOr(lhs), flattenOr(rhs))))
        case _ => rhs match
          case Or(lhs1, rhs1) =>
            flattenConservationTheorem(rhs)
          case _ => ()
      case _ => ()
  }.ensuring(eval(flattenOr(e)) == eval(e))

  @library
  def simpleOrSimplify(e : Or) : Expr = {
    require(inferredType(e) != Untyped)
    (e.lhs, e.rhs) match
      case (BooleanLiteral(true), t) => BooleanLiteral(true)
      case (BooleanLiteral(false), t) => t
      case (t, BooleanLiteral(false)) => t
      case _ => e
  }


  @library
  def simpleOrConserve(e : Or) : Unit = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)
  }.ensuring(eval(e) == eval(simpleOrSimplify(e)))

  @library
  def flatOrTakeWhileTrue(e : Expr) : Expr = {
    require(isOrFlat(e))
    e match
      case Or(lhs, rhs) => lhs match
        case BooleanLiteral(false) => flatOrTakeWhileTrue(rhs)
        case BooleanLiteral(true) => lhs
        case _ => Or(lhs, flatOrTakeWhileTrue(rhs))
      case _ => e
  }.ensuring(res => isOrFlat(res))

  /**
      * This theorem states that flatAndTakeWhileTrue if called on e conserves the value of e
      * If e is evaluated to a non error and has booleantype
      *
      * @param e
      */
  @library
  def flatOTWTConserve(e : Expr) : Unit = {
    require(isOrFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case Or(lhs, rhs) => lhs match
        case BooleanLiteral(false) =>
          simpleOrConserve(Or(lhs, rhs))
          flatOTWTConserve(rhs)
          assert(eval(Or(lhs, rhs)) == eval(rhs))
        case BooleanLiteral(true) =>
          simpleOrConserve(Or(lhs, rhs))
        case _ =>
          flatOTWTConserve(rhs)
      case _ => ()
  
  }.ensuring(eval(flatOrTakeWhileTrue(e)) == eval(e))

  @library
  def truthsOrFalse(e : Expr) : BigInt = {
    decreases(complexity(e))
    e match
      case BooleanLiteral(value) => 1
      case Or(lhs, rhs) => truthsOrFalse(lhs) + truthsOrFalse(rhs)
      case _ => 0
  }

  @library
  def flatOTWTOneTrue(e : Expr) : Unit = {
    require(isOrFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case Or(lhs, rhs) => lhs match
        case BooleanLiteral(true) => ()
        case BooleanLiteral(false) =>
          flatOTWTOneTrue(rhs)
        case _ =>
          flatOTWTOneTrue(rhs)
      case _ => ()
  }.ensuring(truthsOrFalse(flatOrTakeWhileTrue(e)) <= 1)

  
  /** $encodingof `&&`-expressions with arbitrary number of operands, and simplified.
   * @see [[lang.Trees.And And]]
   */
  @library
  def or(e: Expr): Expr = {
    require(inferredType(e) == BooleanType)
    require(isNotError(e))

    flattenConservationTheorem(e)
    // mutable
    val flat : Expr = flattenOr(e)
    assert(eval(flat) == eval(e))

    typeInsurance(flat)
    // This says that flatAndTakewhile of flat conserves value
    flatOTWTConserve(flat)
    // This code collects all except true literals or takes first false.
    val simpler = flatOrTakeWhileTrue(flat)
    assert(eval(simpler) == eval(e))

    simpler
  }.ensuring(res => eval(res) == eval(e))

}
