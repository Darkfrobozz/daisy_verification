; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!12 () Bool)

(assert start!12)

(declare-fun b!410 () Bool)

(declare-fun tp!564 () Bool)

(declare-fun tp!554 () Bool)

(declare-datatypes ((Expr!5 0))(
  ( (FMA!4 (fac1!28 Expr!5) (fac2!28 Expr!5) (s!47 Expr!5)) (IntegerLiteral!4 (value!55 Int)) (LessThan!4 (lhs!196 Expr!5) (rhs!196 Expr!5)) (LessEquals!4 (lhs!197 Expr!5) (rhs!197 Expr!5)) (GreaterThan!4 (lhs!198 Expr!5) (rhs!198 Expr!5)) (Minus!4 (lhs!199 Expr!5) (rhs!199 Expr!5)) (UMinus!4 (expr!87 Expr!5)) (IntPow!4 (base!28 Expr!5) (exp!28 Int)) (Division!4 (lhs!200 Expr!5) (rhs!200 Expr!5)) (Times!4 (lhs!201 Expr!5) (rhs!201 Expr!5)) (GreaterEquals!4 (lhs!202 Expr!5) (rhs!202 Expr!5)) )
))
(declare-fun expr!7 () Expr!5)

(declare-fun e!100 () Bool)

(declare-fun inv!8 (Expr!5) Bool)

(assert (=> b!410 (= e!100 (and (inv!8 (lhs!200 expr!7)) tp!564 (inv!8 (rhs!200 expr!7)) tp!554))))

(declare-fun b!411 () Bool)

(declare-fun tp!563 () Bool)

(assert (=> b!411 (= e!100 (and (inv!8 (base!28 expr!7)) tp!563))))

(declare-fun tp!569 () Bool)

(declare-fun tp!561 () Bool)

(declare-fun b!412 () Bool)

(assert (=> b!412 (= e!100 (and (inv!8 (lhs!196 expr!7)) tp!569 (inv!8 (rhs!196 expr!7)) tp!561))))

(get-info :version)

(assert (=> start!12 false))

(assert (=> start!12 (and (inv!8 expr!7) e!100)))

(declare-fun b!413 () Bool)

(declare-fun tp!562 () Bool)

(declare-fun tp!553 () Bool)

(assert (=> b!413 (= e!100 (and (inv!8 (lhs!199 expr!7)) tp!562 (inv!8 (rhs!199 expr!7)) tp!553))))

(declare-fun b!414 () Bool)

(declare-fun tp!565 () Bool)

(declare-fun tp!556 () Bool)

(assert (=> b!414 (= e!100 (and (inv!8 (lhs!197 expr!7)) tp!565 (inv!8 (rhs!197 expr!7)) tp!556))))

(declare-fun tp!558 () Bool)

(declare-fun tp!568 () Bool)

(declare-fun b!415 () Bool)

(assert (=> b!415 (= e!100 (and (inv!8 (lhs!202 expr!7)) tp!558 (inv!8 (rhs!202 expr!7)) tp!568))))

(declare-fun tp!555 () Bool)

(declare-fun tp!551 () Bool)

(declare-fun b!416 () Bool)

(declare-fun tp!567 () Bool)

(assert (=> b!416 (= e!100 (and (inv!8 (fac1!28 expr!7)) tp!551 (inv!8 (fac2!28 expr!7)) tp!567 (inv!8 (s!47 expr!7)) tp!555))))

(declare-fun b!417 () Bool)

(declare-fun tp!552 () Bool)

(declare-fun tp!560 () Bool)

(assert (=> b!417 (= e!100 (and (inv!8 (lhs!201 expr!7)) tp!552 (inv!8 (rhs!201 expr!7)) tp!560))))

(declare-fun b!418 () Bool)

(declare-fun tp!557 () Bool)

(assert (=> b!418 (= e!100 (and (inv!8 (expr!87 expr!7)) tp!557))))

(declare-fun tp!559 () Bool)

(declare-fun b!419 () Bool)

(declare-fun tp!566 () Bool)

(assert (=> b!419 (= e!100 (and (inv!8 (lhs!198 expr!7)) tp!559 (inv!8 (rhs!198 expr!7)) tp!566))))

(assert (= (and start!12 ((_ is FMA!4) expr!7)) b!416))

(assert (= (and start!12 ((_ is LessThan!4) expr!7)) b!412))

(assert (= (and start!12 ((_ is LessEquals!4) expr!7)) b!414))

(assert (= (and start!12 ((_ is GreaterThan!4) expr!7)) b!419))

(assert (= (and start!12 ((_ is Minus!4) expr!7)) b!413))

(assert (= (and start!12 ((_ is UMinus!4) expr!7)) b!418))

(assert (= (and start!12 ((_ is IntPow!4) expr!7)) b!411))

(assert (= (and start!12 ((_ is Division!4) expr!7)) b!410))

(assert (= (and start!12 ((_ is Times!4) expr!7)) b!417))

(assert (= (and start!12 ((_ is GreaterEquals!4) expr!7)) b!415))

(declare-fun m!865 () Bool)

(assert (=> b!416 m!865))

(declare-fun m!867 () Bool)

(assert (=> b!416 m!867))

(declare-fun m!869 () Bool)

(assert (=> b!416 m!869))

(declare-fun m!871 () Bool)

(assert (=> b!418 m!871))

(declare-fun m!873 () Bool)

(assert (=> b!415 m!873))

(declare-fun m!875 () Bool)

(assert (=> b!415 m!875))

(declare-fun m!877 () Bool)

(assert (=> b!417 m!877))

(declare-fun m!879 () Bool)

(assert (=> b!417 m!879))

(declare-fun m!881 () Bool)

(assert (=> b!414 m!881))

(declare-fun m!883 () Bool)

(assert (=> b!414 m!883))

(declare-fun m!885 () Bool)

(assert (=> b!411 m!885))

(declare-fun m!887 () Bool)

(assert (=> b!419 m!887))

(declare-fun m!889 () Bool)

(assert (=> b!419 m!889))

(declare-fun m!891 () Bool)

(assert (=> b!413 m!891))

(declare-fun m!893 () Bool)

(assert (=> b!413 m!893))

(declare-fun m!895 () Bool)

(assert (=> b!410 m!895))

(declare-fun m!897 () Bool)

(assert (=> b!410 m!897))

(declare-fun m!899 () Bool)

(assert (=> b!412 m!899))

(declare-fun m!901 () Bool)

(assert (=> b!412 m!901))

(declare-fun m!903 () Bool)

(assert (=> start!12 m!903))

(check-sat (not b!412) (not b!417) (not b!411) (not b!413) (not b!414) (not b!410) (not b!415) (not b!418) (not start!12) (not b!416) (not b!419))
(check-sat)
