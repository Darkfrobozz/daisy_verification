; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!8 () Bool)

(assert start!8)

(declare-datatypes ((Expr!4 0))(
  ( (FMA!3 (fac1!27 Expr!4) (fac2!27 Expr!4) (s!45 Expr!4)) (IntegerLiteral!3 (value!53 Int)) (GreaterThan!3 (lhs!189 Expr!4) (rhs!189 Expr!4)) (LessThan!3 (lhs!190 Expr!4) (rhs!190 Expr!4)) (GreaterEquals!3 (lhs!191 Expr!4) (rhs!191 Expr!4)) (UMinus!3 (expr!86 Expr!4)) (IntPow!3 (base!27 Expr!4) (exp!27 Int)) (Division!3 (lhs!192 Expr!4) (rhs!192 Expr!4)) (Times!3 (lhs!193 Expr!4) (rhs!193 Expr!4)) (LessEquals!3 (lhs!194 Expr!4) (rhs!194 Expr!4)) (Minus!3 (lhs!195 Expr!4) (rhs!195 Expr!4)) )
))
(declare-fun expr!7 () Expr!4)

(get-info :version)

(assert (=> start!8 false))

(assert (=> start!8 true))

(check-sat)
