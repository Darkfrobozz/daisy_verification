; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!30 () Bool)

(assert start!30)

(declare-fun res!136 () Bool)

(declare-fun e!343 () Bool)

(assert (=> start!30 (=> (not res!136) (not e!343))))

(declare-datatypes ((Expr!9 0))(
  ( (FMA!8 (fac1!32 Expr!9) (fac2!32 Expr!9) (s!55 Expr!9)) (IntegerLiteral!8 (value!63 Int)) (GreaterThan!8 (lhs!224 Expr!9) (rhs!224 Expr!9)) (LessThan!8 (lhs!225 Expr!9) (rhs!225 Expr!9)) (GreaterEquals!8 (lhs!226 Expr!9) (rhs!226 Expr!9)) (UMinus!8 (expr!92 Expr!9)) (IntPow!8 (base!32 Expr!9) (exp!32 Int)) (Division!8 (lhs!227 Expr!9) (rhs!227 Expr!9)) (Times!8 (lhs!228 Expr!9) (rhs!228 Expr!9)) (LessEquals!8 (lhs!229 Expr!9) (rhs!229 Expr!9)) (Minus!8 (lhs!230 Expr!9) (rhs!230 Expr!9)) )
))
(declare-fun expr!7 () Expr!9)

(get-info :version)

(assert (=> start!30 (= res!136 (and (not ((_ is IntegerLiteral!8) expr!7)) (not ((_ is Minus!8) expr!7)) ((_ is UMinus!8) expr!7)))))

(assert (=> start!30 e!343))

(assert (=> start!30 true))

(declare-fun b!670 () Bool)

(declare-fun complexity!0 (Expr!9) Int)

(assert (=> b!670 (= e!343 (<= (+ 1 (complexity!0 (expr!92 expr!7))) 0))))

(assert (= (and start!30 res!136) b!670))

(declare-fun m!195 () Bool)

(assert (=> b!670 m!195))

(check-sat (not b!670))
(check-sat)
(get-model)

(declare-fun bm!555 () Bool)

(declare-fun call!567 () Int)

(declare-fun call!570 () Int)

(assert (=> bm!555 (= call!567 call!570)))

(declare-fun b!711 () Bool)

(declare-fun e!365 () Int)

(declare-fun e!366 () Int)

(assert (=> b!711 (= e!365 e!366)))

(declare-fun c!348 () Bool)

(assert (=> b!711 (= c!348 ((_ is Minus!8) (expr!92 expr!7)))))

(declare-fun bm!556 () Bool)

(declare-fun call!569 () Int)

(declare-fun call!565 () Int)

(assert (=> bm!556 (= call!569 call!565)))

(declare-fun bm!557 () Bool)

(declare-fun call!568 () Int)

(assert (=> bm!557 (= call!565 call!568)))

(declare-fun bm!559 () Bool)

(assert (=> bm!559 (= call!568 call!567)))

(declare-fun bm!560 () Bool)

(declare-fun call!563 () Int)

(declare-fun c!347 () Bool)

(assert (=> bm!560 (= call!563 (complexity!0 (ite c!348 (lhs!230 (expr!92 expr!7)) (ite c!347 (expr!92 (expr!92 expr!7)) (fac2!32 (expr!92 expr!7))))))))

(declare-fun bm!561 () Bool)

(declare-fun call!564 () Int)

(assert (=> bm!561 (= call!570 call!564)))

(declare-fun b!712 () Bool)

(declare-fun call!561 () Int)

(assert (=> b!712 (= e!366 (+ 1 call!563 call!561))))

(declare-fun b!713 () Bool)

(assert (=> b!713 (= e!365 1)))

(declare-fun b!714 () Bool)

(declare-fun e!369 () Int)

(declare-fun call!559 () Int)

(assert (=> b!714 (= e!369 (+ 1 call!559))))

(declare-fun c!345 () Bool)

(declare-fun c!351 () Bool)

(declare-fun c!350 () Bool)

(declare-fun call!573 () Int)

(declare-fun bm!562 () Bool)

(declare-fun c!346 () Bool)

(declare-fun c!344 () Bool)

(declare-fun c!343 () Bool)

(assert (=> bm!562 (= call!573 (complexity!0 (ite c!344 (rhs!228 (expr!92 expr!7)) (ite c!350 (fac1!32 (expr!92 expr!7)) (ite c!351 (lhs!227 (expr!92 expr!7)) (ite c!346 (lhs!225 (expr!92 expr!7)) (ite c!343 (rhs!224 (expr!92 expr!7)) (ite c!345 (rhs!229 (expr!92 expr!7)) (rhs!226 (expr!92 expr!7))))))))))))

(declare-fun b!715 () Bool)

(declare-fun e!372 () Int)

(declare-fun e!367 () Int)

(assert (=> b!715 (= e!372 e!367)))

(assert (=> b!715 (= c!351 ((_ is Division!8) (expr!92 expr!7)))))

(declare-fun bm!563 () Bool)

(declare-fun call!562 () Int)

(declare-fun call!558 () Int)

(assert (=> bm!563 (= call!562 call!558)))

(declare-fun bm!558 () Bool)

(assert (=> bm!558 (= call!564 call!561)))

(declare-fun d!53 () Bool)

(declare-fun lt!33 () Int)

(assert (=> d!53 (> lt!33 0)))

(assert (=> d!53 (= lt!33 e!365)))

(declare-fun c!349 () Bool)

(assert (=> d!53 (= c!349 ((_ is IntegerLiteral!8) (expr!92 expr!7)))))

(assert (=> d!53 (= (complexity!0 (expr!92 expr!7)) lt!33)))

(declare-fun b!716 () Bool)

(assert (=> b!716 (= c!350 ((_ is FMA!8) (expr!92 expr!7)))))

(declare-fun e!371 () Int)

(assert (=> b!716 (= e!371 e!372)))

(declare-fun bm!564 () Bool)

(declare-fun call!571 () Int)

(assert (=> bm!564 (= call!558 call!571)))

(declare-fun bm!565 () Bool)

(declare-fun call!572 () Int)

(assert (=> bm!565 (= call!572 call!562)))

(declare-fun b!717 () Bool)

(assert (=> b!717 (= e!369 e!371)))

(assert (=> b!717 (= c!344 ((_ is Times!8) (expr!92 expr!7)))))

(declare-fun b!718 () Bool)

(assert (=> b!718 (= e!372 (+ 1 call!571 call!559 call!570))))

(declare-fun bm!566 () Bool)

(assert (=> bm!566 (= call!571 call!573)))

(declare-fun bm!567 () Bool)

(assert (=> bm!567 (= call!559 call!563)))

(declare-fun b!719 () Bool)

(declare-fun e!368 () Int)

(assert (=> b!719 (= e!368 (+ 1 call!569 call!572))))

(declare-fun b!720 () Bool)

(assert (=> b!720 (= c!347 ((_ is UMinus!8) (expr!92 expr!7)))))

(assert (=> b!720 (= e!366 e!369)))

(declare-fun b!721 () Bool)

(declare-fun e!364 () Int)

(declare-fun call!560 () Int)

(declare-fun call!566 () Int)

(assert (=> b!721 (= e!364 (+ 1 call!560 call!566))))

(declare-fun b!722 () Bool)

(assert (=> b!722 (= e!367 (+ 1 call!558 call!567))))

(declare-fun bm!568 () Bool)

(assert (=> bm!568 (= call!560 call!569)))

(declare-fun bm!569 () Bool)

(assert (=> bm!569 (= call!566 call!572)))

(declare-fun b!723 () Bool)

(assert (=> b!723 (= e!371 (+ 1 call!564 call!573))))

(declare-fun b!724 () Bool)

(assert (=> b!724 (= e!368 e!364)))

(assert (=> b!724 (= c!345 ((_ is LessEquals!8) (expr!92 expr!7)))))

(declare-fun b!725 () Bool)

(declare-fun c!342 () Bool)

(assert (=> b!725 (= c!342 ((_ is IntPow!8) (expr!92 expr!7)))))

(declare-fun e!370 () Int)

(assert (=> b!725 (= e!367 e!370)))

(declare-fun b!726 () Bool)

(assert (=> b!726 (= e!370 (+ 1 call!568))))

(declare-fun b!727 () Bool)

(assert (=> b!727 (= e!364 (+ 1 call!560 call!566))))

(declare-fun b!728 () Bool)

(declare-fun e!373 () Int)

(assert (=> b!728 (= e!370 e!373)))

(assert (=> b!728 (= c!346 ((_ is LessThan!8) (expr!92 expr!7)))))

(declare-fun b!729 () Bool)

(assert (=> b!729 (= c!343 ((_ is GreaterThan!8) (expr!92 expr!7)))))

(assert (=> b!729 (= e!373 e!368)))

(declare-fun b!730 () Bool)

(assert (=> b!730 (= e!373 (+ 1 call!562 call!565))))

(declare-fun bm!570 () Bool)

(assert (=> bm!570 (= call!561 (complexity!0 (ite c!348 (rhs!230 (expr!92 expr!7)) (ite c!344 (lhs!228 (expr!92 expr!7)) (ite c!350 (s!55 (expr!92 expr!7)) (ite c!351 (rhs!227 (expr!92 expr!7)) (ite c!342 (base!32 (expr!92 expr!7)) (ite c!346 (rhs!225 (expr!92 expr!7)) (ite c!343 (lhs!224 (expr!92 expr!7)) (ite c!345 (lhs!229 (expr!92 expr!7)) (lhs!226 (expr!92 expr!7))))))))))))))

(assert (= (and d!53 c!349) b!713))

(assert (= (and d!53 (not c!349)) b!711))

(assert (= (and b!711 c!348) b!712))

(assert (= (and b!711 (not c!348)) b!720))

(assert (= (and b!720 c!347) b!714))

(assert (= (and b!720 (not c!347)) b!717))

(assert (= (and b!717 c!344) b!723))

(assert (= (and b!717 (not c!344)) b!716))

(assert (= (and b!716 c!350) b!718))

(assert (= (and b!716 (not c!350)) b!715))

(assert (= (and b!715 c!351) b!722))

(assert (= (and b!715 (not c!351)) b!725))

(assert (= (and b!725 c!342) b!726))

(assert (= (and b!725 (not c!342)) b!728))

(assert (= (and b!728 c!346) b!730))

(assert (= (and b!728 (not c!346)) b!729))

(assert (= (and b!729 c!343) b!719))

(assert (= (and b!729 (not c!343)) b!724))

(assert (= (and b!724 c!345) b!727))

(assert (= (and b!724 (not c!345)) b!721))

(assert (= (or b!727 b!721) bm!569))

(assert (= (or b!727 b!721) bm!568))

(assert (= (or b!719 bm!569) bm!565))

(assert (= (or b!719 bm!568) bm!556))

(assert (= (or b!730 bm!565) bm!563))

(assert (= (or b!730 bm!556) bm!557))

(assert (= (or b!726 bm!557) bm!559))

(assert (= (or b!722 bm!563) bm!564))

(assert (= (or b!722 bm!559) bm!555))

(assert (= (or b!718 bm!564) bm!566))

(assert (= (or b!718 bm!555) bm!561))

(assert (= (or b!723 bm!566) bm!562))

(assert (= (or b!723 bm!561) bm!558))

(assert (= (or b!714 b!718) bm!567))

(assert (= (or b!712 bm!558) bm!570))

(assert (= (or b!712 bm!567) bm!560))

(declare-fun m!197 () Bool)

(assert (=> bm!560 m!197))

(declare-fun m!199 () Bool)

(assert (=> bm!562 m!199))

(declare-fun m!201 () Bool)

(assert (=> bm!570 m!201))

(assert (=> b!670 d!53))

(check-sat (not bm!570) (not bm!560) (not bm!562))
(check-sat)
