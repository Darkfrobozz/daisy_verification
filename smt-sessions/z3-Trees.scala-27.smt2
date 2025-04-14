; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!142 () Bool)

(assert start!142)

(declare-fun res!199 () Bool)

(declare-fun e!2066 () Bool)

(assert (=> start!142 (=> (not res!199) (not e!2066))))

(declare-datatypes ((Expr!30 0))(
  ( (FMA!29 (fac1!53 Expr!30) (fac2!53 Expr!30) (s!97 Expr!30)) (IntegerLiteral!29 (value!105 Int)) (GreaterThan!29 (lhs!371 Expr!30) (rhs!371 Expr!30)) (LessThan!29 (lhs!372 Expr!30) (rhs!372 Expr!30)) (GreaterEquals!29 (lhs!373 Expr!30) (rhs!373 Expr!30)) (UMinus!29 (expr!120 Expr!30)) (IntPow!29 (base!53 Expr!30) (exp!53 Int)) (Division!29 (lhs!374 Expr!30) (rhs!374 Expr!30)) (Times!29 (lhs!375 Expr!30) (rhs!375 Expr!30)) (LessEquals!29 (lhs!376 Expr!30) (rhs!376 Expr!30)) (Minus!29 (lhs!377 Expr!30) (rhs!377 Expr!30)) )
))
(declare-fun expr!7 () Expr!30)

(get-info :version)

(assert (=> start!142 (= res!199 (and (not ((_ is IntegerLiteral!29) expr!7)) (not ((_ is Minus!29) expr!7)) (not ((_ is UMinus!29) expr!7)) (not ((_ is Times!29) expr!7)) (not ((_ is FMA!29) expr!7)) (not ((_ is Division!29) expr!7)) (not ((_ is IntPow!29) expr!7)) (not ((_ is LessThan!29) expr!7)) (not ((_ is GreaterThan!29) expr!7)) ((_ is LessEquals!29) expr!7)))))

(assert (=> start!142 e!2066))

(assert (=> start!142 true))

(declare-fun b!4053 () Bool)

(declare-fun complexity!0 (Expr!30) Int)

(assert (=> b!4053 (= e!2066 (<= (+ 1 (complexity!0 (lhs!376 expr!7)) (complexity!0 (rhs!376 expr!7))) 0))))

(assert (= (and start!142 res!199) b!4053))

(declare-fun m!1241 () Bool)

(assert (=> b!4053 m!1241))

(declare-fun m!1243 () Bool)

(assert (=> b!4053 m!1243))

(check-sat (not b!4053))
(check-sat)
(get-model)

(declare-fun call!3356 () Int)

(declare-fun call!3359 () Int)

(declare-fun call!3355 () Int)

(declare-fun e!2089 () Int)

(declare-fun b!4094 () Bool)

(assert (=> b!4094 (= e!2089 (+ 1 call!3356 call!3355 call!3359))))

(declare-fun bm!3350 () Bool)

(declare-fun call!3361 () Int)

(declare-fun call!3363 () Int)

(assert (=> bm!3350 (= call!3361 call!3363)))

(declare-fun bm!3351 () Bool)

(declare-fun call!3368 () Int)

(declare-fun c!2004 () Bool)

(declare-fun c!2010 () Bool)

(assert (=> bm!3351 (= call!3368 (complexity!0 (ite c!2004 (rhs!377 (lhs!376 expr!7)) (ite c!2010 (lhs!375 (lhs!376 expr!7)) (fac2!53 (lhs!376 expr!7))))))))

(declare-fun bm!3352 () Bool)

(declare-fun call!3354 () Int)

(assert (=> bm!3352 (= call!3359 call!3354)))

(declare-fun b!4096 () Bool)

(declare-fun e!2096 () Int)

(declare-fun call!3357 () Int)

(declare-fun call!3358 () Int)

(assert (=> b!4096 (= e!2096 (+ 1 call!3357 call!3358))))

(declare-fun bm!3353 () Bool)

(declare-fun call!3362 () Int)

(declare-fun call!3360 () Int)

(assert (=> bm!3353 (= call!3362 call!3360)))

(declare-fun b!4097 () Bool)

(declare-fun e!2090 () Int)

(assert (=> b!4097 (= e!2090 1)))

(declare-fun b!4098 () Bool)

(declare-fun c!2007 () Bool)

(assert (=> b!4098 (= c!2007 ((_ is UMinus!29) (lhs!376 expr!7)))))

(declare-fun e!2092 () Int)

(declare-fun e!2091 () Int)

(assert (=> b!4098 (= e!2092 e!2091)))

(declare-fun b!4099 () Bool)

(declare-fun e!2088 () Int)

(declare-fun e!2087 () Int)

(assert (=> b!4099 (= e!2088 e!2087)))

(declare-fun c!2005 () Bool)

(assert (=> b!4099 (= c!2005 ((_ is LessThan!29) (lhs!376 expr!7)))))

(declare-fun b!4100 () Bool)

(declare-fun e!2095 () Int)

(declare-fun call!3364 () Int)

(declare-fun call!3367 () Int)

(assert (=> b!4100 (= e!2095 (+ 1 call!3364 call!3367))))

(declare-fun b!4101 () Bool)

(declare-fun call!3353 () Int)

(assert (=> b!4101 (= e!2091 (+ 1 call!3353))))

(declare-fun bm!3354 () Bool)

(assert (=> bm!3354 (= call!3363 call!3367)))

(declare-fun bm!3355 () Bool)

(declare-fun c!2006 () Bool)

(declare-fun c!2008 () Bool)

(declare-fun c!2002 () Bool)

(declare-fun c!2003 () Bool)

(declare-fun call!3365 () Int)

(declare-fun c!2009 () Bool)

(assert (=> bm!3355 (= call!3365 (complexity!0 (ite c!2004 (lhs!377 (lhs!376 expr!7)) (ite c!2007 (expr!120 (lhs!376 expr!7)) (ite c!2010 (rhs!375 (lhs!376 expr!7)) (ite c!2002 (s!97 (lhs!376 expr!7)) (ite c!2006 (lhs!374 (lhs!376 expr!7)) (ite c!2003 (base!53 (lhs!376 expr!7)) (ite c!2005 (lhs!372 (lhs!376 expr!7)) (ite c!2008 (lhs!371 (lhs!376 expr!7)) (ite c!2009 (rhs!376 (lhs!376 expr!7)) (rhs!373 (lhs!376 expr!7)))))))))))))))

(declare-fun b!4102 () Bool)

(assert (=> b!4102 (= e!2096 (+ 1 call!3357 call!3358))))

(declare-fun bm!3356 () Bool)

(declare-fun call!3366 () Int)

(assert (=> bm!3356 (= call!3366 call!3364)))

(declare-fun bm!3357 () Bool)

(assert (=> bm!3357 (= call!3355 call!3368)))

(declare-fun b!4103 () Bool)

(assert (=> b!4103 (= c!2002 ((_ is FMA!29) (lhs!376 expr!7)))))

(declare-fun e!2094 () Int)

(assert (=> b!4103 (= e!2094 e!2089)))

(declare-fun b!4104 () Bool)

(declare-fun e!2093 () Int)

(assert (=> b!4104 (= e!2093 e!2096)))

(assert (=> b!4104 (= c!2009 ((_ is LessEquals!29) (lhs!376 expr!7)))))

(declare-fun bm!3358 () Bool)

(assert (=> bm!3358 (= call!3360 call!3366)))

(declare-fun bm!3359 () Bool)

(assert (=> bm!3359 (= call!3358 call!3362)))

(declare-fun b!4105 () Bool)

(assert (=> b!4105 (= e!2090 e!2092)))

(assert (=> b!4105 (= c!2004 ((_ is Minus!29) (lhs!376 expr!7)))))

(declare-fun bm!3360 () Bool)

(assert (=> bm!3360 (= call!3367 call!3356)))

(declare-fun b!4106 () Bool)

(assert (=> b!4106 (= e!2092 (+ 1 call!3365 call!3368))))

(declare-fun b!4107 () Bool)

(assert (=> b!4107 (= e!2087 (+ 1 call!3360 call!3363))))

(declare-fun b!4108 () Bool)

(assert (=> b!4108 (= e!2091 e!2094)))

(assert (=> b!4108 (= c!2010 ((_ is Times!29) (lhs!376 expr!7)))))

(declare-fun d!357 () Bool)

(declare-fun lt!199 () Int)

(assert (=> d!357 (> lt!199 0)))

(assert (=> d!357 (= lt!199 e!2090)))

(declare-fun c!2011 () Bool)

(assert (=> d!357 (= c!2011 ((_ is IntegerLiteral!29) (lhs!376 expr!7)))))

(assert (=> d!357 (= (complexity!0 (lhs!376 expr!7)) lt!199)))

(declare-fun b!4095 () Bool)

(assert (=> b!4095 (= e!2094 (+ 1 call!3355 call!3354))))

(declare-fun b!4109 () Bool)

(assert (=> b!4109 (= c!2003 ((_ is IntPow!29) (lhs!376 expr!7)))))

(assert (=> b!4109 (= e!2095 e!2088)))

(declare-fun bm!3361 () Bool)

(assert (=> bm!3361 (= call!3354 call!3353)))

(declare-fun b!4110 () Bool)

(assert (=> b!4110 (= e!2088 (+ 1 call!3366))))

(declare-fun bm!3362 () Bool)

(assert (=> bm!3362 (= call!3353 call!3365)))

(declare-fun bm!3363 () Bool)

(assert (=> bm!3363 (= call!3356 (complexity!0 (ite c!2002 (fac1!53 (lhs!376 expr!7)) (ite c!2006 (rhs!374 (lhs!376 expr!7)) (ite c!2005 (rhs!372 (lhs!376 expr!7)) (ite c!2008 (rhs!371 (lhs!376 expr!7)) (ite c!2009 (lhs!376 (lhs!376 expr!7)) (lhs!373 (lhs!376 expr!7)))))))))))

(declare-fun b!4111 () Bool)

(assert (=> b!4111 (= e!2089 e!2095)))

(assert (=> b!4111 (= c!2006 ((_ is Division!29) (lhs!376 expr!7)))))

(declare-fun b!4112 () Bool)

(assert (=> b!4112 (= e!2093 (+ 1 call!3362 call!3361))))

(declare-fun bm!3364 () Bool)

(assert (=> bm!3364 (= call!3364 call!3359)))

(declare-fun bm!3365 () Bool)

(assert (=> bm!3365 (= call!3357 call!3361)))

(declare-fun b!4113 () Bool)

(assert (=> b!4113 (= c!2008 ((_ is GreaterThan!29) (lhs!376 expr!7)))))

(assert (=> b!4113 (= e!2087 e!2093)))

(assert (= (and d!357 c!2011) b!4097))

(assert (= (and d!357 (not c!2011)) b!4105))

(assert (= (and b!4105 c!2004) b!4106))

(assert (= (and b!4105 (not c!2004)) b!4098))

(assert (= (and b!4098 c!2007) b!4101))

(assert (= (and b!4098 (not c!2007)) b!4108))

(assert (= (and b!4108 c!2010) b!4095))

(assert (= (and b!4108 (not c!2010)) b!4103))

(assert (= (and b!4103 c!2002) b!4094))

(assert (= (and b!4103 (not c!2002)) b!4111))

(assert (= (and b!4111 c!2006) b!4100))

(assert (= (and b!4111 (not c!2006)) b!4109))

(assert (= (and b!4109 c!2003) b!4110))

(assert (= (and b!4109 (not c!2003)) b!4099))

(assert (= (and b!4099 c!2005) b!4107))

(assert (= (and b!4099 (not c!2005)) b!4113))

(assert (= (and b!4113 c!2008) b!4112))

(assert (= (and b!4113 (not c!2008)) b!4104))

(assert (= (and b!4104 c!2009) b!4096))

(assert (= (and b!4104 (not c!2009)) b!4102))

(assert (= (or b!4096 b!4102) bm!3359))

(assert (= (or b!4096 b!4102) bm!3365))

(assert (= (or b!4112 bm!3365) bm!3350))

(assert (= (or b!4112 bm!3359) bm!3353))

(assert (= (or b!4107 bm!3353) bm!3358))

(assert (= (or b!4107 bm!3350) bm!3354))

(assert (= (or b!4110 bm!3358) bm!3356))

(assert (= (or b!4100 bm!3356) bm!3364))

(assert (= (or b!4100 bm!3354) bm!3360))

(assert (= (or b!4094 bm!3360) bm!3363))

(assert (= (or b!4094 bm!3364) bm!3352))

(assert (= (or b!4095 bm!3352) bm!3361))

(assert (= (or b!4095 b!4094) bm!3357))

(assert (= (or b!4101 bm!3361) bm!3362))

(assert (= (or b!4106 bm!3357) bm!3351))

(assert (= (or b!4106 bm!3362) bm!3355))

(declare-fun m!1245 () Bool)

(assert (=> bm!3351 m!1245))

(declare-fun m!1247 () Bool)

(assert (=> bm!3355 m!1247))

(declare-fun m!1249 () Bool)

(assert (=> bm!3363 m!1249))

(assert (=> b!4053 d!357))

(declare-fun call!3372 () Int)

(declare-fun e!2099 () Int)

(declare-fun b!4114 () Bool)

(declare-fun call!3375 () Int)

(declare-fun call!3371 () Int)

(assert (=> b!4114 (= e!2099 (+ 1 call!3372 call!3371 call!3375))))

(declare-fun bm!3366 () Bool)

(declare-fun call!3377 () Int)

(declare-fun call!3379 () Int)

(assert (=> bm!3366 (= call!3377 call!3379)))

(declare-fun c!2020 () Bool)

(declare-fun bm!3367 () Bool)

(declare-fun c!2014 () Bool)

(declare-fun call!3384 () Int)

(assert (=> bm!3367 (= call!3384 (complexity!0 (ite c!2014 (rhs!377 (rhs!376 expr!7)) (ite c!2020 (lhs!375 (rhs!376 expr!7)) (fac2!53 (rhs!376 expr!7))))))))

(declare-fun bm!3368 () Bool)

(declare-fun call!3370 () Int)

(assert (=> bm!3368 (= call!3375 call!3370)))

(declare-fun b!4116 () Bool)

(declare-fun e!2106 () Int)

(declare-fun call!3373 () Int)

(declare-fun call!3374 () Int)

(assert (=> b!4116 (= e!2106 (+ 1 call!3373 call!3374))))

(declare-fun bm!3369 () Bool)

(declare-fun call!3378 () Int)

(declare-fun call!3376 () Int)

(assert (=> bm!3369 (= call!3378 call!3376)))

(declare-fun b!4117 () Bool)

(declare-fun e!2100 () Int)

(assert (=> b!4117 (= e!2100 1)))

(declare-fun b!4118 () Bool)

(declare-fun c!2017 () Bool)

(assert (=> b!4118 (= c!2017 ((_ is UMinus!29) (rhs!376 expr!7)))))

(declare-fun e!2102 () Int)

(declare-fun e!2101 () Int)

(assert (=> b!4118 (= e!2102 e!2101)))

(declare-fun b!4119 () Bool)

(declare-fun e!2098 () Int)

(declare-fun e!2097 () Int)

(assert (=> b!4119 (= e!2098 e!2097)))

(declare-fun c!2015 () Bool)

(assert (=> b!4119 (= c!2015 ((_ is LessThan!29) (rhs!376 expr!7)))))

(declare-fun b!4120 () Bool)

(declare-fun e!2105 () Int)

(declare-fun call!3380 () Int)

(declare-fun call!3383 () Int)

(assert (=> b!4120 (= e!2105 (+ 1 call!3380 call!3383))))

(declare-fun b!4121 () Bool)

(declare-fun call!3369 () Int)

(assert (=> b!4121 (= e!2101 (+ 1 call!3369))))

(declare-fun bm!3370 () Bool)

(assert (=> bm!3370 (= call!3379 call!3383)))

(declare-fun c!2019 () Bool)

(declare-fun c!2012 () Bool)

(declare-fun c!2018 () Bool)

(declare-fun bm!3371 () Bool)

(declare-fun c!2013 () Bool)

(declare-fun call!3381 () Int)

(declare-fun c!2016 () Bool)

(assert (=> bm!3371 (= call!3381 (complexity!0 (ite c!2014 (lhs!377 (rhs!376 expr!7)) (ite c!2017 (expr!120 (rhs!376 expr!7)) (ite c!2020 (rhs!375 (rhs!376 expr!7)) (ite c!2012 (s!97 (rhs!376 expr!7)) (ite c!2016 (lhs!374 (rhs!376 expr!7)) (ite c!2013 (base!53 (rhs!376 expr!7)) (ite c!2015 (lhs!372 (rhs!376 expr!7)) (ite c!2018 (lhs!371 (rhs!376 expr!7)) (ite c!2019 (rhs!376 (rhs!376 expr!7)) (rhs!373 (rhs!376 expr!7)))))))))))))))

(declare-fun b!4122 () Bool)

(assert (=> b!4122 (= e!2106 (+ 1 call!3373 call!3374))))

(declare-fun bm!3372 () Bool)

(declare-fun call!3382 () Int)

(assert (=> bm!3372 (= call!3382 call!3380)))

(declare-fun bm!3373 () Bool)

(assert (=> bm!3373 (= call!3371 call!3384)))

(declare-fun b!4123 () Bool)

(assert (=> b!4123 (= c!2012 ((_ is FMA!29) (rhs!376 expr!7)))))

(declare-fun e!2104 () Int)

(assert (=> b!4123 (= e!2104 e!2099)))

(declare-fun b!4124 () Bool)

(declare-fun e!2103 () Int)

(assert (=> b!4124 (= e!2103 e!2106)))

(assert (=> b!4124 (= c!2019 ((_ is LessEquals!29) (rhs!376 expr!7)))))

(declare-fun bm!3374 () Bool)

(assert (=> bm!3374 (= call!3376 call!3382)))

(declare-fun bm!3375 () Bool)

(assert (=> bm!3375 (= call!3374 call!3378)))

(declare-fun b!4125 () Bool)

(assert (=> b!4125 (= e!2100 e!2102)))

(assert (=> b!4125 (= c!2014 ((_ is Minus!29) (rhs!376 expr!7)))))

(declare-fun bm!3376 () Bool)

(assert (=> bm!3376 (= call!3383 call!3372)))

(declare-fun b!4126 () Bool)

(assert (=> b!4126 (= e!2102 (+ 1 call!3381 call!3384))))

(declare-fun b!4127 () Bool)

(assert (=> b!4127 (= e!2097 (+ 1 call!3376 call!3379))))

(declare-fun b!4128 () Bool)

(assert (=> b!4128 (= e!2101 e!2104)))

(assert (=> b!4128 (= c!2020 ((_ is Times!29) (rhs!376 expr!7)))))

(declare-fun d!359 () Bool)

(declare-fun lt!200 () Int)

(assert (=> d!359 (> lt!200 0)))

(assert (=> d!359 (= lt!200 e!2100)))

(declare-fun c!2021 () Bool)

(assert (=> d!359 (= c!2021 ((_ is IntegerLiteral!29) (rhs!376 expr!7)))))

(assert (=> d!359 (= (complexity!0 (rhs!376 expr!7)) lt!200)))

(declare-fun b!4115 () Bool)

(assert (=> b!4115 (= e!2104 (+ 1 call!3371 call!3370))))

(declare-fun b!4129 () Bool)

(assert (=> b!4129 (= c!2013 ((_ is IntPow!29) (rhs!376 expr!7)))))

(assert (=> b!4129 (= e!2105 e!2098)))

(declare-fun bm!3377 () Bool)

(assert (=> bm!3377 (= call!3370 call!3369)))

(declare-fun b!4130 () Bool)

(assert (=> b!4130 (= e!2098 (+ 1 call!3382))))

(declare-fun bm!3378 () Bool)

(assert (=> bm!3378 (= call!3369 call!3381)))

(declare-fun bm!3379 () Bool)

(assert (=> bm!3379 (= call!3372 (complexity!0 (ite c!2012 (fac1!53 (rhs!376 expr!7)) (ite c!2016 (rhs!374 (rhs!376 expr!7)) (ite c!2015 (rhs!372 (rhs!376 expr!7)) (ite c!2018 (rhs!371 (rhs!376 expr!7)) (ite c!2019 (lhs!376 (rhs!376 expr!7)) (lhs!373 (rhs!376 expr!7)))))))))))

(declare-fun b!4131 () Bool)

(assert (=> b!4131 (= e!2099 e!2105)))

(assert (=> b!4131 (= c!2016 ((_ is Division!29) (rhs!376 expr!7)))))

(declare-fun b!4132 () Bool)

(assert (=> b!4132 (= e!2103 (+ 1 call!3378 call!3377))))

(declare-fun bm!3380 () Bool)

(assert (=> bm!3380 (= call!3380 call!3375)))

(declare-fun bm!3381 () Bool)

(assert (=> bm!3381 (= call!3373 call!3377)))

(declare-fun b!4133 () Bool)

(assert (=> b!4133 (= c!2018 ((_ is GreaterThan!29) (rhs!376 expr!7)))))

(assert (=> b!4133 (= e!2097 e!2103)))

(assert (= (and d!359 c!2021) b!4117))

(assert (= (and d!359 (not c!2021)) b!4125))

(assert (= (and b!4125 c!2014) b!4126))

(assert (= (and b!4125 (not c!2014)) b!4118))

(assert (= (and b!4118 c!2017) b!4121))

(assert (= (and b!4118 (not c!2017)) b!4128))

(assert (= (and b!4128 c!2020) b!4115))

(assert (= (and b!4128 (not c!2020)) b!4123))

(assert (= (and b!4123 c!2012) b!4114))

(assert (= (and b!4123 (not c!2012)) b!4131))

(assert (= (and b!4131 c!2016) b!4120))

(assert (= (and b!4131 (not c!2016)) b!4129))

(assert (= (and b!4129 c!2013) b!4130))

(assert (= (and b!4129 (not c!2013)) b!4119))

(assert (= (and b!4119 c!2015) b!4127))

(assert (= (and b!4119 (not c!2015)) b!4133))

(assert (= (and b!4133 c!2018) b!4132))

(assert (= (and b!4133 (not c!2018)) b!4124))

(assert (= (and b!4124 c!2019) b!4116))

(assert (= (and b!4124 (not c!2019)) b!4122))

(assert (= (or b!4116 b!4122) bm!3375))

(assert (= (or b!4116 b!4122) bm!3381))

(assert (= (or b!4132 bm!3381) bm!3366))

(assert (= (or b!4132 bm!3375) bm!3369))

(assert (= (or b!4127 bm!3369) bm!3374))

(assert (= (or b!4127 bm!3366) bm!3370))

(assert (= (or b!4130 bm!3374) bm!3372))

(assert (= (or b!4120 bm!3372) bm!3380))

(assert (= (or b!4120 bm!3370) bm!3376))

(assert (= (or b!4114 bm!3376) bm!3379))

(assert (= (or b!4114 bm!3380) bm!3368))

(assert (= (or b!4115 bm!3368) bm!3377))

(assert (= (or b!4115 b!4114) bm!3373))

(assert (= (or b!4121 bm!3377) bm!3378))

(assert (= (or b!4126 bm!3373) bm!3367))

(assert (= (or b!4126 bm!3378) bm!3371))

(declare-fun m!1251 () Bool)

(assert (=> bm!3367 m!1251))

(declare-fun m!1253 () Bool)

(assert (=> bm!3371 m!1253))

(declare-fun m!1255 () Bool)

(assert (=> bm!3379 m!1255))

(assert (=> b!4053 d!359))

(check-sat (not bm!3367) (not bm!3379) (not bm!3351) (not bm!3355) (not bm!3371) (not bm!3363))
(check-sat)
