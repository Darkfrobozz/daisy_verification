; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!46 () Bool)

(assert start!46)

(declare-fun res!145 () Bool)

(declare-fun e!582 () Bool)

(assert (=> start!46 (=> (not res!145) (not e!582))))

(declare-datatypes ((Expr!12 0))(
  ( (FMA!11 (fac1!35 Expr!12) (fac2!35 Expr!12) (s!61 Expr!12)) (IntegerLiteral!11 (value!69 Int)) (GreaterThan!11 (lhs!245 Expr!12) (rhs!245 Expr!12)) (LessThan!11 (lhs!246 Expr!12) (rhs!246 Expr!12)) (GreaterEquals!11 (lhs!247 Expr!12) (rhs!247 Expr!12)) (UMinus!11 (expr!96 Expr!12)) (IntPow!11 (base!35 Expr!12) (exp!35 Int)) (Division!11 (lhs!248 Expr!12) (rhs!248 Expr!12)) (Times!11 (lhs!249 Expr!12) (rhs!249 Expr!12)) (LessEquals!11 (lhs!250 Expr!12) (rhs!250 Expr!12)) (Minus!11 (lhs!251 Expr!12) (rhs!251 Expr!12)) )
))
(declare-fun expr!7 () Expr!12)

(get-info :version)

(assert (=> start!46 (= res!145 (and (not ((_ is IntegerLiteral!11) expr!7)) (not ((_ is Minus!11) expr!7)) (not ((_ is UMinus!11) expr!7)) ((_ is Times!11) expr!7)))))

(assert (=> start!46 e!582))

(assert (=> start!46 true))

(declare-fun b!1139 () Bool)

(declare-fun complexity!0 (Expr!12) Int)

(assert (=> b!1139 (= e!582 (<= (+ 1 (complexity!0 (lhs!249 expr!7)) (complexity!0 (rhs!249 expr!7))) 0))))

(assert (= (and start!46 res!145) b!1139))

(declare-fun m!339 () Bool)

(assert (=> b!1139 m!339))

(declare-fun m!341 () Bool)

(assert (=> b!1139 m!341))

(check-sat (not b!1139))
(check-sat)
(get-model)

(declare-fun b!1181 () Bool)

(declare-fun e!609 () Int)

(declare-fun call!957 () Int)

(declare-fun call!958 () Int)

(assert (=> b!1181 (= e!609 (+ 1 call!957 call!958))))

(declare-fun bm!943 () Bool)

(declare-fun call!952 () Int)

(declare-fun call!961 () Int)

(assert (=> bm!943 (= call!952 call!961)))

(declare-fun b!1182 () Bool)

(assert (=> b!1182 (= e!609 (+ 1 call!957 call!958))))

(declare-fun bm!944 () Bool)

(declare-fun call!948 () Int)

(assert (=> bm!944 (= call!958 call!948)))

(declare-fun b!1183 () Bool)

(declare-fun e!612 () Int)

(declare-fun call!949 () Int)

(declare-fun call!956 () Int)

(assert (=> b!1183 (= e!612 (+ 1 call!949 call!956))))

(declare-fun b!1184 () Bool)

(declare-fun e!608 () Int)

(declare-fun call!955 () Int)

(declare-fun call!951 () Int)

(assert (=> b!1184 (= e!608 (+ 1 call!955 call!951))))

(declare-fun b!1180 () Bool)

(declare-fun e!605 () Int)

(declare-fun call!954 () Int)

(assert (=> b!1180 (= e!605 (+ 1 call!954))))

(declare-fun d!95 () Bool)

(declare-fun lt!56 () Int)

(assert (=> d!95 (> lt!56 0)))

(declare-fun e!611 () Int)

(assert (=> d!95 (= lt!56 e!611)))

(declare-fun c!577 () Bool)

(assert (=> d!95 (= c!577 ((_ is IntegerLiteral!11) (lhs!249 expr!7)))))

(assert (=> d!95 (= (complexity!0 (lhs!249 expr!7)) lt!56)))

(declare-fun c!580 () Bool)

(declare-fun c!578 () Bool)

(declare-fun c!575 () Bool)

(declare-fun c!574 () Bool)

(declare-fun c!573 () Bool)

(declare-fun c!572 () Bool)

(declare-fun bm!945 () Bool)

(declare-fun c!579 () Bool)

(declare-fun c!581 () Bool)

(assert (=> bm!945 (= call!955 (complexity!0 (ite c!579 (lhs!251 (lhs!249 expr!7)) (ite c!574 (expr!96 (lhs!249 expr!7)) (ite c!575 (lhs!249 (lhs!249 expr!7)) (ite c!578 (s!61 (lhs!249 expr!7)) (ite c!581 (lhs!248 (lhs!249 expr!7)) (ite c!580 (rhs!246 (lhs!249 expr!7)) (ite c!572 (lhs!245 (lhs!249 expr!7)) (ite c!573 (rhs!250 (lhs!249 expr!7)) (rhs!247 (lhs!249 expr!7))))))))))))))

(declare-fun bm!946 () Bool)

(declare-fun call!960 () Int)

(assert (=> bm!946 (= call!960 call!954)))

(declare-fun call!946 () Int)

(declare-fun e!610 () Int)

(declare-fun b!1185 () Bool)

(assert (=> b!1185 (= e!610 (+ 1 call!961 call!951 call!946))))

(declare-fun bm!947 () Bool)

(assert (=> bm!947 (= call!946 call!960)))

(declare-fun bm!948 () Bool)

(declare-fun call!947 () Int)

(assert (=> bm!948 (= call!947 call!946)))

(declare-fun b!1186 () Bool)

(declare-fun e!604 () Int)

(assert (=> b!1186 (= e!604 e!609)))

(assert (=> b!1186 (= c!573 ((_ is LessEquals!11) (lhs!249 expr!7)))))

(declare-fun b!1187 () Bool)

(assert (=> b!1187 (= c!574 ((_ is UMinus!11) (lhs!249 expr!7)))))

(assert (=> b!1187 (= e!608 e!605)))

(declare-fun bm!949 () Bool)

(assert (=> bm!949 (= call!948 call!956)))

(declare-fun b!1188 () Bool)

(declare-fun call!950 () Int)

(assert (=> b!1188 (= e!604 (+ 1 call!948 call!950))))

(declare-fun b!1189 () Bool)

(assert (=> b!1189 (= e!611 e!608)))

(assert (=> b!1189 (= c!579 ((_ is Minus!11) (lhs!249 expr!7)))))

(declare-fun bm!950 () Bool)

(assert (=> bm!950 (= call!956 call!947)))

(declare-fun bm!951 () Bool)

(assert (=> bm!951 (= call!950 call!949)))

(declare-fun bm!952 () Bool)

(assert (=> bm!952 (= call!954 call!955)))

(declare-fun b!1190 () Bool)

(declare-fun e!606 () Int)

(assert (=> b!1190 (= e!610 e!606)))

(assert (=> b!1190 (= c!581 ((_ is Division!11) (lhs!249 expr!7)))))

(declare-fun bm!953 () Bool)

(assert (=> bm!953 (= call!957 call!950)))

(declare-fun b!1191 () Bool)

(declare-fun e!603 () Int)

(declare-fun call!959 () Int)

(assert (=> b!1191 (= e!603 (+ 1 call!960 call!959))))

(declare-fun b!1192 () Bool)

(assert (=> b!1192 (= e!611 1)))

(declare-fun b!1193 () Bool)

(declare-fun c!576 () Bool)

(assert (=> b!1193 (= c!576 ((_ is IntPow!11) (lhs!249 expr!7)))))

(declare-fun e!607 () Int)

(assert (=> b!1193 (= e!606 e!607)))

(declare-fun bm!954 () Bool)

(assert (=> bm!954 (= call!961 call!959)))

(declare-fun b!1194 () Bool)

(assert (=> b!1194 (= c!578 ((_ is FMA!11) (lhs!249 expr!7)))))

(assert (=> b!1194 (= e!603 e!610)))

(declare-fun b!1195 () Bool)

(assert (=> b!1195 (= e!607 e!612)))

(assert (=> b!1195 (= c!580 ((_ is LessThan!11) (lhs!249 expr!7)))))

(declare-fun b!1196 () Bool)

(assert (=> b!1196 (= e!606 (+ 1 call!947 call!952))))

(declare-fun bm!955 () Bool)

(assert (=> bm!955 (= call!959 (complexity!0 (ite c!575 (rhs!249 (lhs!249 expr!7)) (ite c!578 (fac1!35 (lhs!249 expr!7)) (ite c!581 (rhs!248 (lhs!249 expr!7)) (ite c!576 (base!35 (lhs!249 expr!7)) (ite c!580 (lhs!246 (lhs!249 expr!7)) (ite c!572 (rhs!245 (lhs!249 expr!7)) (ite c!573 (lhs!250 (lhs!249 expr!7)) (lhs!247 (lhs!249 expr!7)))))))))))))

(declare-fun bm!956 () Bool)

(declare-fun call!953 () Int)

(assert (=> bm!956 (= call!953 call!952)))

(declare-fun b!1197 () Bool)

(assert (=> b!1197 (= e!605 e!603)))

(assert (=> b!1197 (= c!575 ((_ is Times!11) (lhs!249 expr!7)))))

(declare-fun bm!957 () Bool)

(assert (=> bm!957 (= call!951 (complexity!0 (ite c!579 (rhs!251 (lhs!249 expr!7)) (fac2!35 (lhs!249 expr!7)))))))

(declare-fun b!1198 () Bool)

(assert (=> b!1198 (= e!607 (+ 1 call!953))))

(declare-fun bm!958 () Bool)

(assert (=> bm!958 (= call!949 call!953)))

(declare-fun b!1199 () Bool)

(assert (=> b!1199 (= c!572 ((_ is GreaterThan!11) (lhs!249 expr!7)))))

(assert (=> b!1199 (= e!612 e!604)))

(assert (= (and d!95 c!577) b!1192))

(assert (= (and d!95 (not c!577)) b!1189))

(assert (= (and b!1189 c!579) b!1184))

(assert (= (and b!1189 (not c!579)) b!1187))

(assert (= (and b!1187 c!574) b!1180))

(assert (= (and b!1187 (not c!574)) b!1197))

(assert (= (and b!1197 c!575) b!1191))

(assert (= (and b!1197 (not c!575)) b!1194))

(assert (= (and b!1194 c!578) b!1185))

(assert (= (and b!1194 (not c!578)) b!1190))

(assert (= (and b!1190 c!581) b!1196))

(assert (= (and b!1190 (not c!581)) b!1193))

(assert (= (and b!1193 c!576) b!1198))

(assert (= (and b!1193 (not c!576)) b!1195))

(assert (= (and b!1195 c!580) b!1183))

(assert (= (and b!1195 (not c!580)) b!1199))

(assert (= (and b!1199 c!572) b!1188))

(assert (= (and b!1199 (not c!572)) b!1186))

(assert (= (and b!1186 c!573) b!1181))

(assert (= (and b!1186 (not c!573)) b!1182))

(assert (= (or b!1181 b!1182) bm!944))

(assert (= (or b!1181 b!1182) bm!953))

(assert (= (or b!1188 bm!953) bm!951))

(assert (= (or b!1188 bm!944) bm!949))

(assert (= (or b!1183 bm!951) bm!958))

(assert (= (or b!1183 bm!949) bm!950))

(assert (= (or b!1198 bm!958) bm!956))

(assert (= (or b!1196 bm!950) bm!948))

(assert (= (or b!1196 bm!956) bm!943))

(assert (= (or b!1185 bm!943) bm!954))

(assert (= (or b!1185 bm!948) bm!947))

(assert (= (or b!1191 bm!954) bm!955))

(assert (= (or b!1191 bm!947) bm!946))

(assert (= (or b!1180 bm!946) bm!952))

(assert (= (or b!1184 b!1185) bm!957))

(assert (= (or b!1184 bm!952) bm!945))

(declare-fun m!343 () Bool)

(assert (=> bm!945 m!343))

(declare-fun m!345 () Bool)

(assert (=> bm!955 m!345))

(declare-fun m!347 () Bool)

(assert (=> bm!957 m!347))

(assert (=> b!1139 d!95))

(declare-fun b!1201 () Bool)

(declare-fun e!619 () Int)

(declare-fun call!973 () Int)

(declare-fun call!974 () Int)

(assert (=> b!1201 (= e!619 (+ 1 call!973 call!974))))

(declare-fun bm!959 () Bool)

(declare-fun call!968 () Int)

(declare-fun call!977 () Int)

(assert (=> bm!959 (= call!968 call!977)))

(declare-fun b!1202 () Bool)

(assert (=> b!1202 (= e!619 (+ 1 call!973 call!974))))

(declare-fun bm!960 () Bool)

(declare-fun call!964 () Int)

(assert (=> bm!960 (= call!974 call!964)))

(declare-fun b!1203 () Bool)

(declare-fun e!622 () Int)

(declare-fun call!965 () Int)

(declare-fun call!972 () Int)

(assert (=> b!1203 (= e!622 (+ 1 call!965 call!972))))

(declare-fun b!1204 () Bool)

(declare-fun e!618 () Int)

(declare-fun call!971 () Int)

(declare-fun call!967 () Int)

(assert (=> b!1204 (= e!618 (+ 1 call!971 call!967))))

(declare-fun b!1200 () Bool)

(declare-fun e!615 () Int)

(declare-fun call!970 () Int)

(assert (=> b!1200 (= e!615 (+ 1 call!970))))

(declare-fun d!97 () Bool)

(declare-fun lt!57 () Int)

(assert (=> d!97 (> lt!57 0)))

(declare-fun e!621 () Int)

(assert (=> d!97 (= lt!57 e!621)))

(declare-fun c!587 () Bool)

(assert (=> d!97 (= c!587 ((_ is IntegerLiteral!11) (rhs!249 expr!7)))))

(assert (=> d!97 (= (complexity!0 (rhs!249 expr!7)) lt!57)))

(declare-fun c!585 () Bool)

(declare-fun c!589 () Bool)

(declare-fun c!590 () Bool)

(declare-fun c!591 () Bool)

(declare-fun c!582 () Bool)

(declare-fun c!584 () Bool)

(declare-fun c!583 () Bool)

(declare-fun bm!961 () Bool)

(declare-fun c!588 () Bool)

(assert (=> bm!961 (= call!971 (complexity!0 (ite c!589 (lhs!251 (rhs!249 expr!7)) (ite c!584 (expr!96 (rhs!249 expr!7)) (ite c!585 (lhs!249 (rhs!249 expr!7)) (ite c!588 (s!61 (rhs!249 expr!7)) (ite c!591 (lhs!248 (rhs!249 expr!7)) (ite c!590 (rhs!246 (rhs!249 expr!7)) (ite c!582 (lhs!245 (rhs!249 expr!7)) (ite c!583 (rhs!250 (rhs!249 expr!7)) (rhs!247 (rhs!249 expr!7))))))))))))))

(declare-fun bm!962 () Bool)

(declare-fun call!976 () Int)

(assert (=> bm!962 (= call!976 call!970)))

(declare-fun b!1205 () Bool)

(declare-fun e!620 () Int)

(declare-fun call!962 () Int)

(assert (=> b!1205 (= e!620 (+ 1 call!977 call!967 call!962))))

(declare-fun bm!963 () Bool)

(assert (=> bm!963 (= call!962 call!976)))

(declare-fun bm!964 () Bool)

(declare-fun call!963 () Int)

(assert (=> bm!964 (= call!963 call!962)))

(declare-fun b!1206 () Bool)

(declare-fun e!614 () Int)

(assert (=> b!1206 (= e!614 e!619)))

(assert (=> b!1206 (= c!583 ((_ is LessEquals!11) (rhs!249 expr!7)))))

(declare-fun b!1207 () Bool)

(assert (=> b!1207 (= c!584 ((_ is UMinus!11) (rhs!249 expr!7)))))

(assert (=> b!1207 (= e!618 e!615)))

(declare-fun bm!965 () Bool)

(assert (=> bm!965 (= call!964 call!972)))

(declare-fun b!1208 () Bool)

(declare-fun call!966 () Int)

(assert (=> b!1208 (= e!614 (+ 1 call!964 call!966))))

(declare-fun b!1209 () Bool)

(assert (=> b!1209 (= e!621 e!618)))

(assert (=> b!1209 (= c!589 ((_ is Minus!11) (rhs!249 expr!7)))))

(declare-fun bm!966 () Bool)

(assert (=> bm!966 (= call!972 call!963)))

(declare-fun bm!967 () Bool)

(assert (=> bm!967 (= call!966 call!965)))

(declare-fun bm!968 () Bool)

(assert (=> bm!968 (= call!970 call!971)))

(declare-fun b!1210 () Bool)

(declare-fun e!616 () Int)

(assert (=> b!1210 (= e!620 e!616)))

(assert (=> b!1210 (= c!591 ((_ is Division!11) (rhs!249 expr!7)))))

(declare-fun bm!969 () Bool)

(assert (=> bm!969 (= call!973 call!966)))

(declare-fun b!1211 () Bool)

(declare-fun e!613 () Int)

(declare-fun call!975 () Int)

(assert (=> b!1211 (= e!613 (+ 1 call!976 call!975))))

(declare-fun b!1212 () Bool)

(assert (=> b!1212 (= e!621 1)))

(declare-fun b!1213 () Bool)

(declare-fun c!586 () Bool)

(assert (=> b!1213 (= c!586 ((_ is IntPow!11) (rhs!249 expr!7)))))

(declare-fun e!617 () Int)

(assert (=> b!1213 (= e!616 e!617)))

(declare-fun bm!970 () Bool)

(assert (=> bm!970 (= call!977 call!975)))

(declare-fun b!1214 () Bool)

(assert (=> b!1214 (= c!588 ((_ is FMA!11) (rhs!249 expr!7)))))

(assert (=> b!1214 (= e!613 e!620)))

(declare-fun b!1215 () Bool)

(assert (=> b!1215 (= e!617 e!622)))

(assert (=> b!1215 (= c!590 ((_ is LessThan!11) (rhs!249 expr!7)))))

(declare-fun b!1216 () Bool)

(assert (=> b!1216 (= e!616 (+ 1 call!963 call!968))))

(declare-fun bm!971 () Bool)

(assert (=> bm!971 (= call!975 (complexity!0 (ite c!585 (rhs!249 (rhs!249 expr!7)) (ite c!588 (fac1!35 (rhs!249 expr!7)) (ite c!591 (rhs!248 (rhs!249 expr!7)) (ite c!586 (base!35 (rhs!249 expr!7)) (ite c!590 (lhs!246 (rhs!249 expr!7)) (ite c!582 (rhs!245 (rhs!249 expr!7)) (ite c!583 (lhs!250 (rhs!249 expr!7)) (lhs!247 (rhs!249 expr!7)))))))))))))

(declare-fun bm!972 () Bool)

(declare-fun call!969 () Int)

(assert (=> bm!972 (= call!969 call!968)))

(declare-fun b!1217 () Bool)

(assert (=> b!1217 (= e!615 e!613)))

(assert (=> b!1217 (= c!585 ((_ is Times!11) (rhs!249 expr!7)))))

(declare-fun bm!973 () Bool)

(assert (=> bm!973 (= call!967 (complexity!0 (ite c!589 (rhs!251 (rhs!249 expr!7)) (fac2!35 (rhs!249 expr!7)))))))

(declare-fun b!1218 () Bool)

(assert (=> b!1218 (= e!617 (+ 1 call!969))))

(declare-fun bm!974 () Bool)

(assert (=> bm!974 (= call!965 call!969)))

(declare-fun b!1219 () Bool)

(assert (=> b!1219 (= c!582 ((_ is GreaterThan!11) (rhs!249 expr!7)))))

(assert (=> b!1219 (= e!622 e!614)))

(assert (= (and d!97 c!587) b!1212))

(assert (= (and d!97 (not c!587)) b!1209))

(assert (= (and b!1209 c!589) b!1204))

(assert (= (and b!1209 (not c!589)) b!1207))

(assert (= (and b!1207 c!584) b!1200))

(assert (= (and b!1207 (not c!584)) b!1217))

(assert (= (and b!1217 c!585) b!1211))

(assert (= (and b!1217 (not c!585)) b!1214))

(assert (= (and b!1214 c!588) b!1205))

(assert (= (and b!1214 (not c!588)) b!1210))

(assert (= (and b!1210 c!591) b!1216))

(assert (= (and b!1210 (not c!591)) b!1213))

(assert (= (and b!1213 c!586) b!1218))

(assert (= (and b!1213 (not c!586)) b!1215))

(assert (= (and b!1215 c!590) b!1203))

(assert (= (and b!1215 (not c!590)) b!1219))

(assert (= (and b!1219 c!582) b!1208))

(assert (= (and b!1219 (not c!582)) b!1206))

(assert (= (and b!1206 c!583) b!1201))

(assert (= (and b!1206 (not c!583)) b!1202))

(assert (= (or b!1201 b!1202) bm!960))

(assert (= (or b!1201 b!1202) bm!969))

(assert (= (or b!1208 bm!969) bm!967))

(assert (= (or b!1208 bm!960) bm!965))

(assert (= (or b!1203 bm!967) bm!974))

(assert (= (or b!1203 bm!965) bm!966))

(assert (= (or b!1218 bm!974) bm!972))

(assert (= (or b!1216 bm!966) bm!964))

(assert (= (or b!1216 bm!972) bm!959))

(assert (= (or b!1205 bm!959) bm!970))

(assert (= (or b!1205 bm!964) bm!963))

(assert (= (or b!1211 bm!970) bm!971))

(assert (= (or b!1211 bm!963) bm!962))

(assert (= (or b!1200 bm!962) bm!968))

(assert (= (or b!1204 b!1205) bm!973))

(assert (= (or b!1204 bm!968) bm!961))

(declare-fun m!349 () Bool)

(assert (=> bm!961 m!349))

(declare-fun m!351 () Bool)

(assert (=> bm!971 m!351))

(declare-fun m!353 () Bool)

(assert (=> bm!973 m!353))

(assert (=> b!1139 d!97))

(check-sat (not bm!961) (not bm!945) (not bm!955) (not bm!971) (not bm!957) (not bm!973))
(check-sat)
