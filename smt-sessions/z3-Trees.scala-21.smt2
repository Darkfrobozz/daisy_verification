; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!110 () Bool)

(assert start!110)

(declare-fun res!181 () Bool)

(declare-fun e!1568 () Bool)

(assert (=> start!110 (=> (not res!181) (not e!1568))))

(declare-datatypes ((Expr!24 0))(
  ( (FMA!23 (fac1!47 Expr!24) (fac2!47 Expr!24) (s!85 Expr!24)) (IntegerLiteral!23 (value!93 Int)) (GreaterThan!23 (lhs!329 Expr!24) (rhs!329 Expr!24)) (LessThan!23 (lhs!330 Expr!24) (rhs!330 Expr!24)) (GreaterEquals!23 (lhs!331 Expr!24) (rhs!331 Expr!24)) (UMinus!23 (expr!112 Expr!24)) (IntPow!23 (base!47 Expr!24) (exp!47 Int)) (Division!23 (lhs!332 Expr!24) (rhs!332 Expr!24)) (Times!23 (lhs!333 Expr!24) (rhs!333 Expr!24)) (LessEquals!23 (lhs!334 Expr!24) (rhs!334 Expr!24)) (Minus!23 (lhs!335 Expr!24) (rhs!335 Expr!24)) )
))
(declare-fun expr!7 () Expr!24)

(get-info :version)

(assert (=> start!110 (= res!181 (and (not ((_ is IntegerLiteral!23) expr!7)) (not ((_ is Minus!23) expr!7)) (not ((_ is UMinus!23) expr!7)) (not ((_ is Times!23) expr!7)) (not ((_ is FMA!23) expr!7)) (not ((_ is Division!23) expr!7)) (not ((_ is IntPow!23) expr!7)) ((_ is LessThan!23) expr!7)))))

(assert (=> start!110 e!1568))

(assert (=> start!110 true))

(declare-fun b!3075 () Bool)

(declare-fun complexity!0 (Expr!24) Int)

(assert (=> b!3075 (= e!1568 (<= (+ 1 (complexity!0 (lhs!330 expr!7)) (complexity!0 (rhs!330 expr!7))) 0))))

(assert (= (and start!110 res!181) b!3075))

(declare-fun m!937 () Bool)

(assert (=> b!3075 m!937))

(declare-fun m!939 () Bool)

(assert (=> b!3075 m!939))

(check-sat (not b!3075))
(check-sat)
(get-model)

(declare-fun b!3116 () Bool)

(declare-fun e!1598 () Int)

(assert (=> b!3116 (= e!1598 1)))

(declare-fun bm!2542 () Bool)

(declare-fun call!2555 () Int)

(declare-fun call!2547 () Int)

(assert (=> bm!2542 (= call!2555 call!2547)))

(declare-fun b!3117 () Bool)

(declare-fun e!1589 () Int)

(declare-fun e!1593 () Int)

(assert (=> b!3117 (= e!1589 e!1593)))

(declare-fun c!1529 () Bool)

(assert (=> b!3117 (= c!1529 ((_ is LessThan!23) (lhs!330 expr!7)))))

(declare-fun b!3118 () Bool)

(declare-fun e!1596 () Int)

(declare-fun call!2558 () Int)

(assert (=> b!3118 (= e!1596 (+ 1 call!2558 call!2547))))

(declare-fun bm!2543 () Bool)

(declare-fun call!2550 () Int)

(declare-fun call!2557 () Int)

(assert (=> bm!2543 (= call!2550 call!2557)))

(declare-fun b!3119 () Bool)

(declare-fun c!1528 () Bool)

(assert (=> b!3119 (= c!1528 ((_ is UMinus!23) (lhs!330 expr!7)))))

(declare-fun e!1595 () Int)

(declare-fun e!1597 () Int)

(assert (=> b!3119 (= e!1595 e!1597)))

(declare-fun bm!2544 () Bool)

(declare-fun call!2560 () Int)

(declare-fun call!2548 () Int)

(assert (=> bm!2544 (= call!2560 call!2548)))

(declare-fun bm!2545 () Bool)

(declare-fun call!2553 () Int)

(declare-fun call!2556 () Int)

(assert (=> bm!2545 (= call!2553 call!2556)))

(declare-fun bm!2546 () Bool)

(declare-fun call!2559 () Int)

(assert (=> bm!2546 (= call!2556 call!2559)))

(declare-fun b!3120 () Bool)

(declare-fun e!1591 () Int)

(assert (=> b!3120 (= e!1591 (+ 1 call!2550 (complexity!0 (fac2!47 (lhs!330 expr!7))) call!2553))))

(declare-fun b!3121 () Bool)

(declare-fun c!1523 () Bool)

(assert (=> b!3121 (= c!1523 ((_ is FMA!23) (lhs!330 expr!7)))))

(declare-fun e!1592 () Int)

(assert (=> b!3121 (= e!1592 e!1591)))

(declare-fun b!3122 () Bool)

(assert (=> b!3122 (= e!1592 (+ 1 call!2556 call!2557))))

(declare-fun b!3123 () Bool)

(declare-fun call!2549 () Int)

(assert (=> b!3123 (= e!1593 (+ 1 call!2549 call!2560))))

(declare-fun bm!2547 () Bool)

(declare-fun call!2552 () Int)

(assert (=> bm!2547 (= call!2552 call!2550)))

(declare-fun bm!2548 () Bool)

(assert (=> bm!2548 (= call!2547 call!2549)))

(declare-fun bm!2549 () Bool)

(declare-fun call!2551 () Int)

(assert (=> bm!2549 (= call!2557 call!2551)))

(declare-fun b!3124 () Bool)

(declare-fun c!1526 () Bool)

(assert (=> b!3124 (= c!1526 ((_ is GreaterThan!23) (lhs!330 expr!7)))))

(assert (=> b!3124 (= e!1593 e!1596)))

(declare-fun b!3125 () Bool)

(assert (=> b!3125 (= e!1589 (+ 1 call!2548))))

(declare-fun b!3126 () Bool)

(declare-fun e!1590 () Int)

(declare-fun call!2546 () Int)

(assert (=> b!3126 (= e!1590 (+ 1 call!2555 call!2546))))

(declare-fun bm!2550 () Bool)

(declare-fun call!2554 () Int)

(assert (=> bm!2550 (= call!2559 call!2554)))

(declare-fun d!269 () Bool)

(declare-fun lt!151 () Int)

(assert (=> d!269 (> lt!151 0)))

(assert (=> d!269 (= lt!151 e!1598)))

(declare-fun c!1524 () Bool)

(assert (=> d!269 (= c!1524 ((_ is IntegerLiteral!23) (lhs!330 expr!7)))))

(assert (=> d!269 (= (complexity!0 (lhs!330 expr!7)) lt!151)))

(declare-fun bm!2551 () Bool)

(assert (=> bm!2551 (= call!2558 call!2560)))

(declare-fun c!1522 () Bool)

(declare-fun c!1527 () Bool)

(declare-fun bm!2552 () Bool)

(declare-fun c!1525 () Bool)

(declare-fun c!1530 () Bool)

(assert (=> bm!2552 (= call!2554 (complexity!0 (ite c!1522 (rhs!335 (lhs!330 expr!7)) (ite c!1528 (expr!112 (lhs!330 expr!7)) (ite c!1525 (lhs!333 (lhs!330 expr!7)) (ite c!1523 (s!85 (lhs!330 expr!7)) (ite c!1530 (rhs!332 (lhs!330 expr!7)) (ite c!1529 (lhs!330 (lhs!330 expr!7)) (ite c!1526 (rhs!329 (lhs!330 expr!7)) (ite c!1527 (lhs!334 (lhs!330 expr!7)) (lhs!331 (lhs!330 expr!7))))))))))))))

(declare-fun b!3127 () Bool)

(assert (=> b!3127 (= e!1598 e!1595)))

(assert (=> b!3127 (= c!1522 ((_ is Minus!23) (lhs!330 expr!7)))))

(declare-fun b!3128 () Bool)

(assert (=> b!3128 (= e!1596 e!1590)))

(assert (=> b!3128 (= c!1527 ((_ is LessEquals!23) (lhs!330 expr!7)))))

(declare-fun bm!2553 () Bool)

(declare-fun call!2545 () Int)

(assert (=> bm!2553 (= call!2549 call!2545)))

(declare-fun b!3129 () Bool)

(declare-fun c!1531 () Bool)

(assert (=> b!3129 (= c!1531 ((_ is IntPow!23) (lhs!330 expr!7)))))

(declare-fun e!1594 () Int)

(assert (=> b!3129 (= e!1594 e!1589)))

(declare-fun bm!2554 () Bool)

(assert (=> bm!2554 (= call!2548 call!2552)))

(declare-fun b!3130 () Bool)

(assert (=> b!3130 (= e!1597 (+ 1 call!2559))))

(declare-fun bm!2555 () Bool)

(assert (=> bm!2555 (= call!2551 (complexity!0 (ite c!1522 (lhs!335 (lhs!330 expr!7)) (ite c!1525 (rhs!333 (lhs!330 expr!7)) (ite c!1523 (fac1!47 (lhs!330 expr!7)) (ite c!1530 (lhs!332 (lhs!330 expr!7)) (ite c!1531 (base!47 (lhs!330 expr!7)) (ite c!1529 (rhs!330 (lhs!330 expr!7)) (ite c!1526 (lhs!329 (lhs!330 expr!7)) (ite c!1527 (rhs!334 (lhs!330 expr!7)) (rhs!331 (lhs!330 expr!7))))))))))))))

(declare-fun b!3131 () Bool)

(assert (=> b!3131 (= e!1591 e!1594)))

(assert (=> b!3131 (= c!1530 ((_ is Division!23) (lhs!330 expr!7)))))

(declare-fun b!3132 () Bool)

(assert (=> b!3132 (= e!1594 (+ 1 call!2552 call!2545))))

(declare-fun bm!2556 () Bool)

(assert (=> bm!2556 (= call!2545 call!2553)))

(declare-fun bm!2557 () Bool)

(assert (=> bm!2557 (= call!2546 call!2558)))

(declare-fun b!3133 () Bool)

(assert (=> b!3133 (= e!1595 (+ 1 call!2551 call!2554))))

(declare-fun b!3134 () Bool)

(assert (=> b!3134 (= e!1590 (+ 1 call!2555 call!2546))))

(declare-fun b!3135 () Bool)

(assert (=> b!3135 (= e!1597 e!1592)))

(assert (=> b!3135 (= c!1525 ((_ is Times!23) (lhs!330 expr!7)))))

(assert (= (and d!269 c!1524) b!3116))

(assert (= (and d!269 (not c!1524)) b!3127))

(assert (= (and b!3127 c!1522) b!3133))

(assert (= (and b!3127 (not c!1522)) b!3119))

(assert (= (and b!3119 c!1528) b!3130))

(assert (= (and b!3119 (not c!1528)) b!3135))

(assert (= (and b!3135 c!1525) b!3122))

(assert (= (and b!3135 (not c!1525)) b!3121))

(assert (= (and b!3121 c!1523) b!3120))

(assert (= (and b!3121 (not c!1523)) b!3131))

(assert (= (and b!3131 c!1530) b!3132))

(assert (= (and b!3131 (not c!1530)) b!3129))

(assert (= (and b!3129 c!1531) b!3125))

(assert (= (and b!3129 (not c!1531)) b!3117))

(assert (= (and b!3117 c!1529) b!3123))

(assert (= (and b!3117 (not c!1529)) b!3124))

(assert (= (and b!3124 c!1526) b!3118))

(assert (= (and b!3124 (not c!1526)) b!3128))

(assert (= (and b!3128 c!1527) b!3126))

(assert (= (and b!3128 (not c!1527)) b!3134))

(assert (= (or b!3126 b!3134) bm!2557))

(assert (= (or b!3126 b!3134) bm!2542))

(assert (= (or b!3118 bm!2542) bm!2548))

(assert (= (or b!3118 bm!2557) bm!2551))

(assert (= (or b!3123 bm!2548) bm!2553))

(assert (= (or b!3123 bm!2551) bm!2544))

(assert (= (or b!3125 bm!2544) bm!2554))

(assert (= (or b!3132 bm!2554) bm!2547))

(assert (= (or b!3132 bm!2553) bm!2556))

(assert (= (or b!3120 bm!2547) bm!2543))

(assert (= (or b!3120 bm!2556) bm!2545))

(assert (= (or b!3122 bm!2543) bm!2549))

(assert (= (or b!3122 bm!2545) bm!2546))

(assert (= (or b!3130 bm!2546) bm!2550))

(assert (= (or b!3133 bm!2550) bm!2552))

(assert (= (or b!3133 bm!2549) bm!2555))

(declare-fun m!941 () Bool)

(assert (=> b!3120 m!941))

(declare-fun m!943 () Bool)

(assert (=> bm!2552 m!943))

(declare-fun m!945 () Bool)

(assert (=> bm!2555 m!945))

(assert (=> b!3075 d!269))

(declare-fun b!3136 () Bool)

(declare-fun e!1608 () Int)

(assert (=> b!3136 (= e!1608 1)))

(declare-fun bm!2558 () Bool)

(declare-fun call!2571 () Int)

(declare-fun call!2563 () Int)

(assert (=> bm!2558 (= call!2571 call!2563)))

(declare-fun b!3137 () Bool)

(declare-fun e!1599 () Int)

(declare-fun e!1603 () Int)

(assert (=> b!3137 (= e!1599 e!1603)))

(declare-fun c!1539 () Bool)

(assert (=> b!3137 (= c!1539 ((_ is LessThan!23) (rhs!330 expr!7)))))

(declare-fun b!3138 () Bool)

(declare-fun e!1606 () Int)

(declare-fun call!2574 () Int)

(assert (=> b!3138 (= e!1606 (+ 1 call!2574 call!2563))))

(declare-fun bm!2559 () Bool)

(declare-fun call!2566 () Int)

(declare-fun call!2573 () Int)

(assert (=> bm!2559 (= call!2566 call!2573)))

(declare-fun b!3139 () Bool)

(declare-fun c!1538 () Bool)

(assert (=> b!3139 (= c!1538 ((_ is UMinus!23) (rhs!330 expr!7)))))

(declare-fun e!1605 () Int)

(declare-fun e!1607 () Int)

(assert (=> b!3139 (= e!1605 e!1607)))

(declare-fun bm!2560 () Bool)

(declare-fun call!2576 () Int)

(declare-fun call!2564 () Int)

(assert (=> bm!2560 (= call!2576 call!2564)))

(declare-fun bm!2561 () Bool)

(declare-fun call!2569 () Int)

(declare-fun call!2572 () Int)

(assert (=> bm!2561 (= call!2569 call!2572)))

(declare-fun bm!2562 () Bool)

(declare-fun call!2575 () Int)

(assert (=> bm!2562 (= call!2572 call!2575)))

(declare-fun b!3140 () Bool)

(declare-fun e!1601 () Int)

(assert (=> b!3140 (= e!1601 (+ 1 call!2566 (complexity!0 (fac2!47 (rhs!330 expr!7))) call!2569))))

(declare-fun b!3141 () Bool)

(declare-fun c!1533 () Bool)

(assert (=> b!3141 (= c!1533 ((_ is FMA!23) (rhs!330 expr!7)))))

(declare-fun e!1602 () Int)

(assert (=> b!3141 (= e!1602 e!1601)))

(declare-fun b!3142 () Bool)

(assert (=> b!3142 (= e!1602 (+ 1 call!2572 call!2573))))

(declare-fun b!3143 () Bool)

(declare-fun call!2565 () Int)

(assert (=> b!3143 (= e!1603 (+ 1 call!2565 call!2576))))

(declare-fun bm!2563 () Bool)

(declare-fun call!2568 () Int)

(assert (=> bm!2563 (= call!2568 call!2566)))

(declare-fun bm!2564 () Bool)

(assert (=> bm!2564 (= call!2563 call!2565)))

(declare-fun bm!2565 () Bool)

(declare-fun call!2567 () Int)

(assert (=> bm!2565 (= call!2573 call!2567)))

(declare-fun b!3144 () Bool)

(declare-fun c!1536 () Bool)

(assert (=> b!3144 (= c!1536 ((_ is GreaterThan!23) (rhs!330 expr!7)))))

(assert (=> b!3144 (= e!1603 e!1606)))

(declare-fun b!3145 () Bool)

(assert (=> b!3145 (= e!1599 (+ 1 call!2564))))

(declare-fun b!3146 () Bool)

(declare-fun e!1600 () Int)

(declare-fun call!2562 () Int)

(assert (=> b!3146 (= e!1600 (+ 1 call!2571 call!2562))))

(declare-fun bm!2566 () Bool)

(declare-fun call!2570 () Int)

(assert (=> bm!2566 (= call!2575 call!2570)))

(declare-fun d!271 () Bool)

(declare-fun lt!152 () Int)

(assert (=> d!271 (> lt!152 0)))

(assert (=> d!271 (= lt!152 e!1608)))

(declare-fun c!1534 () Bool)

(assert (=> d!271 (= c!1534 ((_ is IntegerLiteral!23) (rhs!330 expr!7)))))

(assert (=> d!271 (= (complexity!0 (rhs!330 expr!7)) lt!152)))

(declare-fun bm!2567 () Bool)

(assert (=> bm!2567 (= call!2574 call!2576)))

(declare-fun c!1540 () Bool)

(declare-fun c!1535 () Bool)

(declare-fun bm!2568 () Bool)

(declare-fun c!1532 () Bool)

(declare-fun c!1537 () Bool)

(assert (=> bm!2568 (= call!2570 (complexity!0 (ite c!1532 (rhs!335 (rhs!330 expr!7)) (ite c!1538 (expr!112 (rhs!330 expr!7)) (ite c!1535 (lhs!333 (rhs!330 expr!7)) (ite c!1533 (s!85 (rhs!330 expr!7)) (ite c!1540 (rhs!332 (rhs!330 expr!7)) (ite c!1539 (lhs!330 (rhs!330 expr!7)) (ite c!1536 (rhs!329 (rhs!330 expr!7)) (ite c!1537 (lhs!334 (rhs!330 expr!7)) (lhs!331 (rhs!330 expr!7))))))))))))))

(declare-fun b!3147 () Bool)

(assert (=> b!3147 (= e!1608 e!1605)))

(assert (=> b!3147 (= c!1532 ((_ is Minus!23) (rhs!330 expr!7)))))

(declare-fun b!3148 () Bool)

(assert (=> b!3148 (= e!1606 e!1600)))

(assert (=> b!3148 (= c!1537 ((_ is LessEquals!23) (rhs!330 expr!7)))))

(declare-fun bm!2569 () Bool)

(declare-fun call!2561 () Int)

(assert (=> bm!2569 (= call!2565 call!2561)))

(declare-fun b!3149 () Bool)

(declare-fun c!1541 () Bool)

(assert (=> b!3149 (= c!1541 ((_ is IntPow!23) (rhs!330 expr!7)))))

(declare-fun e!1604 () Int)

(assert (=> b!3149 (= e!1604 e!1599)))

(declare-fun bm!2570 () Bool)

(assert (=> bm!2570 (= call!2564 call!2568)))

(declare-fun b!3150 () Bool)

(assert (=> b!3150 (= e!1607 (+ 1 call!2575))))

(declare-fun bm!2571 () Bool)

(assert (=> bm!2571 (= call!2567 (complexity!0 (ite c!1532 (lhs!335 (rhs!330 expr!7)) (ite c!1535 (rhs!333 (rhs!330 expr!7)) (ite c!1533 (fac1!47 (rhs!330 expr!7)) (ite c!1540 (lhs!332 (rhs!330 expr!7)) (ite c!1541 (base!47 (rhs!330 expr!7)) (ite c!1539 (rhs!330 (rhs!330 expr!7)) (ite c!1536 (lhs!329 (rhs!330 expr!7)) (ite c!1537 (rhs!334 (rhs!330 expr!7)) (rhs!331 (rhs!330 expr!7))))))))))))))

(declare-fun b!3151 () Bool)

(assert (=> b!3151 (= e!1601 e!1604)))

(assert (=> b!3151 (= c!1540 ((_ is Division!23) (rhs!330 expr!7)))))

(declare-fun b!3152 () Bool)

(assert (=> b!3152 (= e!1604 (+ 1 call!2568 call!2561))))

(declare-fun bm!2572 () Bool)

(assert (=> bm!2572 (= call!2561 call!2569)))

(declare-fun bm!2573 () Bool)

(assert (=> bm!2573 (= call!2562 call!2574)))

(declare-fun b!3153 () Bool)

(assert (=> b!3153 (= e!1605 (+ 1 call!2567 call!2570))))

(declare-fun b!3154 () Bool)

(assert (=> b!3154 (= e!1600 (+ 1 call!2571 call!2562))))

(declare-fun b!3155 () Bool)

(assert (=> b!3155 (= e!1607 e!1602)))

(assert (=> b!3155 (= c!1535 ((_ is Times!23) (rhs!330 expr!7)))))

(assert (= (and d!271 c!1534) b!3136))

(assert (= (and d!271 (not c!1534)) b!3147))

(assert (= (and b!3147 c!1532) b!3153))

(assert (= (and b!3147 (not c!1532)) b!3139))

(assert (= (and b!3139 c!1538) b!3150))

(assert (= (and b!3139 (not c!1538)) b!3155))

(assert (= (and b!3155 c!1535) b!3142))

(assert (= (and b!3155 (not c!1535)) b!3141))

(assert (= (and b!3141 c!1533) b!3140))

(assert (= (and b!3141 (not c!1533)) b!3151))

(assert (= (and b!3151 c!1540) b!3152))

(assert (= (and b!3151 (not c!1540)) b!3149))

(assert (= (and b!3149 c!1541) b!3145))

(assert (= (and b!3149 (not c!1541)) b!3137))

(assert (= (and b!3137 c!1539) b!3143))

(assert (= (and b!3137 (not c!1539)) b!3144))

(assert (= (and b!3144 c!1536) b!3138))

(assert (= (and b!3144 (not c!1536)) b!3148))

(assert (= (and b!3148 c!1537) b!3146))

(assert (= (and b!3148 (not c!1537)) b!3154))

(assert (= (or b!3146 b!3154) bm!2573))

(assert (= (or b!3146 b!3154) bm!2558))

(assert (= (or b!3138 bm!2558) bm!2564))

(assert (= (or b!3138 bm!2573) bm!2567))

(assert (= (or b!3143 bm!2564) bm!2569))

(assert (= (or b!3143 bm!2567) bm!2560))

(assert (= (or b!3145 bm!2560) bm!2570))

(assert (= (or b!3152 bm!2570) bm!2563))

(assert (= (or b!3152 bm!2569) bm!2572))

(assert (= (or b!3140 bm!2563) bm!2559))

(assert (= (or b!3140 bm!2572) bm!2561))

(assert (= (or b!3142 bm!2559) bm!2565))

(assert (= (or b!3142 bm!2561) bm!2562))

(assert (= (or b!3150 bm!2562) bm!2566))

(assert (= (or b!3153 bm!2566) bm!2568))

(assert (= (or b!3153 bm!2565) bm!2571))

(declare-fun m!947 () Bool)

(assert (=> b!3140 m!947))

(declare-fun m!949 () Bool)

(assert (=> bm!2568 m!949))

(declare-fun m!951 () Bool)

(assert (=> bm!2571 m!951))

(assert (=> b!3075 d!271))

(check-sat (not bm!2552) (not bm!2555) (not b!3120) (not bm!2571) (not b!3140) (not bm!2568))
(check-sat)
