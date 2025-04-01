// Original work Copyright 2009-2016 EPFL, Lausanne
// Modified work Copyright 2017 MPI-SWS, Saarbruecken, Germany

package lang

import scala.collection.immutable.Seq

import Trees._
import Constructors._

object Extractors {

  object ArithOperator {

    def unapply(expr: Expr): Option[(Seq[Expr], (Seq[Expr]) => Expr)] = expr match {
      case UMinus(t) =>
        Some((Seq(t), (es: Seq[Expr]) => UMinus(es.head)))
      case Plus(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Plus(es(0), es(1)))
      case Minus(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Minus(es(0), es(1)))
      case Times(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Times(es(0), es(1)))
      case FMA(t1, t2, t3) =>
        Some(Seq(t1,t2,t3), (es: Seq[Expr]) => FMA(es(0), es(1), es(2)))
      case Division(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Division(es(0), es(1)))
//      case Pow(t1, t2) =>
//        Some(Seq(t1, t2), (es: Seq[Expr]) => Pow(es(0), es(1)))
      case IntPow(t1, n) =>
        Some(Seq(t1), (es: Seq[Expr]) => IntPow(es(0), n))
      case _ =>
        None
    }
  }

  object Operator {
    // IMPROVEMENT: in Leon there are simplifications included here
    // they are not currently taken over, because we would be changing
    // the tree behind the scenes and it may break other stuff
    def unapply(expr: Expr): Option[(Seq[Expr], (Seq[Expr]) => Expr)] = expr match {
      /* Unary operators */
      // Logic
      case Not(t) =>
        Some((Seq(t), (es: Seq[Expr]) => Not(es.head)))

        // Arthimetic
      case UMinus(t) =>
        Some((Seq(t), (es: Seq[Expr]) => UMinus(es.head)))
      case Plus(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Plus(es(0), es(1)))
      case Minus(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Minus(es(0), es(1)))
      case Times(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Times(es(0), es(1)))
      case FMA(t1, t2, t3) =>
        Some(Seq(t1,t2,t3), (es: Seq[Expr]) => FMA(es(0), es(1), es(2)))
      case Division(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Division(es(0), es(1)))
      case IntPow(t1, n) =>
        Some(Seq(t1), (es: Seq[Expr]) => IntPow(es(0), n))

      // Logic
      case Equals(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Equals(es(0), es(1)))
      case Implies(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => Implies(es(0), es(1)))
      case LessThan(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => LessThan(es(0), es(1)))
      case GreaterThan(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => GreaterThan(es(0), es(1)))
      case LessEquals(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => LessEquals(es(0), es(1)))
      case GreaterEquals(t1, t2) =>
        Some(Seq(t1, t2), (es: Seq[Expr]) => GreaterEquals(es(0), es(1)))

      case And(args) => Some((args, and))
      case Or(args) => Some((args, or))

      /* Terminals */
      case t: Terminal => Some(Seq[Expr](), (_: Seq[Expr]) => t)
    }
  }
}