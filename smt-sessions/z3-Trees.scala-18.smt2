; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!94 () Bool)

(assert start!94)

(declare-fun res!172 () Bool)

(declare-fun e!1329 () Bool)

(assert (=> start!94 (=> (not res!172) (not e!1329))))

(declare-datatypes ((Expr!21 0))(
  ( (FMA!20 (fac1!44 Expr!21) (fac2!44 Expr!21) (s!79 Expr!21)) (IntegerLiteral!20 (value!87 Int)) (GreaterThan!20 (lhs!308 Expr!21) (rhs!308 Expr!21)) (LessThan!20 (lhs!309 Expr!21) (rhs!309 Expr!21)) (GreaterEquals!20 (lhs!310 Expr!21) (rhs!310 Expr!21)) (UMinus!20 (expr!108 Expr!21)) (IntPow!20 (base!44 Expr!21) (exp!44 Int)) (Division!20 (lhs!311 Expr!21) (rhs!311 Expr!21)) (Times!20 (lhs!312 Expr!21) (rhs!312 Expr!21)) (LessEquals!20 (lhs!313 Expr!21) (rhs!313 Expr!21)) (Minus!20 (lhs!314 Expr!21) (rhs!314 Expr!21)) )
))
(declare-fun expr!7 () Expr!21)

(get-info :version)

(assert (=> start!94 (= res!172 (and (not ((_ is IntegerLiteral!20) expr!7)) (not ((_ is Minus!20) expr!7)) (not ((_ is UMinus!20) expr!7)) (not ((_ is Times!20) expr!7)) (not ((_ is FMA!20) expr!7)) (not ((_ is Division!20) expr!7)) ((_ is IntPow!20) expr!7)))))

(assert (=> start!94 e!1329))

(assert (=> start!94 true))

(declare-fun b!2606 () Bool)

(declare-fun complexity!0 (Expr!21) Int)

(assert (=> b!2606 (= e!1329 (<= (+ 1 (complexity!0 (base!44 expr!7))) 0))))

(assert (= (and start!94 res!172) b!2606))

(declare-fun m!793 () Bool)

(assert (=> b!2606 m!793))

(check-sat (not b!2606))
(check-sat)
(get-model)

(declare-fun b!2647 () Bool)

(declare-fun c!1300 () Bool)

(assert (=> b!2647 (= c!1300 ((_ is IntPow!20) (base!44 expr!7)))))

(declare-fun e!1353 () Int)

(declare-fun e!1357 () Int)

(assert (=> b!2647 (= e!1353 e!1357)))

(declare-fun b!2648 () Bool)

(declare-fun e!1359 () Int)

(declare-fun e!1351 () Int)

(assert (=> b!2648 (= e!1359 e!1351)))

(declare-fun c!1294 () Bool)

(assert (=> b!2648 (= c!1294 ((_ is Times!20) (base!44 expr!7)))))

(declare-fun b!2649 () Bool)

(declare-fun e!1355 () Int)

(declare-fun e!1358 () Int)

(assert (=> b!2649 (= e!1355 e!1358)))

(declare-fun c!1295 () Bool)

(assert (=> b!2649 (= c!1295 ((_ is Minus!20) (base!44 expr!7)))))

(declare-fun b!2650 () Bool)

(declare-fun e!1354 () Int)

(declare-fun call!2171 () Int)

(declare-fun call!2168 () Int)

(assert (=> b!2650 (= e!1354 (+ 1 call!2171 call!2168))))

(declare-fun b!2651 () Bool)

(declare-fun e!1352 () Int)

(assert (=> b!2651 (= e!1352 e!1353)))

(declare-fun c!1301 () Bool)

(assert (=> b!2651 (= c!1301 ((_ is Division!20) (base!44 expr!7)))))

(declare-fun bm!2155 () Bool)

(declare-fun call!2161 () Int)

(declare-fun call!2172 () Int)

(assert (=> bm!2155 (= call!2161 call!2172)))

(declare-fun c!1292 () Bool)

(declare-fun call!2159 () Int)

(declare-fun c!1298 () Bool)

(declare-fun c!1296 () Bool)

(declare-fun bm!2156 () Bool)

(declare-fun c!1299 () Bool)

(assert (=> bm!2156 (= call!2159 (complexity!0 (ite c!1296 (s!79 (base!44 expr!7)) (ite c!1301 (lhs!311 (base!44 expr!7)) (ite c!1292 (lhs!309 (base!44 expr!7)) (ite c!1298 (lhs!308 (base!44 expr!7)) (ite c!1299 (rhs!313 (base!44 expr!7)) (rhs!310 (base!44 expr!7)))))))))))

(declare-fun b!2652 () Bool)

(assert (=> b!2652 (= c!1298 ((_ is GreaterThan!20) (base!44 expr!7)))))

(declare-fun e!1356 () Int)

(assert (=> b!2652 (= e!1356 e!1354)))

(declare-fun b!2653 () Bool)

(declare-fun call!2163 () Int)

(assert (=> b!2653 (= e!1353 (+ 1 call!2172 call!2163))))

(declare-fun b!2654 () Bool)

(assert (=> b!2654 (= c!1296 ((_ is FMA!20) (base!44 expr!7)))))

(assert (=> b!2654 (= e!1351 e!1352)))

(declare-fun b!2655 () Bool)

(assert (=> b!2655 (= e!1355 1)))

(declare-fun bm!2157 () Bool)

(declare-fun call!2160 () Int)

(declare-fun call!2158 () Int)

(assert (=> bm!2157 (= call!2160 call!2158)))

(declare-fun bm!2158 () Bool)

(declare-fun call!2157 () Int)

(assert (=> bm!2158 (= call!2157 call!2163)))

(declare-fun b!2656 () Bool)

(declare-fun call!2166 () Int)

(assert (=> b!2656 (= e!1356 (+ 1 call!2161 call!2166))))

(declare-fun b!2657 () Bool)

(declare-fun e!1350 () Int)

(declare-fun call!2170 () Int)

(declare-fun call!2164 () Int)

(assert (=> b!2657 (= e!1350 (+ 1 call!2170 call!2164))))

(declare-fun bm!2159 () Bool)

(declare-fun call!2162 () Int)

(declare-fun call!2169 () Int)

(assert (=> bm!2159 (= call!2162 call!2169)))

(declare-fun bm!2160 () Bool)

(assert (=> bm!2160 (= call!2171 call!2161)))

(declare-fun b!2658 () Bool)

(declare-fun c!1293 () Bool)

(assert (=> b!2658 (= c!1293 ((_ is UMinus!20) (base!44 expr!7)))))

(assert (=> b!2658 (= e!1358 e!1359)))

(declare-fun b!2659 () Bool)

(assert (=> b!2659 (= e!1358 (+ 1 call!2169 call!2158))))

(declare-fun bm!2161 () Bool)

(assert (=> bm!2161 (= call!2164 call!2171)))

(declare-fun bm!2162 () Bool)

(assert (=> bm!2162 (= call!2170 call!2168)))

(declare-fun b!2660 () Bool)

(assert (=> b!2660 (= e!1354 e!1350)))

(assert (=> b!2660 (= c!1299 ((_ is LessEquals!20) (base!44 expr!7)))))

(declare-fun bm!2163 () Bool)

(declare-fun call!2165 () Int)

(declare-fun call!2167 () Int)

(assert (=> bm!2163 (= call!2165 call!2167)))

(declare-fun b!2661 () Bool)

(assert (=> b!2661 (= e!1351 (+ 1 call!2162 call!2167))))

(declare-fun b!2662 () Bool)

(assert (=> b!2662 (= e!1359 (+ 1 call!2160))))

(declare-fun bm!2164 () Bool)

(assert (=> bm!2164 (= call!2172 call!2159)))

(declare-fun b!2663 () Bool)

(assert (=> b!2663 (= e!1357 e!1356)))

(assert (=> b!2663 (= c!1292 ((_ is LessThan!20) (base!44 expr!7)))))

(declare-fun bm!2165 () Bool)

(assert (=> bm!2165 (= call!2163 call!2165)))

(declare-fun bm!2166 () Bool)

(assert (=> bm!2166 (= call!2168 call!2166)))

(declare-fun d!227 () Bool)

(declare-fun lt!128 () Int)

(assert (=> d!227 (> lt!128 0)))

(assert (=> d!227 (= lt!128 e!1355)))

(declare-fun c!1297 () Bool)

(assert (=> d!227 (= c!1297 ((_ is IntegerLiteral!20) (base!44 expr!7)))))

(assert (=> d!227 (= (complexity!0 (base!44 expr!7)) lt!128)))

(declare-fun bm!2154 () Bool)

(assert (=> bm!2154 (= call!2169 (complexity!0 (ite c!1295 (lhs!314 (base!44 expr!7)) (ite c!1294 (lhs!312 (base!44 expr!7)) (fac2!44 (base!44 expr!7))))))))

(declare-fun b!2664 () Bool)

(assert (=> b!2664 (= e!1352 (+ 1 call!2165 call!2162 call!2159))))

(declare-fun bm!2167 () Bool)

(assert (=> bm!2167 (= call!2158 (complexity!0 (ite c!1295 (rhs!314 (base!44 expr!7)) (ite c!1293 (expr!108 (base!44 expr!7)) (ite c!1294 (rhs!312 (base!44 expr!7)) (ite c!1296 (fac1!44 (base!44 expr!7)) (ite c!1301 (rhs!311 (base!44 expr!7)) (ite c!1300 (base!44 (base!44 expr!7)) (ite c!1292 (rhs!309 (base!44 expr!7)) (ite c!1298 (rhs!308 (base!44 expr!7)) (ite c!1299 (lhs!313 (base!44 expr!7)) (lhs!310 (base!44 expr!7)))))))))))))))

(declare-fun b!2665 () Bool)

(assert (=> b!2665 (= e!1350 (+ 1 call!2170 call!2164))))

(declare-fun b!2666 () Bool)

(assert (=> b!2666 (= e!1357 (+ 1 call!2157))))

(declare-fun bm!2168 () Bool)

(assert (=> bm!2168 (= call!2167 call!2160)))

(declare-fun bm!2169 () Bool)

(assert (=> bm!2169 (= call!2166 call!2157)))

(assert (= (and d!227 c!1297) b!2655))

(assert (= (and d!227 (not c!1297)) b!2649))

(assert (= (and b!2649 c!1295) b!2659))

(assert (= (and b!2649 (not c!1295)) b!2658))

(assert (= (and b!2658 c!1293) b!2662))

(assert (= (and b!2658 (not c!1293)) b!2648))

(assert (= (and b!2648 c!1294) b!2661))

(assert (= (and b!2648 (not c!1294)) b!2654))

(assert (= (and b!2654 c!1296) b!2664))

(assert (= (and b!2654 (not c!1296)) b!2651))

(assert (= (and b!2651 c!1301) b!2653))

(assert (= (and b!2651 (not c!1301)) b!2647))

(assert (= (and b!2647 c!1300) b!2666))

(assert (= (and b!2647 (not c!1300)) b!2663))

(assert (= (and b!2663 c!1292) b!2656))

(assert (= (and b!2663 (not c!1292)) b!2652))

(assert (= (and b!2652 c!1298) b!2650))

(assert (= (and b!2652 (not c!1298)) b!2660))

(assert (= (and b!2660 c!1299) b!2657))

(assert (= (and b!2660 (not c!1299)) b!2665))

(assert (= (or b!2657 b!2665) bm!2161))

(assert (= (or b!2657 b!2665) bm!2162))

(assert (= (or b!2650 bm!2162) bm!2166))

(assert (= (or b!2650 bm!2161) bm!2160))

(assert (= (or b!2656 bm!2160) bm!2155))

(assert (= (or b!2656 bm!2166) bm!2169))

(assert (= (or b!2666 bm!2169) bm!2158))

(assert (= (or b!2653 bm!2155) bm!2164))

(assert (= (or b!2653 bm!2158) bm!2165))

(assert (= (or b!2664 bm!2165) bm!2163))

(assert (= (or b!2664 bm!2164) bm!2156))

(assert (= (or b!2661 bm!2163) bm!2168))

(assert (= (or b!2661 b!2664) bm!2159))

(assert (= (or b!2662 bm!2168) bm!2157))

(assert (= (or b!2659 bm!2157) bm!2167))

(assert (= (or b!2659 bm!2159) bm!2154))

(declare-fun m!795 () Bool)

(assert (=> bm!2156 m!795))

(declare-fun m!797 () Bool)

(assert (=> bm!2154 m!797))

(declare-fun m!799 () Bool)

(assert (=> bm!2167 m!799))

(assert (=> b!2606 d!227))

(check-sat (not bm!2154) (not bm!2167) (not bm!2156))
(check-sat)
