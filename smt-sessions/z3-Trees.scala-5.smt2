; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!26 () Bool)

(assert start!26)

(declare-fun res!133 () Bool)

(declare-fun e!300 () Bool)

(assert (=> start!26 (=> (not res!133) (not e!300))))

(declare-datatypes ((Expr!8 0))(
  ( (FMA!7 (fac1!31 Expr!8) (fac2!31 Expr!8) (s!53 Expr!8)) (IntegerLiteral!7 (value!61 Int)) (GreaterThan!7 (lhs!217 Expr!8) (rhs!217 Expr!8)) (LessThan!7 (lhs!218 Expr!8) (rhs!218 Expr!8)) (GreaterEquals!7 (lhs!219 Expr!8) (rhs!219 Expr!8)) (UMinus!7 (expr!91 Expr!8)) (IntPow!7 (base!31 Expr!8) (exp!31 Int)) (Division!7 (lhs!220 Expr!8) (rhs!220 Expr!8)) (Times!7 (lhs!221 Expr!8) (rhs!221 Expr!8)) (LessEquals!7 (lhs!222 Expr!8) (rhs!222 Expr!8)) (Minus!7 (lhs!223 Expr!8) (rhs!223 Expr!8)) )
))
(declare-fun expr!7 () Expr!8)

(get-info :version)

(assert (=> start!26 (= res!133 (and (not ((_ is IntegerLiteral!7) expr!7)) (not ((_ is Minus!7) expr!7)) ((_ is UMinus!7) expr!7)))))

(assert (=> start!26 e!300))

(assert (=> start!26 true))

(declare-fun b!587 () Bool)

(declare-fun ExprPrimitiveSize!0 (Expr!8) Int)

(assert (=> b!587 (= e!300 (>= (ExprPrimitiveSize!0 (expr!91 expr!7)) (ExprPrimitiveSize!0 expr!7)))))

(assert (= (and start!26 res!133) b!587))

(declare-fun m!175 () Bool)

(assert (=> b!587 m!175))

(declare-fun m!177 () Bool)

(assert (=> b!587 m!177))

(check-sat (not b!587))
(check-sat)
(get-model)

(declare-fun b!628 () Bool)

(declare-fun e!328 () Int)

(declare-fun call!497 () Int)

(declare-fun call!501 () Int)

(assert (=> b!628 (= e!328 (+ 1 call!497 call!501))))

(declare-fun bm!489 () Bool)

(declare-fun call!500 () Int)

(declare-fun call!498 () Int)

(assert (=> bm!489 (= call!500 call!498)))

(declare-fun bm!490 () Bool)

(declare-fun call!499 () Int)

(declare-fun call!502 () Int)

(assert (=> bm!490 (= call!499 call!502)))

(declare-fun b!629 () Bool)

(declare-fun e!323 () Int)

(assert (=> b!629 (= e!323 e!328)))

(declare-fun c!311 () Bool)

(assert (=> b!629 (= c!311 ((_ is LessEquals!7) (expr!91 expr!7)))))

(declare-fun c!307 () Bool)

(declare-fun c!310 () Bool)

(declare-fun c!303 () Bool)

(declare-fun bm!491 () Bool)

(declare-fun call!505 () Int)

(declare-fun c!304 () Bool)

(declare-fun c!306 () Bool)

(declare-fun c!302 () Bool)

(assert (=> bm!491 (= call!505 (ExprPrimitiveSize!0 (ite c!310 (fac1!31 (expr!91 expr!7)) (ite c!304 (rhs!217 (expr!91 expr!7)) (ite c!302 (lhs!218 (expr!91 expr!7)) (ite c!303 (rhs!219 (expr!91 expr!7)) (ite c!307 (rhs!220 (expr!91 expr!7)) (ite c!306 (rhs!221 (expr!91 expr!7)) (ite c!311 (lhs!222 (expr!91 expr!7)) (rhs!223 (expr!91 expr!7)))))))))))))

(declare-fun bm!492 () Bool)

(assert (=> bm!492 (= call!497 call!500)))

(declare-fun b!630 () Bool)

(declare-fun e!329 () Int)

(declare-fun call!508 () Int)

(assert (=> b!630 (= e!329 (+ 1 call!508))))

(declare-fun b!631 () Bool)

(declare-fun e!325 () Int)

(declare-fun e!326 () Int)

(assert (=> b!631 (= e!325 e!326)))

(assert (=> b!631 (= c!307 ((_ is Division!7) (expr!91 expr!7)))))

(declare-fun b!632 () Bool)

(assert (=> b!632 (= e!328 (+ 1 call!501 call!497))))

(declare-fun bm!493 () Bool)

(declare-fun call!492 () Int)

(assert (=> bm!493 (= call!501 call!492)))

(declare-fun bm!494 () Bool)

(declare-fun call!493 () Int)

(declare-fun call!495 () Int)

(assert (=> bm!494 (= call!493 call!495)))

(declare-fun b!633 () Bool)

(declare-fun e!321 () Int)

(declare-fun call!494 () Int)

(declare-fun call!504 () Int)

(assert (=> b!633 (= e!321 (+ 1 call!494 call!504))))

(declare-fun bm!495 () Bool)

(declare-fun call!507 () Int)

(assert (=> bm!495 (= call!498 call!507)))

(declare-fun b!634 () Bool)

(declare-fun call!496 () Int)

(assert (=> b!634 (= e!326 (+ 1 call!498 call!496))))

(declare-fun bm!496 () Bool)

(declare-fun call!503 () Int)

(declare-fun c!308 () Bool)

(declare-fun BigIntAbs!0 (Int) Int)

(assert (=> bm!496 (= call!503 (BigIntAbs!0 (ite c!308 (value!61 (expr!91 expr!7)) (exp!31 (expr!91 expr!7)))))))

(declare-fun bm!497 () Bool)

(assert (=> bm!497 (= call!495 call!504)))

(declare-fun b!635 () Bool)

(declare-fun e!324 () Int)

(declare-fun e!330 () Int)

(assert (=> b!635 (= e!324 e!330)))

(assert (=> b!635 (= c!308 ((_ is IntegerLiteral!7) (expr!91 expr!7)))))

(declare-fun bm!499 () Bool)

(assert (=> bm!499 (= call!502 call!494)))

(declare-fun b!636 () Bool)

(declare-fun e!322 () Int)

(assert (=> b!636 (= e!322 e!329)))

(declare-fun c!305 () Bool)

(assert (=> b!636 (= c!305 ((_ is UMinus!7) (expr!91 expr!7)))))

(declare-fun b!637 () Bool)

(assert (=> b!637 (= e!323 (+ 1 call!500 call!492))))

(declare-fun b!638 () Bool)

(declare-fun c!309 () Bool)

(assert (=> b!638 (= c!309 ((_ is IntPow!7) (expr!91 expr!7)))))

(assert (=> b!638 (= e!329 e!325)))

(declare-fun b!639 () Bool)

(assert (=> b!639 (= e!325 (+ 1 call!507 call!503))))

(declare-fun bm!500 () Bool)

(assert (=> bm!500 (= call!492 call!496)))

(declare-fun b!640 () Bool)

(declare-fun e!327 () Int)

(assert (=> b!640 (= e!321 e!327)))

(assert (=> b!640 (= c!302 ((_ is LessThan!7) (expr!91 expr!7)))))

(declare-fun call!506 () Int)

(declare-fun bm!501 () Bool)

(assert (=> bm!501 (= call!506 (ExprPrimitiveSize!0 (ite c!310 (s!53 (expr!91 expr!7)) (ite c!304 (lhs!217 (expr!91 expr!7)) (ite c!302 (rhs!218 (expr!91 expr!7)) (ite c!303 (lhs!219 (expr!91 expr!7)) (ite c!305 (expr!91 (expr!91 expr!7)) (ite c!309 (base!31 (expr!91 expr!7)) (ite c!307 (lhs!220 (expr!91 expr!7)) (ite c!306 (lhs!221 (expr!91 expr!7)) (ite c!311 (rhs!222 (expr!91 expr!7)) (lhs!223 (expr!91 expr!7)))))))))))))))

(declare-fun b!641 () Bool)

(assert (=> b!641 (= e!330 (+ 1 call!503))))

(declare-fun b!642 () Bool)

(assert (=> b!642 (= e!322 (+ 1 call!499 call!493))))

(declare-fun bm!502 () Bool)

(assert (=> bm!502 (= call!508 call!499)))

(declare-fun bm!503 () Bool)

(assert (=> bm!503 (= call!504 call!505)))

(declare-fun b!643 () Bool)

(assert (=> b!643 (= c!304 ((_ is GreaterThan!7) (expr!91 expr!7)))))

(assert (=> b!643 (= e!330 e!321)))

(declare-fun bm!504 () Bool)

(assert (=> bm!504 (= call!507 call!508)))

(declare-fun bm!505 () Bool)

(assert (=> bm!505 (= call!494 call!506)))

(declare-fun b!644 () Bool)

(assert (=> b!644 (= c!303 ((_ is GreaterEquals!7) (expr!91 expr!7)))))

(assert (=> b!644 (= e!327 e!322)))

(declare-fun b!645 () Bool)

(assert (=> b!645 (= e!327 (+ 1 call!495 call!502))))

(declare-fun d!49 () Bool)

(declare-fun lt!29 () Int)

(assert (=> d!49 (>= lt!29 0)))

(assert (=> d!49 (= lt!29 e!324)))

(assert (=> d!49 (= c!310 ((_ is FMA!7) (expr!91 expr!7)))))

(assert (=> d!49 (= (ExprPrimitiveSize!0 (expr!91 expr!7)) lt!29)))

(declare-fun bm!498 () Bool)

(assert (=> bm!498 (= call!496 call!493)))

(declare-fun b!646 () Bool)

(assert (=> b!646 (= e!324 (+ 1 call!505 (ExprPrimitiveSize!0 (fac2!31 (expr!91 expr!7))) call!506))))

(declare-fun b!647 () Bool)

(assert (=> b!647 (= c!306 ((_ is Times!7) (expr!91 expr!7)))))

(assert (=> b!647 (= e!326 e!323)))

(assert (= (and d!49 c!310) b!646))

(assert (= (and d!49 (not c!310)) b!635))

(assert (= (and b!635 c!308) b!641))

(assert (= (and b!635 (not c!308)) b!643))

(assert (= (and b!643 c!304) b!633))

(assert (= (and b!643 (not c!304)) b!640))

(assert (= (and b!640 c!302) b!645))

(assert (= (and b!640 (not c!302)) b!644))

(assert (= (and b!644 c!303) b!642))

(assert (= (and b!644 (not c!303)) b!636))

(assert (= (and b!636 c!305) b!630))

(assert (= (and b!636 (not c!305)) b!638))

(assert (= (and b!638 c!309) b!639))

(assert (= (and b!638 (not c!309)) b!631))

(assert (= (and b!631 c!307) b!634))

(assert (= (and b!631 (not c!307)) b!647))

(assert (= (and b!647 c!306) b!637))

(assert (= (and b!647 (not c!306)) b!629))

(assert (= (and b!629 c!311) b!632))

(assert (= (and b!629 (not c!311)) b!628))

(assert (= (or b!632 b!628) bm!493))

(assert (= (or b!632 b!628) bm!492))

(assert (= (or b!637 bm!492) bm!489))

(assert (= (or b!637 bm!493) bm!500))

(assert (= (or b!634 bm!500) bm!498))

(assert (= (or b!634 bm!489) bm!495))

(assert (= (or b!639 bm!495) bm!504))

(assert (= (or b!630 bm!504) bm!502))

(assert (= (or b!642 bm!502) bm!490))

(assert (= (or b!642 bm!498) bm!494))

(assert (= (or b!645 bm!490) bm!499))

(assert (= (or b!645 bm!494) bm!497))

(assert (= (or b!633 bm!497) bm!503))

(assert (= (or b!633 bm!499) bm!505))

(assert (= (or b!641 b!639) bm!496))

(assert (= (or b!646 bm!505) bm!501))

(assert (= (or b!646 bm!503) bm!491))

(declare-fun m!179 () Bool)

(assert (=> bm!491 m!179))

(declare-fun m!181 () Bool)

(assert (=> bm!496 m!181))

(declare-fun m!183 () Bool)

(assert (=> bm!501 m!183))

(declare-fun m!185 () Bool)

(assert (=> b!646 m!185))

(assert (=> b!587 d!49))

(declare-fun b!648 () Bool)

(declare-fun e!338 () Int)

(declare-fun call!514 () Int)

(declare-fun call!518 () Int)

(assert (=> b!648 (= e!338 (+ 1 call!514 call!518))))

(declare-fun bm!506 () Bool)

(declare-fun call!517 () Int)

(declare-fun call!515 () Int)

(assert (=> bm!506 (= call!517 call!515)))

(declare-fun bm!507 () Bool)

(declare-fun call!516 () Int)

(declare-fun call!519 () Int)

(assert (=> bm!507 (= call!516 call!519)))

(declare-fun b!649 () Bool)

(declare-fun e!333 () Int)

(assert (=> b!649 (= e!333 e!338)))

(declare-fun c!321 () Bool)

(assert (=> b!649 (= c!321 ((_ is LessEquals!7) expr!7))))

(declare-fun c!317 () Bool)

(declare-fun call!522 () Int)

(declare-fun c!312 () Bool)

(declare-fun c!314 () Bool)

(declare-fun c!316 () Bool)

(declare-fun c!313 () Bool)

(declare-fun c!320 () Bool)

(declare-fun bm!508 () Bool)

(assert (=> bm!508 (= call!522 (ExprPrimitiveSize!0 (ite c!320 (fac1!31 expr!7) (ite c!314 (rhs!217 expr!7) (ite c!312 (lhs!218 expr!7) (ite c!313 (rhs!219 expr!7) (ite c!317 (rhs!220 expr!7) (ite c!316 (rhs!221 expr!7) (ite c!321 (lhs!222 expr!7) (rhs!223 expr!7))))))))))))

(declare-fun bm!509 () Bool)

(assert (=> bm!509 (= call!514 call!517)))

(declare-fun b!650 () Bool)

(declare-fun e!339 () Int)

(declare-fun call!525 () Int)

(assert (=> b!650 (= e!339 (+ 1 call!525))))

(declare-fun b!651 () Bool)

(declare-fun e!335 () Int)

(declare-fun e!336 () Int)

(assert (=> b!651 (= e!335 e!336)))

(assert (=> b!651 (= c!317 ((_ is Division!7) expr!7))))

(declare-fun b!652 () Bool)

(assert (=> b!652 (= e!338 (+ 1 call!518 call!514))))

(declare-fun bm!510 () Bool)

(declare-fun call!509 () Int)

(assert (=> bm!510 (= call!518 call!509)))

(declare-fun bm!511 () Bool)

(declare-fun call!510 () Int)

(declare-fun call!512 () Int)

(assert (=> bm!511 (= call!510 call!512)))

(declare-fun b!653 () Bool)

(declare-fun e!331 () Int)

(declare-fun call!511 () Int)

(declare-fun call!521 () Int)

(assert (=> b!653 (= e!331 (+ 1 call!511 call!521))))

(declare-fun bm!512 () Bool)

(declare-fun call!524 () Int)

(assert (=> bm!512 (= call!515 call!524)))

(declare-fun b!654 () Bool)

(declare-fun call!513 () Int)

(assert (=> b!654 (= e!336 (+ 1 call!515 call!513))))

(declare-fun bm!513 () Bool)

(declare-fun call!520 () Int)

(declare-fun c!318 () Bool)

(assert (=> bm!513 (= call!520 (BigIntAbs!0 (ite c!318 (value!61 expr!7) (exp!31 expr!7))))))

(declare-fun bm!514 () Bool)

(assert (=> bm!514 (= call!512 call!521)))

(declare-fun b!655 () Bool)

(declare-fun e!334 () Int)

(declare-fun e!340 () Int)

(assert (=> b!655 (= e!334 e!340)))

(assert (=> b!655 (= c!318 ((_ is IntegerLiteral!7) expr!7))))

(declare-fun bm!516 () Bool)

(assert (=> bm!516 (= call!519 call!511)))

(declare-fun b!656 () Bool)

(declare-fun e!332 () Int)

(assert (=> b!656 (= e!332 e!339)))

(declare-fun c!315 () Bool)

(assert (=> b!656 (= c!315 ((_ is UMinus!7) expr!7))))

(declare-fun b!657 () Bool)

(assert (=> b!657 (= e!333 (+ 1 call!517 call!509))))

(declare-fun b!658 () Bool)

(declare-fun c!319 () Bool)

(assert (=> b!658 (= c!319 ((_ is IntPow!7) expr!7))))

(assert (=> b!658 (= e!339 e!335)))

(declare-fun b!659 () Bool)

(assert (=> b!659 (= e!335 (+ 1 call!524 call!520))))

(declare-fun bm!517 () Bool)

(assert (=> bm!517 (= call!509 call!513)))

(declare-fun b!660 () Bool)

(declare-fun e!337 () Int)

(assert (=> b!660 (= e!331 e!337)))

(assert (=> b!660 (= c!312 ((_ is LessThan!7) expr!7))))

(declare-fun call!523 () Int)

(declare-fun bm!518 () Bool)

(assert (=> bm!518 (= call!523 (ExprPrimitiveSize!0 (ite c!320 (s!53 expr!7) (ite c!314 (lhs!217 expr!7) (ite c!312 (rhs!218 expr!7) (ite c!313 (lhs!219 expr!7) (ite c!315 (expr!91 expr!7) (ite c!319 (base!31 expr!7) (ite c!317 (lhs!220 expr!7) (ite c!316 (lhs!221 expr!7) (ite c!321 (rhs!222 expr!7) (lhs!223 expr!7))))))))))))))

(declare-fun b!661 () Bool)

(assert (=> b!661 (= e!340 (+ 1 call!520))))

(declare-fun b!662 () Bool)

(assert (=> b!662 (= e!332 (+ 1 call!516 call!510))))

(declare-fun bm!519 () Bool)

(assert (=> bm!519 (= call!525 call!516)))

(declare-fun bm!520 () Bool)

(assert (=> bm!520 (= call!521 call!522)))

(declare-fun b!663 () Bool)

(assert (=> b!663 (= c!314 ((_ is GreaterThan!7) expr!7))))

(assert (=> b!663 (= e!340 e!331)))

(declare-fun bm!521 () Bool)

(assert (=> bm!521 (= call!524 call!525)))

(declare-fun bm!522 () Bool)

(assert (=> bm!522 (= call!511 call!523)))

(declare-fun b!664 () Bool)

(assert (=> b!664 (= c!313 ((_ is GreaterEquals!7) expr!7))))

(assert (=> b!664 (= e!337 e!332)))

(declare-fun b!665 () Bool)

(assert (=> b!665 (= e!337 (+ 1 call!512 call!519))))

(declare-fun d!51 () Bool)

(declare-fun lt!30 () Int)

(assert (=> d!51 (>= lt!30 0)))

(assert (=> d!51 (= lt!30 e!334)))

(assert (=> d!51 (= c!320 ((_ is FMA!7) expr!7))))

(assert (=> d!51 (= (ExprPrimitiveSize!0 expr!7) lt!30)))

(declare-fun bm!515 () Bool)

(assert (=> bm!515 (= call!513 call!510)))

(declare-fun b!666 () Bool)

(assert (=> b!666 (= e!334 (+ 1 call!522 (ExprPrimitiveSize!0 (fac2!31 expr!7)) call!523))))

(declare-fun b!667 () Bool)

(assert (=> b!667 (= c!316 ((_ is Times!7) expr!7))))

(assert (=> b!667 (= e!336 e!333)))

(assert (= (and d!51 c!320) b!666))

(assert (= (and d!51 (not c!320)) b!655))

(assert (= (and b!655 c!318) b!661))

(assert (= (and b!655 (not c!318)) b!663))

(assert (= (and b!663 c!314) b!653))

(assert (= (and b!663 (not c!314)) b!660))

(assert (= (and b!660 c!312) b!665))

(assert (= (and b!660 (not c!312)) b!664))

(assert (= (and b!664 c!313) b!662))

(assert (= (and b!664 (not c!313)) b!656))

(assert (= (and b!656 c!315) b!650))

(assert (= (and b!656 (not c!315)) b!658))

(assert (= (and b!658 c!319) b!659))

(assert (= (and b!658 (not c!319)) b!651))

(assert (= (and b!651 c!317) b!654))

(assert (= (and b!651 (not c!317)) b!667))

(assert (= (and b!667 c!316) b!657))

(assert (= (and b!667 (not c!316)) b!649))

(assert (= (and b!649 c!321) b!652))

(assert (= (and b!649 (not c!321)) b!648))

(assert (= (or b!652 b!648) bm!510))

(assert (= (or b!652 b!648) bm!509))

(assert (= (or b!657 bm!509) bm!506))

(assert (= (or b!657 bm!510) bm!517))

(assert (= (or b!654 bm!517) bm!515))

(assert (= (or b!654 bm!506) bm!512))

(assert (= (or b!659 bm!512) bm!521))

(assert (= (or b!650 bm!521) bm!519))

(assert (= (or b!662 bm!519) bm!507))

(assert (= (or b!662 bm!515) bm!511))

(assert (= (or b!665 bm!507) bm!516))

(assert (= (or b!665 bm!511) bm!514))

(assert (= (or b!653 bm!514) bm!520))

(assert (= (or b!653 bm!516) bm!522))

(assert (= (or b!661 b!659) bm!513))

(assert (= (or b!666 bm!522) bm!518))

(assert (= (or b!666 bm!520) bm!508))

(declare-fun m!187 () Bool)

(assert (=> bm!508 m!187))

(declare-fun m!189 () Bool)

(assert (=> bm!513 m!189))

(declare-fun m!191 () Bool)

(assert (=> bm!518 m!191))

(declare-fun m!193 () Bool)

(assert (=> b!666 m!193))

(assert (=> b!587 d!51))

(check-sat (not bm!501) (not bm!496) (not bm!491) (not b!666) (not bm!518) (not bm!513) (not bm!508) (not b!646))
(check-sat)
