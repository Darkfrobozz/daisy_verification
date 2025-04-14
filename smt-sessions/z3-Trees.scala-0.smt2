; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!4 () Bool)

(assert start!4)

(declare-datatypes ((Expr!3 0))(
  ( (FMA!2 (fac1!26 Expr!3) (fac2!26 Expr!3) (s!43 Expr!3)) (IntegerLiteral!2 (value!51 Int)) (GreaterThan!2 (lhs!182 Expr!3) (rhs!182 Expr!3)) (LessThan!2 (lhs!183 Expr!3) (rhs!183 Expr!3)) (GreaterEquals!2 (lhs!184 Expr!3) (rhs!184 Expr!3)) (UMinus!2 (expr!85 Expr!3)) (IntPow!2 (base!26 Expr!3) (exp!26 Int)) (Division!2 (lhs!185 Expr!3) (rhs!185 Expr!3)) (Times!2 (lhs!186 Expr!3) (rhs!186 Expr!3)) (LessEquals!2 (lhs!187 Expr!3) (rhs!187 Expr!3)) (Minus!2 (lhs!188 Expr!3) (rhs!188 Expr!3)) )
))
(declare-fun expr!7 () Expr!3)

(declare-fun ExprPrimitiveSize!0 (Expr!3) Int)

(assert (=> start!4 (< (ExprPrimitiveSize!0 expr!7) 0)))

(assert (=> start!4 true))

(declare-fun bs!1 () Bool)

(assert (= bs!1 start!4))

(declare-fun m!13 () Bool)

(assert (=> bs!1 m!13))

(check-sat (not start!4))
(check-sat)
(get-model)

(declare-fun bm!35 () Bool)

(declare-fun call!41 () Int)

(declare-fun call!38 () Int)

(assert (=> bm!35 (= call!41 call!38)))

(declare-fun bm!36 () Bool)

(declare-fun call!40 () Int)

(assert (=> bm!36 (= call!40 call!41)))

(declare-fun b!76 () Bool)

(declare-fun e!45 () Int)

(declare-fun call!53 () Int)

(declare-fun call!47 () Int)

(assert (=> b!76 (= e!45 (+ 1 call!53 call!47))))

(declare-fun b!77 () Bool)

(declare-fun e!43 () Int)

(declare-fun e!44 () Int)

(assert (=> b!77 (= e!43 e!44)))

(declare-fun c!40 () Bool)

(get-info :version)

(assert (=> b!77 (= c!40 ((_ is IntegerLiteral!2) expr!7))))

(declare-fun c!35 () Bool)

(declare-fun c!38 () Bool)

(declare-fun call!48 () Int)

(declare-fun c!41 () Bool)

(declare-fun c!37 () Bool)

(declare-fun bm!37 () Bool)

(declare-fun c!33 () Bool)

(declare-fun c!34 () Bool)

(declare-fun c!36 () Bool)

(declare-fun c!39 () Bool)

(assert (=> bm!37 (= call!48 (ExprPrimitiveSize!0 (ite c!38 (fac1!26 expr!7) (ite c!33 (rhs!182 expr!7) (ite c!37 (lhs!183 expr!7) (ite c!36 (rhs!184 expr!7) (ite c!35 (base!26 expr!7) (ite c!41 (rhs!185 expr!7) (ite c!34 (lhs!186 expr!7) (ite c!39 (rhs!187 expr!7) (lhs!188 expr!7)))))))))))))

(declare-fun bm!38 () Bool)

(declare-fun call!52 () Int)

(declare-fun call!42 () Int)

(assert (=> bm!38 (= call!52 call!42)))

(declare-fun b!78 () Bool)

(declare-fun e!47 () Int)

(declare-fun e!39 () Int)

(assert (=> b!78 (= e!47 e!39)))

(assert (=> b!78 (= c!37 ((_ is LessThan!2) expr!7))))

(declare-fun b!79 () Bool)

(assert (=> b!79 (= c!34 ((_ is Times!2) expr!7))))

(declare-fun e!40 () Int)

(assert (=> b!79 (= e!40 e!45)))

(declare-fun b!80 () Bool)

(declare-fun e!42 () Int)

(declare-fun call!37 () Int)

(assert (=> b!80 (= e!42 (+ 1 call!37))))

(declare-fun bm!39 () Bool)

(assert (=> bm!39 (= call!53 call!40)))

(declare-fun bm!40 () Bool)

(declare-fun call!44 () Int)

(assert (=> bm!40 (= call!42 call!44)))

(declare-fun bm!41 () Bool)

(declare-fun call!50 () Int)

(assert (=> bm!41 (= call!50 call!48)))

(declare-fun b!81 () Bool)

(declare-fun call!43 () Int)

(assert (=> b!81 (= e!40 (+ 1 call!43 call!40))))

(declare-fun bm!42 () Bool)

(declare-fun call!39 () Int)

(assert (=> bm!42 (= call!39 call!50)))

(declare-fun b!82 () Bool)

(declare-fun e!46 () Int)

(assert (=> b!82 (= e!45 e!46)))

(assert (=> b!82 (= c!39 ((_ is LessEquals!2) expr!7))))

(declare-fun b!83 () Bool)

(declare-fun e!48 () Int)

(assert (=> b!83 (= e!48 (+ 1 call!52 call!38))))

(declare-fun bm!43 () Bool)

(assert (=> bm!43 (= call!43 call!37)))

(declare-fun d!3 () Bool)

(declare-fun lt!2 () Int)

(assert (=> d!3 (>= lt!2 0)))

(assert (=> d!3 (= lt!2 e!43)))

(assert (=> d!3 (= c!38 ((_ is FMA!2) expr!7))))

(assert (=> d!3 (= (ExprPrimitiveSize!0 expr!7) lt!2)))

(declare-fun bm!34 () Bool)

(assert (=> bm!34 (= call!47 call!43)))

(declare-fun b!84 () Bool)

(declare-fun e!41 () Int)

(declare-fun call!49 () Int)

(assert (=> b!84 (= e!41 (+ 1 call!41 call!49))))

(declare-fun b!85 () Bool)

(assert (=> b!85 (= c!33 ((_ is GreaterThan!2) expr!7))))

(assert (=> b!85 (= e!44 e!47)))

(declare-fun call!45 () Int)

(declare-fun b!86 () Bool)

(assert (=> b!86 (= e!43 (+ 1 call!48 (ExprPrimitiveSize!0 (fac2!26 expr!7)) call!45))))

(declare-fun bm!44 () Bool)

(declare-fun c!32 () Bool)

(assert (=> bm!44 (= call!45 (ExprPrimitiveSize!0 (ite c!38 (s!43 expr!7) (ite c!33 (lhs!182 expr!7) (ite c!37 (rhs!183 expr!7) (ite c!36 (lhs!184 expr!7) (ite c!32 (expr!85 expr!7) (ite c!41 (lhs!185 expr!7) (ite c!34 (rhs!186 expr!7) (ite c!39 (lhs!187 expr!7) (rhs!188 expr!7)))))))))))))

(declare-fun bm!45 () Bool)

(assert (=> bm!45 (= call!44 call!45)))

(declare-fun b!87 () Bool)

(assert (=> b!87 (= c!35 ((_ is IntPow!2) expr!7))))

(assert (=> b!87 (= e!42 e!41)))

(declare-fun bm!46 () Bool)

(assert (=> bm!46 (= call!37 call!52)))

(declare-fun b!88 () Bool)

(assert (=> b!88 (= e!47 (+ 1 call!44 call!50))))

(declare-fun b!89 () Bool)

(assert (=> b!89 (= e!41 e!40)))

(assert (=> b!89 (= c!41 ((_ is Division!2) expr!7))))

(declare-fun b!90 () Bool)

(assert (=> b!90 (= c!36 ((_ is GreaterEquals!2) expr!7))))

(assert (=> b!90 (= e!39 e!48)))

(declare-fun b!91 () Bool)

(declare-fun call!46 () Int)

(declare-fun call!51 () Int)

(assert (=> b!91 (= e!46 (+ 1 call!46 call!51))))

(declare-fun bm!47 () Bool)

(assert (=> bm!47 (= call!51 call!47)))

(declare-fun bm!48 () Bool)

(declare-fun BigIntAbs!0 (Int) Int)

(assert (=> bm!48 (= call!49 (BigIntAbs!0 (ite c!40 (value!51 expr!7) (exp!26 expr!7))))))

(declare-fun b!92 () Bool)

(assert (=> b!92 (= e!44 (+ 1 call!49))))

(declare-fun b!93 () Bool)

(assert (=> b!93 (= e!46 (+ 1 call!51 call!46))))

(declare-fun b!94 () Bool)

(assert (=> b!94 (= e!48 e!42)))

(assert (=> b!94 (= c!32 ((_ is UMinus!2) expr!7))))

(declare-fun bm!49 () Bool)

(assert (=> bm!49 (= call!38 call!39)))

(declare-fun b!95 () Bool)

(assert (=> b!95 (= e!39 (+ 1 call!39 call!42))))

(declare-fun bm!50 () Bool)

(assert (=> bm!50 (= call!46 call!53)))

(assert (= (and d!3 c!38) b!86))

(assert (= (and d!3 (not c!38)) b!77))

(assert (= (and b!77 c!40) b!92))

(assert (= (and b!77 (not c!40)) b!85))

(assert (= (and b!85 c!33) b!88))

(assert (= (and b!85 (not c!33)) b!78))

(assert (= (and b!78 c!37) b!95))

(assert (= (and b!78 (not c!37)) b!90))

(assert (= (and b!90 c!36) b!83))

(assert (= (and b!90 (not c!36)) b!94))

(assert (= (and b!94 c!32) b!80))

(assert (= (and b!94 (not c!32)) b!87))

(assert (= (and b!87 c!35) b!84))

(assert (= (and b!87 (not c!35)) b!89))

(assert (= (and b!89 c!41) b!81))

(assert (= (and b!89 (not c!41)) b!79))

(assert (= (and b!79 c!34) b!76))

(assert (= (and b!79 (not c!34)) b!82))

(assert (= (and b!82 c!39) b!93))

(assert (= (and b!82 (not c!39)) b!91))

(assert (= (or b!93 b!91) bm!47))

(assert (= (or b!93 b!91) bm!50))

(assert (= (or b!76 bm!50) bm!39))

(assert (= (or b!76 bm!47) bm!34))

(assert (= (or b!81 bm!39) bm!36))

(assert (= (or b!81 bm!34) bm!43))

(assert (= (or b!84 bm!36) bm!35))

(assert (= (or b!80 bm!43) bm!46))

(assert (= (or b!83 bm!46) bm!38))

(assert (= (or b!83 bm!35) bm!49))

(assert (= (or b!95 bm!38) bm!40))

(assert (= (or b!95 bm!49) bm!42))

(assert (= (or b!88 bm!42) bm!41))

(assert (= (or b!88 bm!40) bm!45))

(assert (= (or b!92 b!84) bm!48))

(assert (= (or b!86 bm!45) bm!44))

(assert (= (or b!86 bm!41) bm!37))

(declare-fun m!15 () Bool)

(assert (=> bm!37 m!15))

(declare-fun m!17 () Bool)

(assert (=> b!86 m!17))

(declare-fun m!19 () Bool)

(assert (=> bm!44 m!19))

(declare-fun m!21 () Bool)

(assert (=> bm!48 m!21))

(assert (=> start!4 d!3))

(check-sat (not bm!37) (not bm!44) (not bm!48) (not b!86))
(check-sat)
