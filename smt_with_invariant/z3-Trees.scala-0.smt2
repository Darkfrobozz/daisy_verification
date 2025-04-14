; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!4 () Bool)

(assert start!4)

(declare-fun e!21 () Bool)

(declare-fun tp!55 () Bool)

(declare-datatypes ((Expr!3 0))(
  ( (FMA!2 (fac1!26 Expr!3) (fac2!26 Expr!3) (s!43 Expr!3)) (IntegerLiteral!2 (value!51 Int)) (LessThan!2 (lhs!182 Expr!3) (rhs!182 Expr!3)) (LessEquals!2 (lhs!183 Expr!3) (rhs!183 Expr!3)) (GreaterThan!2 (lhs!184 Expr!3) (rhs!184 Expr!3)) (Minus!2 (lhs!185 Expr!3) (rhs!185 Expr!3)) (UMinus!2 (expr!85 Expr!3)) (IntPow!2 (base!26 Expr!3) (exp!26 Int)) (Division!2 (lhs!186 Expr!3) (rhs!186 Expr!3)) (Times!2 (lhs!187 Expr!3) (rhs!187 Expr!3)) (GreaterEquals!2 (lhs!188 Expr!3) (rhs!188 Expr!3)) )
))
(declare-fun thiss!24 () Expr!3)

(declare-fun tp!42 () Bool)

(declare-fun b!56 () Bool)

(declare-fun inv!8 (Expr!3) Bool)

(assert (=> b!56 (= e!21 (and (inv!8 (lhs!188 thiss!24)) tp!55 (inv!8 (rhs!188 thiss!24)) tp!42))))

(declare-fun tp!52 () Bool)

(declare-fun b!57 () Bool)

(declare-fun tp!45 () Bool)

(assert (=> b!57 (= e!21 (and (inv!8 (lhs!184 thiss!24)) tp!52 (inv!8 (rhs!184 thiss!24)) tp!45))))

(declare-fun b!58 () Bool)

(declare-fun tp!48 () Bool)

(assert (=> b!58 (= e!21 (and (inv!8 (base!26 thiss!24)) tp!48))))

(declare-fun b!59 () Bool)

(declare-fun tp!43 () Bool)

(assert (=> b!59 (= e!21 (and (inv!8 (expr!85 thiss!24)) tp!43))))

(declare-fun tp!54 () Bool)

(declare-fun tp!51 () Bool)

(declare-fun b!60 () Bool)

(assert (=> b!60 (= e!21 (and (inv!8 (lhs!182 thiss!24)) tp!54 (inv!8 (rhs!182 thiss!24)) tp!51))))

(declare-fun tp!49 () Bool)

(declare-fun tp!44 () Bool)

(declare-fun b!61 () Bool)

(assert (=> b!61 (= e!21 (and (inv!8 (lhs!186 thiss!24)) tp!49 (inv!8 (rhs!186 thiss!24)) tp!44))))

(declare-fun tp!56 () Bool)

(declare-fun tp!50 () Bool)

(declare-fun b!62 () Bool)

(assert (=> b!62 (= e!21 (and (inv!8 (lhs!185 thiss!24)) tp!56 (inv!8 (rhs!185 thiss!24)) tp!50))))

(declare-fun tp!53 () Bool)

(declare-fun tp!38 () Bool)

(declare-fun b!63 () Bool)

(declare-fun tp!40 () Bool)

(assert (=> b!63 (= e!21 (and (inv!8 (fac1!26 thiss!24)) tp!38 (inv!8 (fac2!26 thiss!24)) tp!53 (inv!8 (s!43 thiss!24)) tp!40))))

(assert (=> start!4 false))

(assert (=> start!4 (and (inv!8 thiss!24) e!21)))

(declare-fun tp!46 () Bool)

(declare-fun tp!39 () Bool)

(declare-fun b!64 () Bool)

(assert (=> b!64 (= e!21 (and (inv!8 (lhs!183 thiss!24)) tp!39 (inv!8 (rhs!183 thiss!24)) tp!46))))

(declare-fun b!65 () Bool)

(declare-fun tp!47 () Bool)

(declare-fun tp!41 () Bool)

(assert (=> b!65 (= e!21 (and (inv!8 (lhs!187 thiss!24)) tp!47 (inv!8 (rhs!187 thiss!24)) tp!41))))

(get-info :version)

(assert (= (and start!4 ((_ is FMA!2) thiss!24)) b!63))

(assert (= (and start!4 ((_ is LessThan!2) thiss!24)) b!60))

(assert (= (and start!4 ((_ is LessEquals!2) thiss!24)) b!64))

(assert (= (and start!4 ((_ is GreaterThan!2) thiss!24)) b!57))

(assert (= (and start!4 ((_ is Minus!2) thiss!24)) b!62))

(assert (= (and start!4 ((_ is UMinus!2) thiss!24)) b!59))

(assert (= (and start!4 ((_ is IntPow!2) thiss!24)) b!58))

(assert (= (and start!4 ((_ is Division!2) thiss!24)) b!61))

(assert (= (and start!4 ((_ is Times!2) thiss!24)) b!65))

(assert (= (and start!4 ((_ is GreaterEquals!2) thiss!24)) b!56))

(declare-fun m!13 () Bool)

(assert (=> b!59 m!13))

(declare-fun m!15 () Bool)

(assert (=> b!64 m!15))

(declare-fun m!17 () Bool)

(assert (=> b!64 m!17))

(declare-fun m!19 () Bool)

(assert (=> start!4 m!19))

(declare-fun m!21 () Bool)

(assert (=> b!60 m!21))

(declare-fun m!23 () Bool)

(assert (=> b!60 m!23))

(declare-fun m!25 () Bool)

(assert (=> b!61 m!25))

(declare-fun m!27 () Bool)

(assert (=> b!61 m!27))

(declare-fun m!29 () Bool)

(assert (=> b!62 m!29))

(declare-fun m!31 () Bool)

(assert (=> b!62 m!31))

(declare-fun m!33 () Bool)

(assert (=> b!56 m!33))

(declare-fun m!35 () Bool)

(assert (=> b!56 m!35))

(declare-fun m!37 () Bool)

(assert (=> b!57 m!37))

(declare-fun m!39 () Bool)

(assert (=> b!57 m!39))

(declare-fun m!41 () Bool)

(assert (=> b!65 m!41))

(declare-fun m!43 () Bool)

(assert (=> b!65 m!43))

(declare-fun m!45 () Bool)

(assert (=> b!63 m!45))

(declare-fun m!47 () Bool)

(assert (=> b!63 m!47))

(declare-fun m!49 () Bool)

(assert (=> b!63 m!49))

(declare-fun m!51 () Bool)

(assert (=> b!58 m!51))

(check-sat (not b!58) (not start!4) (not b!60) (not b!61) (not b!56) (not b!59) (not b!64) (not b!63) (not b!57) (not b!62) (not b!65))
(check-sat)
