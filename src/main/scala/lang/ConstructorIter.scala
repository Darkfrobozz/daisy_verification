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
import Constructors.*

object NegateProof {
  // @library
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


  // @library
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


  // @library
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

  // @library
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
}

object ArthSimple {

  // @library
  def conservationPlusTheorem(lhs: Expr, rhs: Expr) : Unit = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match
        case (IntegerLiteral(bi), _) if bi == 0 => ()
        case (_, IntegerLiteral(bi)) if bi == 0 => ()
        case _ => ()
  }.ensuring(eval(plus(lhs, rhs)) == eval(Plus(lhs, rhs)))

  // @library
  def conservationMinus(lhs: Expr, rhs: Expr): Unit = {
    require(inferredType(lhs) == IntegerType)
    require(inferredType(rhs) == IntegerType)
    (lhs, rhs) match {
      case (_, IntegerLiteral(bi)) if bi == 0 => ()
      case (IntegerLiteral(bi), _) if bi == 0 => ()
      case _ => ()
    }
  }.ensuring(eval(minus(lhs, rhs)) == eval(Minus(lhs, rhs)))

  
  // @library
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
  // @library
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
  // @library
  def chainTwoFlattened(left : Expr, right: Expr) : Expr = {
    require(isAndFlat(left))
    require(isAndFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case And(lleft, rleft) => And(lleft, chainTwoFlattened(rleft, right))
      case _ => And(left, right)
  }.ensuring(res => isAndFlat(res))

  // @library
  def chainTwoFlattenedComplex(left: Expr, right: Expr) : Unit = {
    require(isAndFlat(left))
    require(isAndFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case And(lleft, rleft) =>
        chainTwoFlattenedComplex(rleft, right)
      case _ => ()
  }.ensuring(complexity(chainTwoFlattened(left, right)) == complexity(And(left, right)))
  
  // @library
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
  // @library
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

  // @library
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

  // @library
  def flattenComplexityPreserve(e: Expr) : Unit = {
    decreases(complexity(e))
    e match
      case And(lhs, rhs) => lhs match
        case And(lhs1, rhs1) =>
          // chainTwoFlattened(flatten(lhs), flatten(rhs))
          flattenComplexityPreserve(lhs)
          flattenComplexityPreserve(rhs)
          chainTwoFlattenedComplex(flatten(lhs), flatten(rhs))
        case _ => rhs match
          case And(lhs1, rhs1) =>
            flattenComplexityPreserve(rhs)
            // And(lhs, flatten(rhs))
          case _ => ()
      case _ => ()
  // Ensuring tells us that it is flat
  }.ensuring(complexity(flatten(e)) <= complexity(e))
  

  // @library
  def simpleAndSimplify(e : And) : Expr = {
    require(inferredType(e) != Untyped)
    (e.lhs, e.rhs) match
      case (BooleanLiteral(false), t) => BooleanLiteral(false)
      case (BooleanLiteral(true), t) => t
      case (t, BooleanLiteral(true)) => t
      case _ => e
  }.ensuring(res => complexity(e) <= complexity(e))

  // @library
  def simpleAndConserve(e : And) : Unit = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)

    (e.lhs, e.rhs) match
      case (BooleanLiteral(false), t) => ()
      case (BooleanLiteral(true), t) => ()
      case (t, BooleanLiteral(true)) => ()
      case _ => ()
  }.ensuring(eval(e) == eval(simpleAndSimplify(e)))


  // @library
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
  // @library
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

  // @library
  def flatATWTSizeConserve(e : Expr) : Unit = {
    require(isAndFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case And(lhs, rhs) => lhs match
        case BooleanLiteral(false) => ()
        case BooleanLiteral(true) => flatATWTSizeConserve(rhs)
        case _ => flatATWTSizeConserve(rhs)
      case _ => ()
  }.ensuring(complexity(flatAndTakeWhileTrue(e)) <= complexity(e))

  // @library
  def truthsOrFalse(e : Expr) : BigInt = {
    decreases(complexity(e))
    e match
      case BooleanLiteral(value) => 1
      case And(lhs, rhs) => truthsOrFalse(lhs) + truthsOrFalse(rhs)
      case _ => 0
  }

  // @library
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
}


object OrOptimization {

  /**
      * Ensures the flat trait.
      * The flat trait is basically that there can be no And:s in the right hand side
      *
      * @param e
      * @return
      */
  // @library
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
  // @library
  def chainTwoFlattened(left : Expr, right: Expr) : Expr = {
    require(isOrFlat(left))
    require(isOrFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case Or(lleft, rleft) => Or(lleft, chainTwoFlattened(rleft, right))
      case _ => Or(left, right)
  }.ensuring(res => isOrFlat(res))
  
  // @library
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

  // @library
  def chainTwoFlattenedComplex(left: Expr, right: Expr) : Unit = {
    require(isOrFlat(left))
    require(isOrFlat(right))
    decreases(complexity(left))
    left match
      // rhs just went away though
      case Or(lleft, rleft) =>
        chainTwoFlattenedComplex(rleft, right)
      case _ => ()
  }.ensuring(complexity(chainTwoFlattened(left, right)) == complexity(Or(left, right)))  

  /**
      * Takes an And expression and turns it into a flat And
      * According to definition isAndFlat
      * @param e : Must be And
      * @return Must be flat
      */
  // @library
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

  // @library
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

  // @library
  def flattenComplexityPreserve(e: Expr) : Unit = {
    decreases(complexity(e))
    e match
      case Or(lhs, rhs) => lhs match
        case Or(lhs1, rhs1) =>
          // chainTwoFlattened(flattenOr(lhs), flattenOr(rhs))
          flattenComplexityPreserve(lhs)
          flattenComplexityPreserve(rhs)
          chainTwoFlattenedComplex(flattenOr(lhs), flattenOr(rhs))
        case _ => rhs match
          case Or(lhs1, rhs1) =>
            flattenComplexityPreserve(rhs)
            // And(lhs, flatten(rhs))
          case _ => ()
      case _ => ()
  // Ensuring tells us that it is flat
  }.ensuring(complexity(flattenOr(e)) <= complexity(e))


  // @library
  def simpleOrSimplify(e : Or) : Expr = {
    require(inferredType(e) != Untyped)
    (e.lhs, e.rhs) match
      case (BooleanLiteral(true), t) => BooleanLiteral(true)
      case (BooleanLiteral(false), t) => t
      case (t, BooleanLiteral(false)) => t
      case _ => e
  }.ensuring(res => complexity(res) <= complexity(e))


  // @library
  def simpleOrConserve(e : Or) : Unit = {
    require(inferredType(e) == BooleanType)
    typeInsurance(e)
  }.ensuring(eval(e) == eval(simpleOrSimplify(e)))

  // @library
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
  // @library
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

  // @library
  def flatOTWTConserveSize(e : Expr) : Unit = {
    require(isOrFlat(e))
    require(inferredType(e) == BooleanType)
    e match
      case Or(lhs, rhs) => lhs match
        case BooleanLiteral(false) =>
          flatOTWTConserveSize(rhs)
        case BooleanLiteral(true) => ()
        case _ =>  
          flatOTWTConserveSize(rhs)
      case _ => ()
  }.ensuring(complexity(flatOrTakeWhileTrue(e)) <= complexity(e))

  // @library
  def truthsOrFalse(e : Expr) : BigInt = {
    decreases(complexity(e))
    e match
      case BooleanLiteral(value) => 1
      case Or(lhs, rhs) => truthsOrFalse(lhs) + truthsOrFalse(rhs)
      case _ => 0
  }

  // @library
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
}
