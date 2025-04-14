; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!84 () Bool)

(assert start!84)

(declare-fun res!166 () Bool)

(declare-fun e!1183 () Bool)

(assert (=> start!84 (=> (not res!166) (not e!1183))))

(declare-datatypes ((Expr!19 0))(
  ( (FMA!18 (fac1!42 Expr!19) (fac2!42 Expr!19) (s!75 Expr!19)) (IntegerLiteral!18 (value!83 Int)) (GreaterThan!18 (lhs!294 Expr!19) (rhs!294 Expr!19)) (LessThan!18 (lhs!295 Expr!19) (rhs!295 Expr!19)) (GreaterEquals!18 (lhs!296 Expr!19) (rhs!296 Expr!19)) (UMinus!18 (expr!105 Expr!19)) (IntPow!18 (base!42 Expr!19) (exp!42 Int)) (Division!18 (lhs!297 Expr!19) (rhs!297 Expr!19)) (Times!18 (lhs!298 Expr!19) (rhs!298 Expr!19)) (LessEquals!18 (lhs!299 Expr!19) (rhs!299 Expr!19)) (Minus!18 (lhs!300 Expr!19) (rhs!300 Expr!19)) )
))
(declare-fun expr!7 () Expr!19)

(get-info :version)

(assert (=> start!84 (= res!166 (and (not ((_ is IntegerLiteral!18) expr!7)) (not ((_ is Minus!18) expr!7)) (not ((_ is UMinus!18) expr!7)) (not ((_ is Times!18) expr!7)) (not ((_ is FMA!18) expr!7)) ((_ is Division!18) expr!7)))))

(assert (=> start!84 e!1183))

(assert (=> start!84 true))

(declare-fun b!2320 () Bool)

(declare-fun complexity!0 (Expr!19) Int)

(assert (=> b!2320 (= e!1183 (<= (+ 1 (complexity!0 (lhs!297 expr!7)) (complexity!0 (rhs!297 expr!7))) 0))))

(assert (= (and start!84 res!166) b!2320))

(declare-fun m!709 () Bool)

(assert (=> b!2320 m!709))

(declare-fun m!711 () Bool)

(assert (=> b!2320 m!711))

(check-sat (not b!2320))
(check-sat)
(get-model)

(declare-fun bm!1920 () Bool)

(declare-fun call!1933 () Int)

(declare-fun call!1932 () Int)

(assert (=> bm!1920 (= call!1933 call!1932)))

(declare-fun b!2361 () Bool)

(declare-fun e!1211 () Int)

(declare-fun e!1213 () Int)

(assert (=> b!2361 (= e!1211 e!1213)))

(declare-fun c!1161 () Bool)

(assert (=> b!2361 (= c!1161 ((_ is Division!18) (lhs!297 expr!7)))))

(declare-fun d!203 () Bool)

(declare-fun lt!114 () Int)

(assert (=> d!203 (> lt!114 0)))

(declare-fun e!1208 () Int)

(assert (=> d!203 (= lt!114 e!1208)))

(declare-fun c!1157 () Bool)

(assert (=> d!203 (= c!1157 ((_ is IntegerLiteral!18) (lhs!297 expr!7)))))

(assert (=> d!203 (= (complexity!0 (lhs!297 expr!7)) lt!114)))

(declare-fun b!2362 () Bool)

(declare-fun e!1206 () Int)

(declare-fun call!1931 () Int)

(assert (=> b!2362 (= e!1206 (+ 1 call!1932 call!1931))))

(declare-fun b!2363 () Bool)

(declare-fun e!1209 () Int)

(assert (=> b!2363 (= e!1209 e!1206)))

(declare-fun c!1158 () Bool)

(assert (=> b!2363 (= c!1158 ((_ is LessThan!18) (lhs!297 expr!7)))))

(declare-fun bm!1921 () Bool)

(declare-fun call!1936 () Int)

(declare-fun call!1928 () Int)

(assert (=> bm!1921 (= call!1936 call!1928)))

(declare-fun b!2364 () Bool)

(declare-fun c!1155 () Bool)

(assert (=> b!2364 (= c!1155 ((_ is GreaterThan!18) (lhs!297 expr!7)))))

(declare-fun e!1212 () Int)

(assert (=> b!2364 (= e!1206 e!1212)))

(declare-fun b!2365 () Bool)

(declare-fun e!1207 () Int)

(assert (=> b!2365 (= e!1208 e!1207)))

(declare-fun c!1152 () Bool)

(assert (=> b!2365 (= c!1152 ((_ is Minus!18) (lhs!297 expr!7)))))

(declare-fun b!2366 () Bool)

(declare-fun call!1929 () Int)

(assert (=> b!2366 (= e!1212 (+ 1 call!1929 call!1933))))

(declare-fun b!2367 () Bool)

(declare-fun call!1927 () Int)

(assert (=> b!2367 (= e!1209 (+ 1 call!1927))))

(declare-fun call!1935 () Int)

(declare-fun c!1154 () Bool)

(declare-fun bm!1922 () Bool)

(assert (=> bm!1922 (= call!1935 (complexity!0 (ite c!1152 (lhs!300 (lhs!297 expr!7)) (ite c!1154 (lhs!298 (lhs!297 expr!7)) (fac2!42 (lhs!297 expr!7))))))))

(declare-fun b!2368 () Bool)

(declare-fun e!1210 () Int)

(declare-fun e!1205 () Int)

(assert (=> b!2368 (= e!1210 e!1205)))

(assert (=> b!2368 (= c!1154 ((_ is Times!18) (lhs!297 expr!7)))))

(declare-fun b!2369 () Bool)

(declare-fun call!1934 () Int)

(declare-fun call!1924 () Int)

(assert (=> b!2369 (= e!1213 (+ 1 call!1934 call!1924))))

(declare-fun bm!1923 () Bool)

(declare-fun call!1923 () Int)

(assert (=> bm!1923 (= call!1923 call!1935)))

(declare-fun b!2370 () Bool)

(declare-fun call!1926 () Int)

(assert (=> b!2370 (= e!1207 (+ 1 call!1935 call!1926))))

(declare-fun b!2371 () Bool)

(declare-fun call!1938 () Int)

(assert (=> b!2371 (= e!1210 (+ 1 call!1938))))

(declare-fun bm!1924 () Bool)

(declare-fun call!1937 () Int)

(assert (=> bm!1924 (= call!1937 call!1933)))

(declare-fun bm!1925 () Bool)

(assert (=> bm!1925 (= call!1924 call!1936)))

(declare-fun call!1930 () Int)

(declare-fun bm!1926 () Bool)

(declare-fun c!1159 () Bool)

(declare-fun c!1156 () Bool)

(assert (=> bm!1926 (= call!1930 (complexity!0 (ite c!1159 (fac1!42 (lhs!297 expr!7)) (ite c!1161 (lhs!297 (lhs!297 expr!7)) (ite c!1158 (rhs!295 (lhs!297 expr!7)) (ite c!1155 (lhs!294 (lhs!297 expr!7)) (ite c!1156 (rhs!299 (lhs!297 expr!7)) (rhs!296 (lhs!297 expr!7)))))))))))

(declare-fun bm!1927 () Bool)

(declare-fun call!1925 () Int)

(assert (=> bm!1927 (= call!1925 call!1929)))

(declare-fun bm!1928 () Bool)

(assert (=> bm!1928 (= call!1934 call!1930)))

(declare-fun b!2372 () Bool)

(declare-fun e!1204 () Int)

(assert (=> b!2372 (= e!1212 e!1204)))

(assert (=> b!2372 (= c!1156 ((_ is LessEquals!18) (lhs!297 expr!7)))))

(declare-fun b!2373 () Bool)

(declare-fun c!1160 () Bool)

(assert (=> b!2373 (= c!1160 ((_ is IntPow!18) (lhs!297 expr!7)))))

(assert (=> b!2373 (= e!1213 e!1209)))

(declare-fun bm!1929 () Bool)

(assert (=> bm!1929 (= call!1931 call!1934)))

(declare-fun b!2374 () Bool)

(assert (=> b!2374 (= e!1205 (+ 1 call!1923 call!1928))))

(declare-fun bm!1930 () Bool)

(assert (=> bm!1930 (= call!1928 call!1938)))

(declare-fun b!2375 () Bool)

(assert (=> b!2375 (= e!1211 (+ 1 call!1930 call!1923 call!1936))))

(declare-fun b!2376 () Bool)

(assert (=> b!2376 (= e!1204 (+ 1 call!1937 call!1925))))

(declare-fun bm!1931 () Bool)

(assert (=> bm!1931 (= call!1932 call!1927)))

(declare-fun b!2377 () Bool)

(assert (=> b!2377 (= e!1204 (+ 1 call!1937 call!1925))))

(declare-fun b!2378 () Bool)

(declare-fun c!1153 () Bool)

(assert (=> b!2378 (= c!1153 ((_ is UMinus!18) (lhs!297 expr!7)))))

(assert (=> b!2378 (= e!1207 e!1210)))

(declare-fun b!2379 () Bool)

(assert (=> b!2379 (= c!1159 ((_ is FMA!18) (lhs!297 expr!7)))))

(assert (=> b!2379 (= e!1205 e!1211)))

(declare-fun bm!1932 () Bool)

(assert (=> bm!1932 (= call!1929 call!1931)))

(declare-fun b!2380 () Bool)

(assert (=> b!2380 (= e!1208 1)))

(declare-fun bm!1933 () Bool)

(assert (=> bm!1933 (= call!1938 call!1926)))

(declare-fun bm!1934 () Bool)

(assert (=> bm!1934 (= call!1926 (complexity!0 (ite c!1152 (rhs!300 (lhs!297 expr!7)) (ite c!1153 (expr!105 (lhs!297 expr!7)) (ite c!1154 (rhs!298 (lhs!297 expr!7)) (ite c!1159 (s!75 (lhs!297 expr!7)) (ite c!1161 (rhs!297 (lhs!297 expr!7)) (ite c!1160 (base!42 (lhs!297 expr!7)) (ite c!1158 (lhs!295 (lhs!297 expr!7)) (ite c!1155 (rhs!294 (lhs!297 expr!7)) (ite c!1156 (lhs!299 (lhs!297 expr!7)) (lhs!296 (lhs!297 expr!7)))))))))))))))

(declare-fun bm!1935 () Bool)

(assert (=> bm!1935 (= call!1927 call!1924)))

(assert (= (and d!203 c!1157) b!2380))

(assert (= (and d!203 (not c!1157)) b!2365))

(assert (= (and b!2365 c!1152) b!2370))

(assert (= (and b!2365 (not c!1152)) b!2378))

(assert (= (and b!2378 c!1153) b!2371))

(assert (= (and b!2378 (not c!1153)) b!2368))

(assert (= (and b!2368 c!1154) b!2374))

(assert (= (and b!2368 (not c!1154)) b!2379))

(assert (= (and b!2379 c!1159) b!2375))

(assert (= (and b!2379 (not c!1159)) b!2361))

(assert (= (and b!2361 c!1161) b!2369))

(assert (= (and b!2361 (not c!1161)) b!2373))

(assert (= (and b!2373 c!1160) b!2367))

(assert (= (and b!2373 (not c!1160)) b!2363))

(assert (= (and b!2363 c!1158) b!2362))

(assert (= (and b!2363 (not c!1158)) b!2364))

(assert (= (and b!2364 c!1155) b!2366))

(assert (= (and b!2364 (not c!1155)) b!2372))

(assert (= (and b!2372 c!1156) b!2376))

(assert (= (and b!2372 (not c!1156)) b!2377))

(assert (= (or b!2376 b!2377) bm!1927))

(assert (= (or b!2376 b!2377) bm!1924))

(assert (= (or b!2366 bm!1924) bm!1920))

(assert (= (or b!2366 bm!1927) bm!1932))

(assert (= (or b!2362 bm!1920) bm!1931))

(assert (= (or b!2362 bm!1932) bm!1929))

(assert (= (or b!2367 bm!1931) bm!1935))

(assert (= (or b!2369 bm!1929) bm!1928))

(assert (= (or b!2369 bm!1935) bm!1925))

(assert (= (or b!2375 bm!1928) bm!1926))

(assert (= (or b!2375 bm!1925) bm!1921))

(assert (= (or b!2374 bm!1921) bm!1930))

(assert (= (or b!2374 b!2375) bm!1923))

(assert (= (or b!2371 bm!1930) bm!1933))

(assert (= (or b!2370 bm!1933) bm!1934))

(assert (= (or b!2370 bm!1923) bm!1922))

(declare-fun m!713 () Bool)

(assert (=> bm!1922 m!713))

(declare-fun m!715 () Bool)

(assert (=> bm!1926 m!715))

(declare-fun m!717 () Bool)

(assert (=> bm!1934 m!717))

(assert (=> b!2320 d!203))

(declare-fun bm!1936 () Bool)

(declare-fun call!1949 () Int)

(declare-fun call!1948 () Int)

(assert (=> bm!1936 (= call!1949 call!1948)))

(declare-fun b!2381 () Bool)

(declare-fun e!1221 () Int)

(declare-fun e!1223 () Int)

(assert (=> b!2381 (= e!1221 e!1223)))

(declare-fun c!1171 () Bool)

(assert (=> b!2381 (= c!1171 ((_ is Division!18) (rhs!297 expr!7)))))

(declare-fun d!205 () Bool)

(declare-fun lt!115 () Int)

(assert (=> d!205 (> lt!115 0)))

(declare-fun e!1218 () Int)

(assert (=> d!205 (= lt!115 e!1218)))

(declare-fun c!1167 () Bool)

(assert (=> d!205 (= c!1167 ((_ is IntegerLiteral!18) (rhs!297 expr!7)))))

(assert (=> d!205 (= (complexity!0 (rhs!297 expr!7)) lt!115)))

(declare-fun b!2382 () Bool)

(declare-fun e!1216 () Int)

(declare-fun call!1947 () Int)

(assert (=> b!2382 (= e!1216 (+ 1 call!1948 call!1947))))

(declare-fun b!2383 () Bool)

(declare-fun e!1219 () Int)

(assert (=> b!2383 (= e!1219 e!1216)))

(declare-fun c!1168 () Bool)

(assert (=> b!2383 (= c!1168 ((_ is LessThan!18) (rhs!297 expr!7)))))

(declare-fun bm!1937 () Bool)

(declare-fun call!1952 () Int)

(declare-fun call!1944 () Int)

(assert (=> bm!1937 (= call!1952 call!1944)))

(declare-fun b!2384 () Bool)

(declare-fun c!1165 () Bool)

(assert (=> b!2384 (= c!1165 ((_ is GreaterThan!18) (rhs!297 expr!7)))))

(declare-fun e!1222 () Int)

(assert (=> b!2384 (= e!1216 e!1222)))

(declare-fun b!2385 () Bool)

(declare-fun e!1217 () Int)

(assert (=> b!2385 (= e!1218 e!1217)))

(declare-fun c!1162 () Bool)

(assert (=> b!2385 (= c!1162 ((_ is Minus!18) (rhs!297 expr!7)))))

(declare-fun b!2386 () Bool)

(declare-fun call!1945 () Int)

(assert (=> b!2386 (= e!1222 (+ 1 call!1945 call!1949))))

(declare-fun b!2387 () Bool)

(declare-fun call!1943 () Int)

(assert (=> b!2387 (= e!1219 (+ 1 call!1943))))

(declare-fun bm!1938 () Bool)

(declare-fun call!1951 () Int)

(declare-fun c!1164 () Bool)

(assert (=> bm!1938 (= call!1951 (complexity!0 (ite c!1162 (lhs!300 (rhs!297 expr!7)) (ite c!1164 (lhs!298 (rhs!297 expr!7)) (fac2!42 (rhs!297 expr!7))))))))

(declare-fun b!2388 () Bool)

(declare-fun e!1220 () Int)

(declare-fun e!1215 () Int)

(assert (=> b!2388 (= e!1220 e!1215)))

(assert (=> b!2388 (= c!1164 ((_ is Times!18) (rhs!297 expr!7)))))

(declare-fun b!2389 () Bool)

(declare-fun call!1950 () Int)

(declare-fun call!1940 () Int)

(assert (=> b!2389 (= e!1223 (+ 1 call!1950 call!1940))))

(declare-fun bm!1939 () Bool)

(declare-fun call!1939 () Int)

(assert (=> bm!1939 (= call!1939 call!1951)))

(declare-fun b!2390 () Bool)

(declare-fun call!1942 () Int)

(assert (=> b!2390 (= e!1217 (+ 1 call!1951 call!1942))))

(declare-fun b!2391 () Bool)

(declare-fun call!1954 () Int)

(assert (=> b!2391 (= e!1220 (+ 1 call!1954))))

(declare-fun bm!1940 () Bool)

(declare-fun call!1953 () Int)

(assert (=> bm!1940 (= call!1953 call!1949)))

(declare-fun bm!1941 () Bool)

(assert (=> bm!1941 (= call!1940 call!1952)))

(declare-fun c!1169 () Bool)

(declare-fun c!1166 () Bool)

(declare-fun bm!1942 () Bool)

(declare-fun call!1946 () Int)

(assert (=> bm!1942 (= call!1946 (complexity!0 (ite c!1169 (fac1!42 (rhs!297 expr!7)) (ite c!1171 (lhs!297 (rhs!297 expr!7)) (ite c!1168 (rhs!295 (rhs!297 expr!7)) (ite c!1165 (lhs!294 (rhs!297 expr!7)) (ite c!1166 (rhs!299 (rhs!297 expr!7)) (rhs!296 (rhs!297 expr!7)))))))))))

(declare-fun bm!1943 () Bool)

(declare-fun call!1941 () Int)

(assert (=> bm!1943 (= call!1941 call!1945)))

(declare-fun bm!1944 () Bool)

(assert (=> bm!1944 (= call!1950 call!1946)))

(declare-fun b!2392 () Bool)

(declare-fun e!1214 () Int)

(assert (=> b!2392 (= e!1222 e!1214)))

(assert (=> b!2392 (= c!1166 ((_ is LessEquals!18) (rhs!297 expr!7)))))

(declare-fun b!2393 () Bool)

(declare-fun c!1170 () Bool)

(assert (=> b!2393 (= c!1170 ((_ is IntPow!18) (rhs!297 expr!7)))))

(assert (=> b!2393 (= e!1223 e!1219)))

(declare-fun bm!1945 () Bool)

(assert (=> bm!1945 (= call!1947 call!1950)))

(declare-fun b!2394 () Bool)

(assert (=> b!2394 (= e!1215 (+ 1 call!1939 call!1944))))

(declare-fun bm!1946 () Bool)

(assert (=> bm!1946 (= call!1944 call!1954)))

(declare-fun b!2395 () Bool)

(assert (=> b!2395 (= e!1221 (+ 1 call!1946 call!1939 call!1952))))

(declare-fun b!2396 () Bool)

(assert (=> b!2396 (= e!1214 (+ 1 call!1953 call!1941))))

(declare-fun bm!1947 () Bool)

(assert (=> bm!1947 (= call!1948 call!1943)))

(declare-fun b!2397 () Bool)

(assert (=> b!2397 (= e!1214 (+ 1 call!1953 call!1941))))

(declare-fun b!2398 () Bool)

(declare-fun c!1163 () Bool)

(assert (=> b!2398 (= c!1163 ((_ is UMinus!18) (rhs!297 expr!7)))))

(assert (=> b!2398 (= e!1217 e!1220)))

(declare-fun b!2399 () Bool)

(assert (=> b!2399 (= c!1169 ((_ is FMA!18) (rhs!297 expr!7)))))

(assert (=> b!2399 (= e!1215 e!1221)))

(declare-fun bm!1948 () Bool)

(assert (=> bm!1948 (= call!1945 call!1947)))

(declare-fun b!2400 () Bool)

(assert (=> b!2400 (= e!1218 1)))

(declare-fun bm!1949 () Bool)

(assert (=> bm!1949 (= call!1954 call!1942)))

(declare-fun bm!1950 () Bool)

(assert (=> bm!1950 (= call!1942 (complexity!0 (ite c!1162 (rhs!300 (rhs!297 expr!7)) (ite c!1163 (expr!105 (rhs!297 expr!7)) (ite c!1164 (rhs!298 (rhs!297 expr!7)) (ite c!1169 (s!75 (rhs!297 expr!7)) (ite c!1171 (rhs!297 (rhs!297 expr!7)) (ite c!1170 (base!42 (rhs!297 expr!7)) (ite c!1168 (lhs!295 (rhs!297 expr!7)) (ite c!1165 (rhs!294 (rhs!297 expr!7)) (ite c!1166 (lhs!299 (rhs!297 expr!7)) (lhs!296 (rhs!297 expr!7)))))))))))))))

(declare-fun bm!1951 () Bool)

(assert (=> bm!1951 (= call!1943 call!1940)))

(assert (= (and d!205 c!1167) b!2400))

(assert (= (and d!205 (not c!1167)) b!2385))

(assert (= (and b!2385 c!1162) b!2390))

(assert (= (and b!2385 (not c!1162)) b!2398))

(assert (= (and b!2398 c!1163) b!2391))

(assert (= (and b!2398 (not c!1163)) b!2388))

(assert (= (and b!2388 c!1164) b!2394))

(assert (= (and b!2388 (not c!1164)) b!2399))

(assert (= (and b!2399 c!1169) b!2395))

(assert (= (and b!2399 (not c!1169)) b!2381))

(assert (= (and b!2381 c!1171) b!2389))

(assert (= (and b!2381 (not c!1171)) b!2393))

(assert (= (and b!2393 c!1170) b!2387))

(assert (= (and b!2393 (not c!1170)) b!2383))

(assert (= (and b!2383 c!1168) b!2382))

(assert (= (and b!2383 (not c!1168)) b!2384))

(assert (= (and b!2384 c!1165) b!2386))

(assert (= (and b!2384 (not c!1165)) b!2392))

(assert (= (and b!2392 c!1166) b!2396))

(assert (= (and b!2392 (not c!1166)) b!2397))

(assert (= (or b!2396 b!2397) bm!1943))

(assert (= (or b!2396 b!2397) bm!1940))

(assert (= (or b!2386 bm!1940) bm!1936))

(assert (= (or b!2386 bm!1943) bm!1948))

(assert (= (or b!2382 bm!1936) bm!1947))

(assert (= (or b!2382 bm!1948) bm!1945))

(assert (= (or b!2387 bm!1947) bm!1951))

(assert (= (or b!2389 bm!1945) bm!1944))

(assert (= (or b!2389 bm!1951) bm!1941))

(assert (= (or b!2395 bm!1944) bm!1942))

(assert (= (or b!2395 bm!1941) bm!1937))

(assert (= (or b!2394 bm!1937) bm!1946))

(assert (= (or b!2394 b!2395) bm!1939))

(assert (= (or b!2391 bm!1946) bm!1949))

(assert (= (or b!2390 bm!1949) bm!1950))

(assert (= (or b!2390 bm!1939) bm!1938))

(declare-fun m!719 () Bool)

(assert (=> bm!1938 m!719))

(declare-fun m!721 () Bool)

(assert (=> bm!1942 m!721))

(declare-fun m!723 () Bool)

(assert (=> bm!1950 m!723))

(assert (=> b!2320 d!205))

(check-sat (not bm!1926) (not bm!1950) (not bm!1942) (not bm!1922) (not bm!1938) (not bm!1934))
(check-sat)
