; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!158 () Bool)

(assert start!158)

(declare-fun res!208 () Bool)

(declare-fun e!2315 () Bool)

(assert (=> start!158 (=> (not res!208) (not e!2315))))

(declare-datatypes ((Expr!33 0))(
  ( (FMA!32 (fac1!56 Expr!33) (fac2!56 Expr!33) (s!103 Expr!33)) (IntegerLiteral!32 (value!111 Int)) (GreaterThan!32 (lhs!392 Expr!33) (rhs!392 Expr!33)) (LessThan!32 (lhs!393 Expr!33) (rhs!393 Expr!33)) (GreaterEquals!32 (lhs!394 Expr!33) (rhs!394 Expr!33)) (UMinus!32 (expr!124 Expr!33)) (IntPow!32 (base!56 Expr!33) (exp!56 Int)) (Division!32 (lhs!395 Expr!33) (rhs!395 Expr!33)) (Times!32 (lhs!396 Expr!33) (rhs!396 Expr!33)) (LessEquals!32 (lhs!397 Expr!33) (rhs!397 Expr!33)) (Minus!32 (lhs!398 Expr!33) (rhs!398 Expr!33)) )
))
(declare-fun expr!7 () Expr!33)

(get-info :version)

(assert (=> start!158 (= res!208 (and (not ((_ is IntegerLiteral!32) expr!7)) (not ((_ is Minus!32) expr!7)) (not ((_ is UMinus!32) expr!7)) (not ((_ is Times!32) expr!7)) (not ((_ is FMA!32) expr!7)) (not ((_ is Division!32) expr!7)) (not ((_ is IntPow!32) expr!7)) (not ((_ is LessThan!32) expr!7)) (not ((_ is GreaterThan!32) expr!7)) (not ((_ is LessEquals!32) expr!7))))))

(assert (=> start!158 e!2315))

(assert (=> start!158 true))

(declare-fun b!4542 () Bool)

(declare-fun complexity!0 (Expr!33) Int)

(assert (=> b!4542 (= e!2315 (<= (+ 1 (complexity!0 (lhs!394 expr!7)) (complexity!0 (rhs!394 expr!7))) 0))))

(assert (= (and start!158 res!208) b!4542))

(declare-fun m!1393 () Bool)

(assert (=> b!4542 m!1393))

(declare-fun m!1395 () Bool)

(assert (=> b!4542 m!1395))

(check-sat (not b!4542))
(check-sat)
(get-model)

(declare-fun bm!3754 () Bool)

(declare-fun call!3767 () Int)

(declare-fun call!3769 () Int)

(assert (=> bm!3754 (= call!3767 call!3769)))

(declare-fun bm!3755 () Bool)

(declare-fun call!3762 () Int)

(declare-fun call!3757 () Int)

(assert (=> bm!3755 (= call!3762 call!3757)))

(declare-fun b!4583 () Bool)

(declare-fun e!2337 () Int)

(declare-fun e!2336 () Int)

(assert (=> b!4583 (= e!2337 e!2336)))

(declare-fun c!2244 () Bool)

(assert (=> b!4583 (= c!2244 ((_ is Times!32) (lhs!394 expr!7)))))

(declare-fun b!4584 () Bool)

(declare-fun c!2250 () Bool)

(assert (=> b!4584 (= c!2250 ((_ is FMA!32) (lhs!394 expr!7)))))

(declare-fun e!2340 () Int)

(assert (=> b!4584 (= e!2336 e!2340)))

(declare-fun b!4585 () Bool)

(declare-fun e!2341 () Int)

(declare-fun call!3760 () Int)

(declare-fun call!3772 () Int)

(assert (=> b!4585 (= e!2341 (+ 1 call!3760 call!3772))))

(declare-fun b!4586 () Bool)

(declare-fun e!2342 () Int)

(declare-fun call!3763 () Int)

(assert (=> b!4586 (= e!2342 (+ 1 call!3769 call!3763))))

(declare-fun d!401 () Bool)

(declare-fun lt!223 () Int)

(assert (=> d!401 (> lt!223 0)))

(declare-fun e!2345 () Int)

(assert (=> d!401 (= lt!223 e!2345)))

(declare-fun c!2245 () Bool)

(assert (=> d!401 (= c!2245 ((_ is IntegerLiteral!32) (lhs!394 expr!7)))))

(assert (=> d!401 (= (complexity!0 (lhs!394 expr!7)) lt!223)))

(declare-fun b!4587 () Bool)

(declare-fun c!2243 () Bool)

(assert (=> b!4587 (= c!2243 ((_ is UMinus!32) (lhs!394 expr!7)))))

(assert (=> b!4587 (= e!2341 e!2337)))

(declare-fun bm!3756 () Bool)

(declare-fun call!3768 () Int)

(assert (=> bm!3756 (= call!3768 call!3760)))

(declare-fun b!4588 () Bool)

(declare-fun e!2344 () Int)

(declare-fun call!3771 () Int)

(assert (=> b!4588 (= e!2344 (+ 1 call!3771 call!3767))))

(declare-fun b!4589 () Bool)

(declare-fun c!2251 () Bool)

(assert (=> b!4589 (= c!2251 ((_ is IntPow!32) (lhs!394 expr!7)))))

(declare-fun e!2338 () Int)

(declare-fun e!2343 () Int)

(assert (=> b!4589 (= e!2338 e!2343)))

(declare-fun b!4590 () Bool)

(declare-fun call!3759 () Int)

(assert (=> b!4590 (= e!2343 (+ 1 call!3759))))

(declare-fun bm!3757 () Bool)

(declare-fun call!3761 () Int)

(assert (=> bm!3757 (= call!3759 call!3761)))

(declare-fun b!4591 () Bool)

(declare-fun call!3766 () Int)

(assert (=> b!4591 (= e!2336 (+ 1 call!3766 call!3768))))

(declare-fun bm!3758 () Bool)

(assert (=> bm!3758 (= call!3769 call!3759)))

(declare-fun b!4592 () Bool)

(assert (=> b!4592 (= e!2338 (+ 1 call!3762 call!3761))))

(declare-fun b!4593 () Bool)

(assert (=> b!4593 (= e!2345 1)))

(declare-fun bm!3759 () Bool)

(assert (=> bm!3759 (= call!3757 call!3768)))

(declare-fun b!4594 () Bool)

(assert (=> b!4594 (= e!2345 e!2341)))

(declare-fun c!2248 () Bool)

(assert (=> b!4594 (= c!2248 ((_ is Minus!32) (lhs!394 expr!7)))))

(declare-fun bm!3760 () Bool)

(assert (=> bm!3760 (= call!3771 call!3763)))

(declare-fun c!2247 () Bool)

(declare-fun c!2249 () Bool)

(declare-fun c!2246 () Bool)

(declare-fun c!2242 () Bool)

(declare-fun bm!3761 () Bool)

(declare-fun call!3770 () Int)

(assert (=> bm!3761 (= call!3770 (complexity!0 (ite c!2250 (s!103 (lhs!394 expr!7)) (ite c!2249 (rhs!395 (lhs!394 expr!7)) (ite c!2251 (base!56 (lhs!394 expr!7)) (ite c!2246 (lhs!393 (lhs!394 expr!7)) (ite c!2242 (rhs!392 (lhs!394 expr!7)) (ite c!2247 (rhs!397 (lhs!394 expr!7)) (rhs!394 (lhs!394 expr!7))))))))))))

(declare-fun b!4595 () Bool)

(declare-fun e!2339 () Int)

(assert (=> b!4595 (= e!2344 e!2339)))

(assert (=> b!4595 (= c!2247 ((_ is LessEquals!32) (lhs!394 expr!7)))))

(declare-fun bm!3762 () Bool)

(assert (=> bm!3762 (= call!3763 call!3762)))

(declare-fun bm!3763 () Bool)

(declare-fun call!3764 () Int)

(assert (=> bm!3763 (= call!3764 call!3771)))

(declare-fun b!4596 () Bool)

(declare-fun call!3758 () Int)

(assert (=> b!4596 (= e!2339 (+ 1 call!3764 call!3758))))

(declare-fun bm!3764 () Bool)

(assert (=> bm!3764 (= call!3761 call!3770)))

(declare-fun b!4597 () Bool)

(declare-fun call!3765 () Int)

(assert (=> b!4597 (= e!2337 (+ 1 call!3765))))

(declare-fun bm!3765 () Bool)

(assert (=> bm!3765 (= call!3772 (complexity!0 (ite c!2248 (rhs!398 (lhs!394 expr!7)) (ite c!2243 (expr!124 (lhs!394 expr!7)) (ite c!2244 (lhs!396 (lhs!394 expr!7)) (fac2!56 (lhs!394 expr!7)))))))))

(declare-fun b!4598 () Bool)

(assert (=> b!4598 (= c!2242 ((_ is GreaterThan!32) (lhs!394 expr!7)))))

(assert (=> b!4598 (= e!2342 e!2344)))

(declare-fun bm!3766 () Bool)

(assert (=> bm!3766 (= call!3760 (complexity!0 (ite c!2248 (lhs!398 (lhs!394 expr!7)) (ite c!2244 (rhs!396 (lhs!394 expr!7)) (ite c!2250 (fac1!56 (lhs!394 expr!7)) (ite c!2249 (lhs!395 (lhs!394 expr!7)) (ite c!2246 (rhs!393 (lhs!394 expr!7)) (ite c!2242 (lhs!392 (lhs!394 expr!7)) (ite c!2247 (lhs!397 (lhs!394 expr!7)) (lhs!394 (lhs!394 expr!7)))))))))))))

(declare-fun b!4599 () Bool)

(assert (=> b!4599 (= e!2340 e!2338)))

(assert (=> b!4599 (= c!2249 ((_ is Division!32) (lhs!394 expr!7)))))

(declare-fun bm!3767 () Bool)

(assert (=> bm!3767 (= call!3765 call!3772)))

(declare-fun b!4600 () Bool)

(assert (=> b!4600 (= e!2339 (+ 1 call!3764 call!3758))))

(declare-fun bm!3768 () Bool)

(assert (=> bm!3768 (= call!3758 call!3767)))

(declare-fun b!4601 () Bool)

(assert (=> b!4601 (= e!2343 e!2342)))

(assert (=> b!4601 (= c!2246 ((_ is LessThan!32) (lhs!394 expr!7)))))

(declare-fun bm!3769 () Bool)

(assert (=> bm!3769 (= call!3766 call!3765)))

(declare-fun b!4602 () Bool)

(assert (=> b!4602 (= e!2340 (+ 1 call!3757 call!3766 call!3770))))

(assert (= (and d!401 c!2245) b!4593))

(assert (= (and d!401 (not c!2245)) b!4594))

(assert (= (and b!4594 c!2248) b!4585))

(assert (= (and b!4594 (not c!2248)) b!4587))

(assert (= (and b!4587 c!2243) b!4597))

(assert (= (and b!4587 (not c!2243)) b!4583))

(assert (= (and b!4583 c!2244) b!4591))

(assert (= (and b!4583 (not c!2244)) b!4584))

(assert (= (and b!4584 c!2250) b!4602))

(assert (= (and b!4584 (not c!2250)) b!4599))

(assert (= (and b!4599 c!2249) b!4592))

(assert (= (and b!4599 (not c!2249)) b!4589))

(assert (= (and b!4589 c!2251) b!4590))

(assert (= (and b!4589 (not c!2251)) b!4601))

(assert (= (and b!4601 c!2246) b!4586))

(assert (= (and b!4601 (not c!2246)) b!4598))

(assert (= (and b!4598 c!2242) b!4588))

(assert (= (and b!4598 (not c!2242)) b!4595))

(assert (= (and b!4595 c!2247) b!4596))

(assert (= (and b!4595 (not c!2247)) b!4600))

(assert (= (or b!4596 b!4600) bm!3768))

(assert (= (or b!4596 b!4600) bm!3763))

(assert (= (or b!4588 bm!3768) bm!3754))

(assert (= (or b!4588 bm!3763) bm!3760))

(assert (= (or b!4586 bm!3754) bm!3758))

(assert (= (or b!4586 bm!3760) bm!3762))

(assert (= (or b!4590 bm!3758) bm!3757))

(assert (= (or b!4592 bm!3762) bm!3755))

(assert (= (or b!4592 bm!3757) bm!3764))

(assert (= (or b!4602 bm!3755) bm!3759))

(assert (= (or b!4602 bm!3764) bm!3761))

(assert (= (or b!4591 bm!3759) bm!3756))

(assert (= (or b!4591 b!4602) bm!3769))

(assert (= (or b!4597 bm!3769) bm!3767))

(assert (= (or b!4585 bm!3767) bm!3765))

(assert (= (or b!4585 bm!3756) bm!3766))

(declare-fun m!1397 () Bool)

(assert (=> bm!3761 m!1397))

(declare-fun m!1399 () Bool)

(assert (=> bm!3765 m!1399))

(declare-fun m!1401 () Bool)

(assert (=> bm!3766 m!1401))

(assert (=> b!4542 d!401))

(declare-fun bm!3770 () Bool)

(declare-fun call!3783 () Int)

(declare-fun call!3785 () Int)

(assert (=> bm!3770 (= call!3783 call!3785)))

(declare-fun bm!3771 () Bool)

(declare-fun call!3778 () Int)

(declare-fun call!3773 () Int)

(assert (=> bm!3771 (= call!3778 call!3773)))

(declare-fun b!4603 () Bool)

(declare-fun e!2347 () Int)

(declare-fun e!2346 () Int)

(assert (=> b!4603 (= e!2347 e!2346)))

(declare-fun c!2254 () Bool)

(assert (=> b!4603 (= c!2254 ((_ is Times!32) (rhs!394 expr!7)))))

(declare-fun b!4604 () Bool)

(declare-fun c!2260 () Bool)

(assert (=> b!4604 (= c!2260 ((_ is FMA!32) (rhs!394 expr!7)))))

(declare-fun e!2350 () Int)

(assert (=> b!4604 (= e!2346 e!2350)))

(declare-fun b!4605 () Bool)

(declare-fun e!2351 () Int)

(declare-fun call!3776 () Int)

(declare-fun call!3788 () Int)

(assert (=> b!4605 (= e!2351 (+ 1 call!3776 call!3788))))

(declare-fun b!4606 () Bool)

(declare-fun e!2352 () Int)

(declare-fun call!3779 () Int)

(assert (=> b!4606 (= e!2352 (+ 1 call!3785 call!3779))))

(declare-fun d!403 () Bool)

(declare-fun lt!224 () Int)

(assert (=> d!403 (> lt!224 0)))

(declare-fun e!2355 () Int)

(assert (=> d!403 (= lt!224 e!2355)))

(declare-fun c!2255 () Bool)

(assert (=> d!403 (= c!2255 ((_ is IntegerLiteral!32) (rhs!394 expr!7)))))

(assert (=> d!403 (= (complexity!0 (rhs!394 expr!7)) lt!224)))

(declare-fun b!4607 () Bool)

(declare-fun c!2253 () Bool)

(assert (=> b!4607 (= c!2253 ((_ is UMinus!32) (rhs!394 expr!7)))))

(assert (=> b!4607 (= e!2351 e!2347)))

(declare-fun bm!3772 () Bool)

(declare-fun call!3784 () Int)

(assert (=> bm!3772 (= call!3784 call!3776)))

(declare-fun b!4608 () Bool)

(declare-fun e!2354 () Int)

(declare-fun call!3787 () Int)

(assert (=> b!4608 (= e!2354 (+ 1 call!3787 call!3783))))

(declare-fun b!4609 () Bool)

(declare-fun c!2261 () Bool)

(assert (=> b!4609 (= c!2261 ((_ is IntPow!32) (rhs!394 expr!7)))))

(declare-fun e!2348 () Int)

(declare-fun e!2353 () Int)

(assert (=> b!4609 (= e!2348 e!2353)))

(declare-fun b!4610 () Bool)

(declare-fun call!3775 () Int)

(assert (=> b!4610 (= e!2353 (+ 1 call!3775))))

(declare-fun bm!3773 () Bool)

(declare-fun call!3777 () Int)

(assert (=> bm!3773 (= call!3775 call!3777)))

(declare-fun b!4611 () Bool)

(declare-fun call!3782 () Int)

(assert (=> b!4611 (= e!2346 (+ 1 call!3782 call!3784))))

(declare-fun bm!3774 () Bool)

(assert (=> bm!3774 (= call!3785 call!3775)))

(declare-fun b!4612 () Bool)

(assert (=> b!4612 (= e!2348 (+ 1 call!3778 call!3777))))

(declare-fun b!4613 () Bool)

(assert (=> b!4613 (= e!2355 1)))

(declare-fun bm!3775 () Bool)

(assert (=> bm!3775 (= call!3773 call!3784)))

(declare-fun b!4614 () Bool)

(assert (=> b!4614 (= e!2355 e!2351)))

(declare-fun c!2258 () Bool)

(assert (=> b!4614 (= c!2258 ((_ is Minus!32) (rhs!394 expr!7)))))

(declare-fun bm!3776 () Bool)

(assert (=> bm!3776 (= call!3787 call!3779)))

(declare-fun c!2257 () Bool)

(declare-fun bm!3777 () Bool)

(declare-fun c!2256 () Bool)

(declare-fun c!2259 () Bool)

(declare-fun c!2252 () Bool)

(declare-fun call!3786 () Int)

(assert (=> bm!3777 (= call!3786 (complexity!0 (ite c!2260 (s!103 (rhs!394 expr!7)) (ite c!2259 (rhs!395 (rhs!394 expr!7)) (ite c!2261 (base!56 (rhs!394 expr!7)) (ite c!2256 (lhs!393 (rhs!394 expr!7)) (ite c!2252 (rhs!392 (rhs!394 expr!7)) (ite c!2257 (rhs!397 (rhs!394 expr!7)) (rhs!394 (rhs!394 expr!7))))))))))))

(declare-fun b!4615 () Bool)

(declare-fun e!2349 () Int)

(assert (=> b!4615 (= e!2354 e!2349)))

(assert (=> b!4615 (= c!2257 ((_ is LessEquals!32) (rhs!394 expr!7)))))

(declare-fun bm!3778 () Bool)

(assert (=> bm!3778 (= call!3779 call!3778)))

(declare-fun bm!3779 () Bool)

(declare-fun call!3780 () Int)

(assert (=> bm!3779 (= call!3780 call!3787)))

(declare-fun b!4616 () Bool)

(declare-fun call!3774 () Int)

(assert (=> b!4616 (= e!2349 (+ 1 call!3780 call!3774))))

(declare-fun bm!3780 () Bool)

(assert (=> bm!3780 (= call!3777 call!3786)))

(declare-fun b!4617 () Bool)

(declare-fun call!3781 () Int)

(assert (=> b!4617 (= e!2347 (+ 1 call!3781))))

(declare-fun bm!3781 () Bool)

(assert (=> bm!3781 (= call!3788 (complexity!0 (ite c!2258 (rhs!398 (rhs!394 expr!7)) (ite c!2253 (expr!124 (rhs!394 expr!7)) (ite c!2254 (lhs!396 (rhs!394 expr!7)) (fac2!56 (rhs!394 expr!7)))))))))

(declare-fun b!4618 () Bool)

(assert (=> b!4618 (= c!2252 ((_ is GreaterThan!32) (rhs!394 expr!7)))))

(assert (=> b!4618 (= e!2352 e!2354)))

(declare-fun bm!3782 () Bool)

(assert (=> bm!3782 (= call!3776 (complexity!0 (ite c!2258 (lhs!398 (rhs!394 expr!7)) (ite c!2254 (rhs!396 (rhs!394 expr!7)) (ite c!2260 (fac1!56 (rhs!394 expr!7)) (ite c!2259 (lhs!395 (rhs!394 expr!7)) (ite c!2256 (rhs!393 (rhs!394 expr!7)) (ite c!2252 (lhs!392 (rhs!394 expr!7)) (ite c!2257 (lhs!397 (rhs!394 expr!7)) (lhs!394 (rhs!394 expr!7)))))))))))))

(declare-fun b!4619 () Bool)

(assert (=> b!4619 (= e!2350 e!2348)))

(assert (=> b!4619 (= c!2259 ((_ is Division!32) (rhs!394 expr!7)))))

(declare-fun bm!3783 () Bool)

(assert (=> bm!3783 (= call!3781 call!3788)))

(declare-fun b!4620 () Bool)

(assert (=> b!4620 (= e!2349 (+ 1 call!3780 call!3774))))

(declare-fun bm!3784 () Bool)

(assert (=> bm!3784 (= call!3774 call!3783)))

(declare-fun b!4621 () Bool)

(assert (=> b!4621 (= e!2353 e!2352)))

(assert (=> b!4621 (= c!2256 ((_ is LessThan!32) (rhs!394 expr!7)))))

(declare-fun bm!3785 () Bool)

(assert (=> bm!3785 (= call!3782 call!3781)))

(declare-fun b!4622 () Bool)

(assert (=> b!4622 (= e!2350 (+ 1 call!3773 call!3782 call!3786))))

(assert (= (and d!403 c!2255) b!4613))

(assert (= (and d!403 (not c!2255)) b!4614))

(assert (= (and b!4614 c!2258) b!4605))

(assert (= (and b!4614 (not c!2258)) b!4607))

(assert (= (and b!4607 c!2253) b!4617))

(assert (= (and b!4607 (not c!2253)) b!4603))

(assert (= (and b!4603 c!2254) b!4611))

(assert (= (and b!4603 (not c!2254)) b!4604))

(assert (= (and b!4604 c!2260) b!4622))

(assert (= (and b!4604 (not c!2260)) b!4619))

(assert (= (and b!4619 c!2259) b!4612))

(assert (= (and b!4619 (not c!2259)) b!4609))

(assert (= (and b!4609 c!2261) b!4610))

(assert (= (and b!4609 (not c!2261)) b!4621))

(assert (= (and b!4621 c!2256) b!4606))

(assert (= (and b!4621 (not c!2256)) b!4618))

(assert (= (and b!4618 c!2252) b!4608))

(assert (= (and b!4618 (not c!2252)) b!4615))

(assert (= (and b!4615 c!2257) b!4616))

(assert (= (and b!4615 (not c!2257)) b!4620))

(assert (= (or b!4616 b!4620) bm!3784))

(assert (= (or b!4616 b!4620) bm!3779))

(assert (= (or b!4608 bm!3784) bm!3770))

(assert (= (or b!4608 bm!3779) bm!3776))

(assert (= (or b!4606 bm!3770) bm!3774))

(assert (= (or b!4606 bm!3776) bm!3778))

(assert (= (or b!4610 bm!3774) bm!3773))

(assert (= (or b!4612 bm!3778) bm!3771))

(assert (= (or b!4612 bm!3773) bm!3780))

(assert (= (or b!4622 bm!3771) bm!3775))

(assert (= (or b!4622 bm!3780) bm!3777))

(assert (= (or b!4611 bm!3775) bm!3772))

(assert (= (or b!4611 b!4622) bm!3785))

(assert (= (or b!4617 bm!3785) bm!3783))

(assert (= (or b!4605 bm!3783) bm!3781))

(assert (= (or b!4605 bm!3772) bm!3782))

(declare-fun m!1403 () Bool)

(assert (=> bm!3777 m!1403))

(declare-fun m!1405 () Bool)

(assert (=> bm!3781 m!1405))

(declare-fun m!1407 () Bool)

(assert (=> bm!3782 m!1407))

(assert (=> b!4542 d!403))

(check-sat (not bm!3777) (not bm!3782) (not bm!3766) (not bm!3761) (not bm!3781) (not bm!3765))
(check-sat)
