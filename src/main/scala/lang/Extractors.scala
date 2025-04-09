// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany

package lang

import stainless.collection.*
import stainless.collection.List.*

import Trees._

object Extractors {

  object ArithOperator {

    def unapply(expr: Expr): Option[(List[Expr], (List[Expr]) => Expr)] = expr match {
      case UMinus(t) =>
        Some((List(t), (es: List[Expr]) => UMinus(es.head)))
      case Plus(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Plus(es(0), es(1)))
      case Minus(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Minus(es(0), es(1)))
      case Times(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Times(es(0), es(1)))
      case FMA(t1, t2, t3) =>
        Some(List(t1,t2,t3), (es: List[Expr]) => FMA(es(0), es(1), es(2)))
      case Division(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Division(es(0), es(1)))
//      case Pow(t1, t2) =>
//        Some(List(t1, t2), (es: List[Expr]) => Pow(es(0), es(1)))
      case IntPow(t1, n) =>
        Some(List(t1), (es: List[Expr]) => IntPow(es(0), n))
      case _ =>
        None
    }
  }

  object Operator {
    // IMPROVEMENT: in Leon there are simplifications included here
    // they are not currently taken over, because we would be changing
    // the tree behind the scenes and it may break other stuff
    def unapply(expr: Expr): Option[(List[Expr], (List[Expr]) => Expr)] = expr match {
      /* Unary operators */
      // Logic
      case Not(t) =>
        Some((List(t), (es: List[Expr]) => Not(es.head)))

        // Arthimetic
      case UMinus(t) =>
        Some((List(t), (es: List[Expr]) => UMinus(es.head)))
      case Plus(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Plus(es(0), es(1)))
      case Minus(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Minus(es(0), es(1)))
      case Times(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Times(es(0), es(1)))
      case FMA(t1, t2, t3) =>
        Some(List(t1,t2,t3), (es: List[Expr]) => FMA(es(0), es(1), es(2)))
      case Division(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Division(es(0), es(1)))
      case IntPow(t1, n) =>
        Some(List(t1), (es: List[Expr]) => IntPow(es(0), n))

      // Logic
      case Equals(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Equals(es(0), es(1)))
      case Implies(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => Implies(es(0), es(1)))
      case LessThan(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => LessThan(es(0), es(1)))
      case GreaterThan(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => GreaterThan(es(0), es(1)))
      case LessEquals(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => LessEquals(es(0), es(1)))
      case GreaterEquals(t1, t2) =>
        Some(List(t1, t2), (es: List[Expr]) => GreaterEquals(es(0), es(1)))

      case And(args) => Some((args, And.apply))
      case Or(args) => Some((args, Or.apply))

      /* Terminals */
      // case t: Terminal => Some(List[Expr](), (_: List[Expr]) => t)
    }
  }
}