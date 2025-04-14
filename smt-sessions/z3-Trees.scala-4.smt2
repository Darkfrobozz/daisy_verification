; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!22 () Bool)

(assert start!22)

(declare-fun res!130 () Bool)

(declare-fun e!257 () Bool)

(assert (=> start!22 (=> (not res!130) (not e!257))))

(declare-datatypes ((Expr!7 0))(
  ( (FMA!6 (fac1!30 Expr!7) (fac2!30 Expr!7) (s!51 Expr!7)) (IntegerLiteral!6 (value!59 Int)) (GreaterThan!6 (lhs!210 Expr!7) (rhs!210 Expr!7)) (LessThan!6 (lhs!211 Expr!7) (rhs!211 Expr!7)) (GreaterEquals!6 (lhs!212 Expr!7) (rhs!212 Expr!7)) (UMinus!6 (expr!89 Expr!7)) (IntPow!6 (base!30 Expr!7) (exp!30 Int)) (Division!6 (lhs!213 Expr!7) (rhs!213 Expr!7)) (Times!6 (lhs!214 Expr!7) (rhs!214 Expr!7)) (LessEquals!6 (lhs!215 Expr!7) (rhs!215 Expr!7)) (Minus!6 (lhs!216 Expr!7) (rhs!216 Expr!7)) )
))
(declare-fun expr!7 () Expr!7)

(get-info :version)

(assert (=> start!22 (= res!130 (and (not ((_ is IntegerLiteral!6) expr!7)) ((_ is Minus!6) expr!7)))))

(assert (=> start!22 e!257))

(assert (=> start!22 true))

(declare-fun b!504 () Bool)

(declare-fun complexity!0 (Expr!7) Int)

(assert (=> b!504 (= e!257 (<= (+ 1 (complexity!0 (lhs!216 expr!7)) (complexity!0 (rhs!216 expr!7))) 0))))

(assert (= (and start!22 res!130) b!504))

(declare-fun m!159 () Bool)

(assert (=> b!504 m!159))

(declare-fun m!161 () Bool)

(assert (=> b!504 m!161))

(check-sat (not b!504))
(check-sat)
(get-model)

(declare-fun call!440 () Int)

(declare-fun c!266 () Bool)

(declare-fun c!267 () Bool)

(declare-fun bm!423 () Bool)

(assert (=> bm!423 (= call!440 (complexity!0 (ite c!267 (lhs!216 (lhs!216 expr!7)) (ite c!266 (rhs!214 (lhs!216 expr!7)) (fac2!30 (lhs!216 expr!7))))))))

(declare-fun b!545 () Bool)

(declare-fun e!281 () Int)

(declare-fun e!279 () Int)

(assert (=> b!545 (= e!281 e!279)))

(assert (=> b!545 (= c!267 ((_ is Minus!6) (lhs!216 expr!7)))))

(declare-fun b!546 () Bool)

(declare-fun c!268 () Bool)

(assert (=> b!546 (= c!268 ((_ is UMinus!6) (lhs!216 expr!7)))))

(declare-fun e!285 () Int)

(assert (=> b!546 (= e!279 e!285)))

(declare-fun c!262 () Bool)

(declare-fun bm!424 () Bool)

(declare-fun c!270 () Bool)

(declare-fun c!264 () Bool)

(declare-fun call!433 () Int)

(declare-fun c!263 () Bool)

(declare-fun c!269 () Bool)

(declare-fun c!265 () Bool)

(assert (=> bm!424 (= call!433 (complexity!0 (ite c!267 (rhs!216 (lhs!216 expr!7)) (ite c!268 (expr!89 (lhs!216 expr!7)) (ite c!266 (lhs!214 (lhs!216 expr!7)) (ite c!269 (s!51 (lhs!216 expr!7)) (ite c!262 (rhs!213 (lhs!216 expr!7)) (ite c!270 (base!30 (lhs!216 expr!7)) (ite c!263 (lhs!211 (lhs!216 expr!7)) (ite c!265 (rhs!210 (lhs!216 expr!7)) (ite c!264 (lhs!215 (lhs!216 expr!7)) (lhs!212 (lhs!216 expr!7)))))))))))))))

(declare-fun bm!425 () Bool)

(declare-fun call!432 () Int)

(declare-fun call!426 () Int)

(assert (=> bm!425 (= call!432 call!426)))

(declare-fun b!547 () Bool)

(declare-fun call!427 () Int)

(assert (=> b!547 (= e!285 (+ 1 call!427))))

(declare-fun d!45 () Bool)

(declare-fun lt!25 () Int)

(assert (=> d!45 (> lt!25 0)))

(assert (=> d!45 (= lt!25 e!281)))

(declare-fun c!271 () Bool)

(assert (=> d!45 (= c!271 ((_ is IntegerLiteral!6) (lhs!216 expr!7)))))

(assert (=> d!45 (= (complexity!0 (lhs!216 expr!7)) lt!25)))

(declare-fun b!548 () Bool)

(declare-fun e!283 () Int)

(declare-fun call!437 () Int)

(declare-fun call!430 () Int)

(assert (=> b!548 (= e!283 (+ 1 call!437 call!430))))

(declare-fun bm!426 () Bool)

(declare-fun call!441 () Int)

(declare-fun call!429 () Int)

(assert (=> bm!426 (= call!441 call!429)))

(declare-fun b!549 () Bool)

(declare-fun e!280 () Int)

(declare-fun call!434 () Int)

(assert (=> b!549 (= e!280 (+ 1 call!434 call!426))))

(declare-fun b!550 () Bool)

(assert (=> b!550 (= c!270 ((_ is IntPow!6) (lhs!216 expr!7)))))

(declare-fun e!287 () Int)

(assert (=> b!550 (= e!280 e!287)))

(declare-fun b!551 () Bool)

(declare-fun e!278 () Int)

(assert (=> b!551 (= e!285 e!278)))

(assert (=> b!551 (= c!266 ((_ is Times!6) (lhs!216 expr!7)))))

(declare-fun bm!427 () Bool)

(declare-fun call!428 () Int)

(assert (=> bm!427 (= call!434 call!428)))

(declare-fun bm!428 () Bool)

(assert (=> bm!428 (= call!429 call!432)))

(declare-fun b!552 () Bool)

(declare-fun e!282 () Int)

(assert (=> b!552 (= e!287 e!282)))

(assert (=> b!552 (= c!263 ((_ is LessThan!6) (lhs!216 expr!7)))))

(declare-fun b!553 () Bool)

(assert (=> b!553 (= e!281 1)))

(declare-fun bm!429 () Bool)

(declare-fun call!435 () Int)

(declare-fun call!439 () Int)

(assert (=> bm!429 (= call!435 call!439)))

(declare-fun call!436 () Int)

(declare-fun call!431 () Int)

(declare-fun b!554 () Bool)

(declare-fun e!286 () Int)

(assert (=> b!554 (= e!286 (+ 1 call!428 call!431 call!436))))

(declare-fun bm!430 () Bool)

(assert (=> bm!430 (= call!427 call!433)))

(declare-fun b!555 () Bool)

(assert (=> b!555 (= e!286 e!280)))

(assert (=> b!555 (= c!262 ((_ is Division!6) (lhs!216 expr!7)))))

(declare-fun b!556 () Bool)

(assert (=> b!556 (= e!282 (+ 1 call!429 call!439))))

(declare-fun b!557 () Bool)

(assert (=> b!557 (= e!287 (+ 1 call!432))))

(declare-fun bm!431 () Bool)

(assert (=> bm!431 (= call!428 (complexity!0 (ite c!269 (fac1!30 (lhs!216 expr!7)) (ite c!262 (lhs!213 (lhs!216 expr!7)) (ite c!263 (rhs!211 (lhs!216 expr!7)) (ite c!265 (lhs!210 (lhs!216 expr!7)) (ite c!264 (rhs!215 (lhs!216 expr!7)) (rhs!212 (lhs!216 expr!7)))))))))))

(declare-fun b!558 () Bool)

(declare-fun e!284 () Int)

(assert (=> b!558 (= e!284 (+ 1 call!435 call!441))))

(declare-fun bm!432 () Bool)

(assert (=> bm!432 (= call!426 call!436)))

(declare-fun bm!433 () Bool)

(declare-fun call!438 () Int)

(assert (=> bm!433 (= call!438 call!427)))

(declare-fun b!559 () Bool)

(assert (=> b!559 (= c!265 ((_ is GreaterThan!6) (lhs!216 expr!7)))))

(assert (=> b!559 (= e!282 e!284)))

(declare-fun bm!434 () Bool)

(assert (=> bm!434 (= call!437 call!441)))

(declare-fun bm!435 () Bool)

(assert (=> bm!435 (= call!430 call!435)))

(declare-fun b!560 () Bool)

(assert (=> b!560 (= e!278 (+ 1 call!438 call!431))))

(declare-fun bm!436 () Bool)

(assert (=> bm!436 (= call!439 call!434)))

(declare-fun b!561 () Bool)

(assert (=> b!561 (= c!269 ((_ is FMA!6) (lhs!216 expr!7)))))

(assert (=> b!561 (= e!278 e!286)))

(declare-fun b!562 () Bool)

(assert (=> b!562 (= e!283 (+ 1 call!437 call!430))))

(declare-fun bm!437 () Bool)

(assert (=> bm!437 (= call!431 call!440)))

(declare-fun b!563 () Bool)

(assert (=> b!563 (= e!284 e!283)))

(assert (=> b!563 (= c!264 ((_ is LessEquals!6) (lhs!216 expr!7)))))

(declare-fun b!564 () Bool)

(assert (=> b!564 (= e!279 (+ 1 call!440 call!433))))

(declare-fun bm!438 () Bool)

(assert (=> bm!438 (= call!436 call!438)))

(assert (= (and d!45 c!271) b!553))

(assert (= (and d!45 (not c!271)) b!545))

(assert (= (and b!545 c!267) b!564))

(assert (= (and b!545 (not c!267)) b!546))

(assert (= (and b!546 c!268) b!547))

(assert (= (and b!546 (not c!268)) b!551))

(assert (= (and b!551 c!266) b!560))

(assert (= (and b!551 (not c!266)) b!561))

(assert (= (and b!561 c!269) b!554))

(assert (= (and b!561 (not c!269)) b!555))

(assert (= (and b!555 c!262) b!549))

(assert (= (and b!555 (not c!262)) b!550))

(assert (= (and b!550 c!270) b!557))

(assert (= (and b!550 (not c!270)) b!552))

(assert (= (and b!552 c!263) b!556))

(assert (= (and b!552 (not c!263)) b!559))

(assert (= (and b!559 c!265) b!558))

(assert (= (and b!559 (not c!265)) b!563))

(assert (= (and b!563 c!264) b!548))

(assert (= (and b!563 (not c!264)) b!562))

(assert (= (or b!548 b!562) bm!435))

(assert (= (or b!548 b!562) bm!434))

(assert (= (or b!558 bm!434) bm!426))

(assert (= (or b!558 bm!435) bm!429))

(assert (= (or b!556 bm!426) bm!428))

(assert (= (or b!556 bm!429) bm!436))

(assert (= (or b!557 bm!428) bm!425))

(assert (= (or b!549 bm!436) bm!427))

(assert (= (or b!549 bm!425) bm!432))

(assert (= (or b!554 bm!427) bm!431))

(assert (= (or b!554 bm!432) bm!438))

(assert (= (or b!560 b!554) bm!437))

(assert (= (or b!560 bm!438) bm!433))

(assert (= (or b!547 bm!433) bm!430))

(assert (= (or b!564 bm!430) bm!424))

(assert (= (or b!564 bm!437) bm!423))

(declare-fun m!163 () Bool)

(assert (=> bm!423 m!163))

(declare-fun m!165 () Bool)

(assert (=> bm!424 m!165))

(declare-fun m!167 () Bool)

(assert (=> bm!431 m!167))

(assert (=> b!504 d!45))

(declare-fun bm!439 () Bool)

(declare-fun c!277 () Bool)

(declare-fun c!276 () Bool)

(declare-fun call!456 () Int)

(assert (=> bm!439 (= call!456 (complexity!0 (ite c!277 (lhs!216 (rhs!216 expr!7)) (ite c!276 (rhs!214 (rhs!216 expr!7)) (fac2!30 (rhs!216 expr!7))))))))

(declare-fun b!565 () Bool)

(declare-fun e!291 () Int)

(declare-fun e!289 () Int)

(assert (=> b!565 (= e!291 e!289)))

(assert (=> b!565 (= c!277 ((_ is Minus!6) (rhs!216 expr!7)))))

(declare-fun b!566 () Bool)

(declare-fun c!278 () Bool)

(assert (=> b!566 (= c!278 ((_ is UMinus!6) (rhs!216 expr!7)))))

(declare-fun e!295 () Int)

(assert (=> b!566 (= e!289 e!295)))

(declare-fun c!272 () Bool)

(declare-fun bm!440 () Bool)

(declare-fun c!280 () Bool)

(declare-fun c!275 () Bool)

(declare-fun c!274 () Bool)

(declare-fun call!449 () Int)

(declare-fun c!273 () Bool)

(declare-fun c!279 () Bool)

(assert (=> bm!440 (= call!449 (complexity!0 (ite c!277 (rhs!216 (rhs!216 expr!7)) (ite c!278 (expr!89 (rhs!216 expr!7)) (ite c!276 (lhs!214 (rhs!216 expr!7)) (ite c!279 (s!51 (rhs!216 expr!7)) (ite c!272 (rhs!213 (rhs!216 expr!7)) (ite c!280 (base!30 (rhs!216 expr!7)) (ite c!273 (lhs!211 (rhs!216 expr!7)) (ite c!275 (rhs!210 (rhs!216 expr!7)) (ite c!274 (lhs!215 (rhs!216 expr!7)) (lhs!212 (rhs!216 expr!7)))))))))))))))

(declare-fun bm!441 () Bool)

(declare-fun call!448 () Int)

(declare-fun call!442 () Int)

(assert (=> bm!441 (= call!448 call!442)))

(declare-fun b!567 () Bool)

(declare-fun call!443 () Int)

(assert (=> b!567 (= e!295 (+ 1 call!443))))

(declare-fun d!47 () Bool)

(declare-fun lt!26 () Int)

(assert (=> d!47 (> lt!26 0)))

(assert (=> d!47 (= lt!26 e!291)))

(declare-fun c!281 () Bool)

(assert (=> d!47 (= c!281 ((_ is IntegerLiteral!6) (rhs!216 expr!7)))))

(assert (=> d!47 (= (complexity!0 (rhs!216 expr!7)) lt!26)))

(declare-fun b!568 () Bool)

(declare-fun e!293 () Int)

(declare-fun call!453 () Int)

(declare-fun call!446 () Int)

(assert (=> b!568 (= e!293 (+ 1 call!453 call!446))))

(declare-fun bm!442 () Bool)

(declare-fun call!457 () Int)

(declare-fun call!445 () Int)

(assert (=> bm!442 (= call!457 call!445)))

(declare-fun b!569 () Bool)

(declare-fun e!290 () Int)

(declare-fun call!450 () Int)

(assert (=> b!569 (= e!290 (+ 1 call!450 call!442))))

(declare-fun b!570 () Bool)

(assert (=> b!570 (= c!280 ((_ is IntPow!6) (rhs!216 expr!7)))))

(declare-fun e!297 () Int)

(assert (=> b!570 (= e!290 e!297)))

(declare-fun b!571 () Bool)

(declare-fun e!288 () Int)

(assert (=> b!571 (= e!295 e!288)))

(assert (=> b!571 (= c!276 ((_ is Times!6) (rhs!216 expr!7)))))

(declare-fun bm!443 () Bool)

(declare-fun call!444 () Int)

(assert (=> bm!443 (= call!450 call!444)))

(declare-fun bm!444 () Bool)

(assert (=> bm!444 (= call!445 call!448)))

(declare-fun b!572 () Bool)

(declare-fun e!292 () Int)

(assert (=> b!572 (= e!297 e!292)))

(assert (=> b!572 (= c!273 ((_ is LessThan!6) (rhs!216 expr!7)))))

(declare-fun b!573 () Bool)

(assert (=> b!573 (= e!291 1)))

(declare-fun bm!445 () Bool)

(declare-fun call!451 () Int)

(declare-fun call!455 () Int)

(assert (=> bm!445 (= call!451 call!455)))

(declare-fun call!452 () Int)

(declare-fun b!574 () Bool)

(declare-fun call!447 () Int)

(declare-fun e!296 () Int)

(assert (=> b!574 (= e!296 (+ 1 call!444 call!447 call!452))))

(declare-fun bm!446 () Bool)

(assert (=> bm!446 (= call!443 call!449)))

(declare-fun b!575 () Bool)

(assert (=> b!575 (= e!296 e!290)))

(assert (=> b!575 (= c!272 ((_ is Division!6) (rhs!216 expr!7)))))

(declare-fun b!576 () Bool)

(assert (=> b!576 (= e!292 (+ 1 call!445 call!455))))

(declare-fun b!577 () Bool)

(assert (=> b!577 (= e!297 (+ 1 call!448))))

(declare-fun bm!447 () Bool)

(assert (=> bm!447 (= call!444 (complexity!0 (ite c!279 (fac1!30 (rhs!216 expr!7)) (ite c!272 (lhs!213 (rhs!216 expr!7)) (ite c!273 (rhs!211 (rhs!216 expr!7)) (ite c!275 (lhs!210 (rhs!216 expr!7)) (ite c!274 (rhs!215 (rhs!216 expr!7)) (rhs!212 (rhs!216 expr!7)))))))))))

(declare-fun b!578 () Bool)

(declare-fun e!294 () Int)

(assert (=> b!578 (= e!294 (+ 1 call!451 call!457))))

(declare-fun bm!448 () Bool)

(assert (=> bm!448 (= call!442 call!452)))

(declare-fun bm!449 () Bool)

(declare-fun call!454 () Int)

(assert (=> bm!449 (= call!454 call!443)))

(declare-fun b!579 () Bool)

(assert (=> b!579 (= c!275 ((_ is GreaterThan!6) (rhs!216 expr!7)))))

(assert (=> b!579 (= e!292 e!294)))

(declare-fun bm!450 () Bool)

(assert (=> bm!450 (= call!453 call!457)))

(declare-fun bm!451 () Bool)

(assert (=> bm!451 (= call!446 call!451)))

(declare-fun b!580 () Bool)

(assert (=> b!580 (= e!288 (+ 1 call!454 call!447))))

(declare-fun bm!452 () Bool)

(assert (=> bm!452 (= call!455 call!450)))

(declare-fun b!581 () Bool)

(assert (=> b!581 (= c!279 ((_ is FMA!6) (rhs!216 expr!7)))))

(assert (=> b!581 (= e!288 e!296)))

(declare-fun b!582 () Bool)

(assert (=> b!582 (= e!293 (+ 1 call!453 call!446))))

(declare-fun bm!453 () Bool)

(assert (=> bm!453 (= call!447 call!456)))

(declare-fun b!583 () Bool)

(assert (=> b!583 (= e!294 e!293)))

(assert (=> b!583 (= c!274 ((_ is LessEquals!6) (rhs!216 expr!7)))))

(declare-fun b!584 () Bool)

(assert (=> b!584 (= e!289 (+ 1 call!456 call!449))))

(declare-fun bm!454 () Bool)

(assert (=> bm!454 (= call!452 call!454)))

(assert (= (and d!47 c!281) b!573))

(assert (= (and d!47 (not c!281)) b!565))

(assert (= (and b!565 c!277) b!584))

(assert (= (and b!565 (not c!277)) b!566))

(assert (= (and b!566 c!278) b!567))

(assert (= (and b!566 (not c!278)) b!571))

(assert (= (and b!571 c!276) b!580))

(assert (= (and b!571 (not c!276)) b!581))

(assert (= (and b!581 c!279) b!574))

(assert (= (and b!581 (not c!279)) b!575))

(assert (= (and b!575 c!272) b!569))

(assert (= (and b!575 (not c!272)) b!570))

(assert (= (and b!570 c!280) b!577))

(assert (= (and b!570 (not c!280)) b!572))

(assert (= (and b!572 c!273) b!576))

(assert (= (and b!572 (not c!273)) b!579))

(assert (= (and b!579 c!275) b!578))

(assert (= (and b!579 (not c!275)) b!583))

(assert (= (and b!583 c!274) b!568))

(assert (= (and b!583 (not c!274)) b!582))

(assert (= (or b!568 b!582) bm!451))

(assert (= (or b!568 b!582) bm!450))

(assert (= (or b!578 bm!450) bm!442))

(assert (= (or b!578 bm!451) bm!445))

(assert (= (or b!576 bm!442) bm!444))

(assert (= (or b!576 bm!445) bm!452))

(assert (= (or b!577 bm!444) bm!441))

(assert (= (or b!569 bm!452) bm!443))

(assert (= (or b!569 bm!441) bm!448))

(assert (= (or b!574 bm!443) bm!447))

(assert (= (or b!574 bm!448) bm!454))

(assert (= (or b!580 b!574) bm!453))

(assert (= (or b!580 bm!454) bm!449))

(assert (= (or b!567 bm!449) bm!446))

(assert (= (or b!584 bm!446) bm!440))

(assert (= (or b!584 bm!453) bm!439))

(declare-fun m!169 () Bool)

(assert (=> bm!439 m!169))

(declare-fun m!171 () Bool)

(assert (=> bm!440 m!171))

(declare-fun m!173 () Bool)

(assert (=> bm!447 m!173))

(assert (=> b!504 d!47))

(check-sat (not bm!439) (not bm!447) (not bm!424) (not bm!423) (not bm!431) (not bm!440))
(check-sat)
