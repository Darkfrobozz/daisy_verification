; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!68 () Bool)

(assert start!68)

(declare-fun res!157 () Bool)

(declare-fun e!924 () Bool)

(assert (=> start!68 (=> (not res!157) (not e!924))))

(declare-datatypes ((Expr!16 0))(
  ( (FMA!15 (fac1!39 Expr!16) (fac2!39 Expr!16) (s!69 Expr!16)) (IntegerLiteral!15 (value!77 Int)) (GreaterThan!15 (lhs!273 Expr!16) (rhs!273 Expr!16)) (LessThan!15 (lhs!274 Expr!16) (rhs!274 Expr!16)) (GreaterEquals!15 (lhs!275 Expr!16) (rhs!275 Expr!16)) (UMinus!15 (expr!101 Expr!16)) (IntPow!15 (base!39 Expr!16) (exp!39 Int)) (Division!15 (lhs!276 Expr!16) (rhs!276 Expr!16)) (Times!15 (lhs!277 Expr!16) (rhs!277 Expr!16)) (LessEquals!15 (lhs!278 Expr!16) (rhs!278 Expr!16)) (Minus!15 (lhs!279 Expr!16) (rhs!279 Expr!16)) )
))
(declare-fun expr!7 () Expr!16)

(get-info :version)

(assert (=> start!68 (= res!157 (and (not ((_ is IntegerLiteral!15) expr!7)) (not ((_ is Minus!15) expr!7)) (not ((_ is UMinus!15) expr!7)) (not ((_ is Times!15) expr!7)) ((_ is FMA!15) expr!7)))))

(assert (=> start!68 e!924))

(assert (=> start!68 true))

(declare-fun b!1811 () Bool)

(declare-fun complexity!0 (Expr!16) Int)

(assert (=> b!1811 (= e!924 (<= (+ 1 (complexity!0 (fac1!39 expr!7)) (complexity!0 (fac2!39 expr!7)) (complexity!0 (s!69 expr!7))) 0))))

(assert (= (and start!68 res!157) b!1811))

(declare-fun m!549 () Bool)

(assert (=> b!1811 m!549))

(declare-fun m!551 () Bool)

(assert (=> b!1811 m!551))

(declare-fun m!553 () Bool)

(assert (=> b!1811 m!553))

(check-sat (not b!1811))
(check-sat)
(get-model)

(declare-fun b!1852 () Bool)

(declare-fun e!951 () Int)

(declare-fun call!1509 () Int)

(declare-fun call!1503 () Int)

(assert (=> b!1852 (= e!951 (+ 1 call!1509 call!1503))))

(declare-fun b!1853 () Bool)

(declare-fun e!954 () Int)

(declare-fun e!949 () Int)

(assert (=> b!1853 (= e!954 e!949)))

(declare-fun c!910 () Bool)

(assert (=> b!1853 (= c!910 ((_ is LessThan!15) (fac1!39 expr!7)))))

(declare-fun bm!1500 () Bool)

(declare-fun call!1505 () Int)

(declare-fun c!909 () Bool)

(assert (=> bm!1500 (= call!1505 (complexity!0 (ite c!909 (rhs!277 (fac1!39 expr!7)) (fac2!39 (fac1!39 expr!7)))))))

(declare-fun b!1854 () Bool)

(assert (=> b!1854 (= e!951 (+ 1 call!1509 call!1503))))

(declare-fun b!1855 () Bool)

(declare-fun e!945 () Int)

(declare-fun e!947 () Int)

(assert (=> b!1855 (= e!945 e!947)))

(assert (=> b!1855 (= c!909 ((_ is Times!15) (fac1!39 expr!7)))))

(declare-fun bm!1501 () Bool)

(declare-fun call!1516 () Int)

(assert (=> bm!1501 (= call!1503 call!1516)))

(declare-fun b!1856 () Bool)

(declare-fun e!948 () Int)

(declare-fun e!946 () Int)

(assert (=> b!1856 (= e!948 e!946)))

(declare-fun c!906 () Bool)

(assert (=> b!1856 (= c!906 ((_ is Division!15) (fac1!39 expr!7)))))

(declare-fun b!1857 () Bool)

(declare-fun call!1517 () Int)

(declare-fun call!1511 () Int)

(assert (=> b!1857 (= e!949 (+ 1 call!1517 call!1511))))

(declare-fun bm!1503 () Bool)

(declare-fun call!1510 () Int)

(assert (=> bm!1503 (= call!1511 call!1510)))

(declare-fun b!1858 () Bool)

(declare-fun e!950 () Int)

(assert (=> b!1858 (= e!950 1)))

(declare-fun bm!1504 () Bool)

(declare-fun call!1506 () Int)

(declare-fun call!1504 () Int)

(assert (=> bm!1504 (= call!1506 call!1504)))

(declare-fun b!1859 () Bool)

(declare-fun e!953 () Int)

(assert (=> b!1859 (= e!950 e!953)))

(declare-fun c!903 () Bool)

(assert (=> b!1859 (= c!903 ((_ is Minus!15) (fac1!39 expr!7)))))

(declare-fun b!1860 () Bool)

(declare-fun e!952 () Int)

(declare-fun call!1512 () Int)

(assert (=> b!1860 (= e!952 (+ 1 call!1516 call!1512))))

(declare-fun bm!1505 () Bool)

(declare-fun call!1507 () Int)

(declare-fun call!1508 () Int)

(assert (=> bm!1505 (= call!1507 call!1508)))

(declare-fun bm!1506 () Bool)

(declare-fun call!1513 () Int)

(assert (=> bm!1506 (= call!1508 call!1513)))

(declare-fun bm!1507 () Bool)

(declare-fun call!1518 () Int)

(declare-fun call!1514 () Int)

(assert (=> bm!1507 (= call!1518 call!1514)))

(declare-fun bm!1508 () Bool)

(assert (=> bm!1508 (= call!1509 call!1512)))

(declare-fun b!1861 () Bool)

(declare-fun call!1515 () Int)

(assert (=> b!1861 (= e!946 (+ 1 call!1506 call!1515))))

(declare-fun b!1862 () Bool)

(assert (=> b!1862 (= e!945 (+ 1 call!1508))))

(declare-fun b!1863 () Bool)

(declare-fun c!905 () Bool)

(assert (=> b!1863 (= c!905 ((_ is FMA!15) (fac1!39 expr!7)))))

(assert (=> b!1863 (= e!947 e!948)))

(declare-fun d!157 () Bool)

(declare-fun lt!89 () Int)

(assert (=> d!157 (> lt!89 0)))

(assert (=> d!157 (= lt!89 e!950)))

(declare-fun c!911 () Bool)

(assert (=> d!157 (= c!911 ((_ is IntegerLiteral!15) (fac1!39 expr!7)))))

(assert (=> d!157 (= (complexity!0 (fac1!39 expr!7)) lt!89)))

(declare-fun bm!1502 () Bool)

(assert (=> bm!1502 (= call!1515 call!1507)))

(declare-fun bm!1509 () Bool)

(assert (=> bm!1509 (= call!1504 call!1518)))

(declare-fun b!1864 () Bool)

(declare-fun c!907 () Bool)

(assert (=> b!1864 (= c!907 ((_ is GreaterThan!15) (fac1!39 expr!7)))))

(assert (=> b!1864 (= e!949 e!952)))

(declare-fun b!1865 () Bool)

(assert (=> b!1865 (= e!947 (+ 1 call!1518 call!1505))))

(declare-fun bm!1510 () Bool)

(assert (=> bm!1510 (= call!1510 call!1506)))

(declare-fun b!1866 () Bool)

(assert (=> b!1866 (= e!948 (+ 1 call!1507 call!1505 call!1504))))

(declare-fun b!1867 () Bool)

(assert (=> b!1867 (= e!952 e!951)))

(declare-fun c!902 () Bool)

(assert (=> b!1867 (= c!902 ((_ is LessEquals!15) (fac1!39 expr!7)))))

(declare-fun bm!1511 () Bool)

(assert (=> bm!1511 (= call!1512 call!1511)))

(declare-fun bm!1512 () Bool)

(declare-fun c!908 () Bool)

(assert (=> bm!1512 (= call!1514 (complexity!0 (ite c!903 (lhs!279 (fac1!39 expr!7)) (ite c!909 (lhs!277 (fac1!39 expr!7)) (ite c!905 (s!69 (fac1!39 expr!7)) (ite c!906 (lhs!276 (fac1!39 expr!7)) (ite c!908 (base!39 (fac1!39 expr!7)) (ite c!910 (rhs!274 (fac1!39 expr!7)) (ite c!907 (rhs!273 (fac1!39 expr!7)) (ite c!902 (lhs!278 (fac1!39 expr!7)) (lhs!275 (fac1!39 expr!7))))))))))))))

(declare-fun bm!1513 () Bool)

(declare-fun c!904 () Bool)

(assert (=> bm!1513 (= call!1513 (complexity!0 (ite c!903 (rhs!279 (fac1!39 expr!7)) (ite c!904 (expr!101 (fac1!39 expr!7)) (ite c!905 (fac1!39 (fac1!39 expr!7)) (ite c!906 (rhs!276 (fac1!39 expr!7)) (ite c!910 (lhs!274 (fac1!39 expr!7)) (ite c!907 (lhs!273 (fac1!39 expr!7)) (ite c!902 (rhs!278 (fac1!39 expr!7)) (rhs!275 (fac1!39 expr!7)))))))))))))

(declare-fun b!1868 () Bool)

(assert (=> b!1868 (= c!908 ((_ is IntPow!15) (fac1!39 expr!7)))))

(assert (=> b!1868 (= e!946 e!954)))

(declare-fun b!1869 () Bool)

(assert (=> b!1869 (= e!953 (+ 1 call!1514 call!1513))))

(declare-fun bm!1514 () Bool)

(assert (=> bm!1514 (= call!1517 call!1515)))

(declare-fun b!1870 () Bool)

(assert (=> b!1870 (= e!954 (+ 1 call!1510))))

(declare-fun bm!1515 () Bool)

(assert (=> bm!1515 (= call!1516 call!1517)))

(declare-fun b!1871 () Bool)

(assert (=> b!1871 (= c!904 ((_ is UMinus!15) (fac1!39 expr!7)))))

(assert (=> b!1871 (= e!953 e!945)))

(assert (= (and d!157 c!911) b!1858))

(assert (= (and d!157 (not c!911)) b!1859))

(assert (= (and b!1859 c!903) b!1869))

(assert (= (and b!1859 (not c!903)) b!1871))

(assert (= (and b!1871 c!904) b!1862))

(assert (= (and b!1871 (not c!904)) b!1855))

(assert (= (and b!1855 c!909) b!1865))

(assert (= (and b!1855 (not c!909)) b!1863))

(assert (= (and b!1863 c!905) b!1866))

(assert (= (and b!1863 (not c!905)) b!1856))

(assert (= (and b!1856 c!906) b!1861))

(assert (= (and b!1856 (not c!906)) b!1868))

(assert (= (and b!1868 c!908) b!1870))

(assert (= (and b!1868 (not c!908)) b!1853))

(assert (= (and b!1853 c!910) b!1857))

(assert (= (and b!1853 (not c!910)) b!1864))

(assert (= (and b!1864 c!907) b!1860))

(assert (= (and b!1864 (not c!907)) b!1867))

(assert (= (and b!1867 c!902) b!1852))

(assert (= (and b!1867 (not c!902)) b!1854))

(assert (= (or b!1852 b!1854) bm!1501))

(assert (= (or b!1852 b!1854) bm!1508))

(assert (= (or b!1860 bm!1508) bm!1511))

(assert (= (or b!1860 bm!1501) bm!1515))

(assert (= (or b!1857 bm!1515) bm!1514))

(assert (= (or b!1857 bm!1511) bm!1503))

(assert (= (or b!1870 bm!1503) bm!1510))

(assert (= (or b!1861 bm!1510) bm!1504))

(assert (= (or b!1861 bm!1514) bm!1502))

(assert (= (or b!1866 bm!1502) bm!1505))

(assert (= (or b!1866 bm!1504) bm!1509))

(assert (= (or b!1865 b!1866) bm!1500))

(assert (= (or b!1865 bm!1509) bm!1507))

(assert (= (or b!1862 bm!1505) bm!1506))

(assert (= (or b!1869 bm!1506) bm!1513))

(assert (= (or b!1869 bm!1507) bm!1512))

(declare-fun m!555 () Bool)

(assert (=> bm!1500 m!555))

(declare-fun m!557 () Bool)

(assert (=> bm!1512 m!557))

(declare-fun m!559 () Bool)

(assert (=> bm!1513 m!559))

(assert (=> b!1811 d!157))

(declare-fun b!1872 () Bool)

(declare-fun e!961 () Int)

(declare-fun call!1525 () Int)

(declare-fun call!1519 () Int)

(assert (=> b!1872 (= e!961 (+ 1 call!1525 call!1519))))

(declare-fun b!1873 () Bool)

(declare-fun e!964 () Int)

(declare-fun e!959 () Int)

(assert (=> b!1873 (= e!964 e!959)))

(declare-fun c!920 () Bool)

(assert (=> b!1873 (= c!920 ((_ is LessThan!15) (fac2!39 expr!7)))))

(declare-fun bm!1516 () Bool)

(declare-fun call!1521 () Int)

(declare-fun c!919 () Bool)

(assert (=> bm!1516 (= call!1521 (complexity!0 (ite c!919 (rhs!277 (fac2!39 expr!7)) (fac2!39 (fac2!39 expr!7)))))))

(declare-fun b!1874 () Bool)

(assert (=> b!1874 (= e!961 (+ 1 call!1525 call!1519))))

(declare-fun b!1875 () Bool)

(declare-fun e!955 () Int)

(declare-fun e!957 () Int)

(assert (=> b!1875 (= e!955 e!957)))

(assert (=> b!1875 (= c!919 ((_ is Times!15) (fac2!39 expr!7)))))

(declare-fun bm!1517 () Bool)

(declare-fun call!1532 () Int)

(assert (=> bm!1517 (= call!1519 call!1532)))

(declare-fun b!1876 () Bool)

(declare-fun e!958 () Int)

(declare-fun e!956 () Int)

(assert (=> b!1876 (= e!958 e!956)))

(declare-fun c!916 () Bool)

(assert (=> b!1876 (= c!916 ((_ is Division!15) (fac2!39 expr!7)))))

(declare-fun b!1877 () Bool)

(declare-fun call!1533 () Int)

(declare-fun call!1527 () Int)

(assert (=> b!1877 (= e!959 (+ 1 call!1533 call!1527))))

(declare-fun bm!1519 () Bool)

(declare-fun call!1526 () Int)

(assert (=> bm!1519 (= call!1527 call!1526)))

(declare-fun b!1878 () Bool)

(declare-fun e!960 () Int)

(assert (=> b!1878 (= e!960 1)))

(declare-fun bm!1520 () Bool)

(declare-fun call!1522 () Int)

(declare-fun call!1520 () Int)

(assert (=> bm!1520 (= call!1522 call!1520)))

(declare-fun b!1879 () Bool)

(declare-fun e!963 () Int)

(assert (=> b!1879 (= e!960 e!963)))

(declare-fun c!913 () Bool)

(assert (=> b!1879 (= c!913 ((_ is Minus!15) (fac2!39 expr!7)))))

(declare-fun b!1880 () Bool)

(declare-fun e!962 () Int)

(declare-fun call!1528 () Int)

(assert (=> b!1880 (= e!962 (+ 1 call!1532 call!1528))))

(declare-fun bm!1521 () Bool)

(declare-fun call!1523 () Int)

(declare-fun call!1524 () Int)

(assert (=> bm!1521 (= call!1523 call!1524)))

(declare-fun bm!1522 () Bool)

(declare-fun call!1529 () Int)

(assert (=> bm!1522 (= call!1524 call!1529)))

(declare-fun bm!1523 () Bool)

(declare-fun call!1534 () Int)

(declare-fun call!1530 () Int)

(assert (=> bm!1523 (= call!1534 call!1530)))

(declare-fun bm!1524 () Bool)

(assert (=> bm!1524 (= call!1525 call!1528)))

(declare-fun b!1881 () Bool)

(declare-fun call!1531 () Int)

(assert (=> b!1881 (= e!956 (+ 1 call!1522 call!1531))))

(declare-fun b!1882 () Bool)

(assert (=> b!1882 (= e!955 (+ 1 call!1524))))

(declare-fun b!1883 () Bool)

(declare-fun c!915 () Bool)

(assert (=> b!1883 (= c!915 ((_ is FMA!15) (fac2!39 expr!7)))))

(assert (=> b!1883 (= e!957 e!958)))

(declare-fun d!159 () Bool)

(declare-fun lt!90 () Int)

(assert (=> d!159 (> lt!90 0)))

(assert (=> d!159 (= lt!90 e!960)))

(declare-fun c!921 () Bool)

(assert (=> d!159 (= c!921 ((_ is IntegerLiteral!15) (fac2!39 expr!7)))))

(assert (=> d!159 (= (complexity!0 (fac2!39 expr!7)) lt!90)))

(declare-fun bm!1518 () Bool)

(assert (=> bm!1518 (= call!1531 call!1523)))

(declare-fun bm!1525 () Bool)

(assert (=> bm!1525 (= call!1520 call!1534)))

(declare-fun b!1884 () Bool)

(declare-fun c!917 () Bool)

(assert (=> b!1884 (= c!917 ((_ is GreaterThan!15) (fac2!39 expr!7)))))

(assert (=> b!1884 (= e!959 e!962)))

(declare-fun b!1885 () Bool)

(assert (=> b!1885 (= e!957 (+ 1 call!1534 call!1521))))

(declare-fun bm!1526 () Bool)

(assert (=> bm!1526 (= call!1526 call!1522)))

(declare-fun b!1886 () Bool)

(assert (=> b!1886 (= e!958 (+ 1 call!1523 call!1521 call!1520))))

(declare-fun b!1887 () Bool)

(assert (=> b!1887 (= e!962 e!961)))

(declare-fun c!912 () Bool)

(assert (=> b!1887 (= c!912 ((_ is LessEquals!15) (fac2!39 expr!7)))))

(declare-fun bm!1527 () Bool)

(assert (=> bm!1527 (= call!1528 call!1527)))

(declare-fun c!918 () Bool)

(declare-fun bm!1528 () Bool)

(assert (=> bm!1528 (= call!1530 (complexity!0 (ite c!913 (lhs!279 (fac2!39 expr!7)) (ite c!919 (lhs!277 (fac2!39 expr!7)) (ite c!915 (s!69 (fac2!39 expr!7)) (ite c!916 (lhs!276 (fac2!39 expr!7)) (ite c!918 (base!39 (fac2!39 expr!7)) (ite c!920 (rhs!274 (fac2!39 expr!7)) (ite c!917 (rhs!273 (fac2!39 expr!7)) (ite c!912 (lhs!278 (fac2!39 expr!7)) (lhs!275 (fac2!39 expr!7))))))))))))))

(declare-fun bm!1529 () Bool)

(declare-fun c!914 () Bool)

(assert (=> bm!1529 (= call!1529 (complexity!0 (ite c!913 (rhs!279 (fac2!39 expr!7)) (ite c!914 (expr!101 (fac2!39 expr!7)) (ite c!915 (fac1!39 (fac2!39 expr!7)) (ite c!916 (rhs!276 (fac2!39 expr!7)) (ite c!920 (lhs!274 (fac2!39 expr!7)) (ite c!917 (lhs!273 (fac2!39 expr!7)) (ite c!912 (rhs!278 (fac2!39 expr!7)) (rhs!275 (fac2!39 expr!7)))))))))))))

(declare-fun b!1888 () Bool)

(assert (=> b!1888 (= c!918 ((_ is IntPow!15) (fac2!39 expr!7)))))

(assert (=> b!1888 (= e!956 e!964)))

(declare-fun b!1889 () Bool)

(assert (=> b!1889 (= e!963 (+ 1 call!1530 call!1529))))

(declare-fun bm!1530 () Bool)

(assert (=> bm!1530 (= call!1533 call!1531)))

(declare-fun b!1890 () Bool)

(assert (=> b!1890 (= e!964 (+ 1 call!1526))))

(declare-fun bm!1531 () Bool)

(assert (=> bm!1531 (= call!1532 call!1533)))

(declare-fun b!1891 () Bool)

(assert (=> b!1891 (= c!914 ((_ is UMinus!15) (fac2!39 expr!7)))))

(assert (=> b!1891 (= e!963 e!955)))

(assert (= (and d!159 c!921) b!1878))

(assert (= (and d!159 (not c!921)) b!1879))

(assert (= (and b!1879 c!913) b!1889))

(assert (= (and b!1879 (not c!913)) b!1891))

(assert (= (and b!1891 c!914) b!1882))

(assert (= (and b!1891 (not c!914)) b!1875))

(assert (= (and b!1875 c!919) b!1885))

(assert (= (and b!1875 (not c!919)) b!1883))

(assert (= (and b!1883 c!915) b!1886))

(assert (= (and b!1883 (not c!915)) b!1876))

(assert (= (and b!1876 c!916) b!1881))

(assert (= (and b!1876 (not c!916)) b!1888))

(assert (= (and b!1888 c!918) b!1890))

(assert (= (and b!1888 (not c!918)) b!1873))

(assert (= (and b!1873 c!920) b!1877))

(assert (= (and b!1873 (not c!920)) b!1884))

(assert (= (and b!1884 c!917) b!1880))

(assert (= (and b!1884 (not c!917)) b!1887))

(assert (= (and b!1887 c!912) b!1872))

(assert (= (and b!1887 (not c!912)) b!1874))

(assert (= (or b!1872 b!1874) bm!1517))

(assert (= (or b!1872 b!1874) bm!1524))

(assert (= (or b!1880 bm!1524) bm!1527))

(assert (= (or b!1880 bm!1517) bm!1531))

(assert (= (or b!1877 bm!1531) bm!1530))

(assert (= (or b!1877 bm!1527) bm!1519))

(assert (= (or b!1890 bm!1519) bm!1526))

(assert (= (or b!1881 bm!1526) bm!1520))

(assert (= (or b!1881 bm!1530) bm!1518))

(assert (= (or b!1886 bm!1518) bm!1521))

(assert (= (or b!1886 bm!1520) bm!1525))

(assert (= (or b!1885 b!1886) bm!1516))

(assert (= (or b!1885 bm!1525) bm!1523))

(assert (= (or b!1882 bm!1521) bm!1522))

(assert (= (or b!1889 bm!1522) bm!1529))

(assert (= (or b!1889 bm!1523) bm!1528))

(declare-fun m!561 () Bool)

(assert (=> bm!1516 m!561))

(declare-fun m!563 () Bool)

(assert (=> bm!1528 m!563))

(declare-fun m!565 () Bool)

(assert (=> bm!1529 m!565))

(assert (=> b!1811 d!159))

(declare-fun b!1892 () Bool)

(declare-fun e!971 () Int)

(declare-fun call!1541 () Int)

(declare-fun call!1535 () Int)

(assert (=> b!1892 (= e!971 (+ 1 call!1541 call!1535))))

(declare-fun b!1893 () Bool)

(declare-fun e!974 () Int)

(declare-fun e!969 () Int)

(assert (=> b!1893 (= e!974 e!969)))

(declare-fun c!930 () Bool)

(assert (=> b!1893 (= c!930 ((_ is LessThan!15) (s!69 expr!7)))))

(declare-fun bm!1532 () Bool)

(declare-fun call!1537 () Int)

(declare-fun c!929 () Bool)

(assert (=> bm!1532 (= call!1537 (complexity!0 (ite c!929 (rhs!277 (s!69 expr!7)) (fac2!39 (s!69 expr!7)))))))

(declare-fun b!1894 () Bool)

(assert (=> b!1894 (= e!971 (+ 1 call!1541 call!1535))))

(declare-fun b!1895 () Bool)

(declare-fun e!965 () Int)

(declare-fun e!967 () Int)

(assert (=> b!1895 (= e!965 e!967)))

(assert (=> b!1895 (= c!929 ((_ is Times!15) (s!69 expr!7)))))

(declare-fun bm!1533 () Bool)

(declare-fun call!1548 () Int)

(assert (=> bm!1533 (= call!1535 call!1548)))

(declare-fun b!1896 () Bool)

(declare-fun e!968 () Int)

(declare-fun e!966 () Int)

(assert (=> b!1896 (= e!968 e!966)))

(declare-fun c!926 () Bool)

(assert (=> b!1896 (= c!926 ((_ is Division!15) (s!69 expr!7)))))

(declare-fun b!1897 () Bool)

(declare-fun call!1549 () Int)

(declare-fun call!1543 () Int)

(assert (=> b!1897 (= e!969 (+ 1 call!1549 call!1543))))

(declare-fun bm!1535 () Bool)

(declare-fun call!1542 () Int)

(assert (=> bm!1535 (= call!1543 call!1542)))

(declare-fun b!1898 () Bool)

(declare-fun e!970 () Int)

(assert (=> b!1898 (= e!970 1)))

(declare-fun bm!1536 () Bool)

(declare-fun call!1538 () Int)

(declare-fun call!1536 () Int)

(assert (=> bm!1536 (= call!1538 call!1536)))

(declare-fun b!1899 () Bool)

(declare-fun e!973 () Int)

(assert (=> b!1899 (= e!970 e!973)))

(declare-fun c!923 () Bool)

(assert (=> b!1899 (= c!923 ((_ is Minus!15) (s!69 expr!7)))))

(declare-fun b!1900 () Bool)

(declare-fun e!972 () Int)

(declare-fun call!1544 () Int)

(assert (=> b!1900 (= e!972 (+ 1 call!1548 call!1544))))

(declare-fun bm!1537 () Bool)

(declare-fun call!1539 () Int)

(declare-fun call!1540 () Int)

(assert (=> bm!1537 (= call!1539 call!1540)))

(declare-fun bm!1538 () Bool)

(declare-fun call!1545 () Int)

(assert (=> bm!1538 (= call!1540 call!1545)))

(declare-fun bm!1539 () Bool)

(declare-fun call!1550 () Int)

(declare-fun call!1546 () Int)

(assert (=> bm!1539 (= call!1550 call!1546)))

(declare-fun bm!1540 () Bool)

(assert (=> bm!1540 (= call!1541 call!1544)))

(declare-fun b!1901 () Bool)

(declare-fun call!1547 () Int)

(assert (=> b!1901 (= e!966 (+ 1 call!1538 call!1547))))

(declare-fun b!1902 () Bool)

(assert (=> b!1902 (= e!965 (+ 1 call!1540))))

(declare-fun b!1903 () Bool)

(declare-fun c!925 () Bool)

(assert (=> b!1903 (= c!925 ((_ is FMA!15) (s!69 expr!7)))))

(assert (=> b!1903 (= e!967 e!968)))

(declare-fun d!161 () Bool)

(declare-fun lt!91 () Int)

(assert (=> d!161 (> lt!91 0)))

(assert (=> d!161 (= lt!91 e!970)))

(declare-fun c!931 () Bool)

(assert (=> d!161 (= c!931 ((_ is IntegerLiteral!15) (s!69 expr!7)))))

(assert (=> d!161 (= (complexity!0 (s!69 expr!7)) lt!91)))

(declare-fun bm!1534 () Bool)

(assert (=> bm!1534 (= call!1547 call!1539)))

(declare-fun bm!1541 () Bool)

(assert (=> bm!1541 (= call!1536 call!1550)))

(declare-fun b!1904 () Bool)

(declare-fun c!927 () Bool)

(assert (=> b!1904 (= c!927 ((_ is GreaterThan!15) (s!69 expr!7)))))

(assert (=> b!1904 (= e!969 e!972)))

(declare-fun b!1905 () Bool)

(assert (=> b!1905 (= e!967 (+ 1 call!1550 call!1537))))

(declare-fun bm!1542 () Bool)

(assert (=> bm!1542 (= call!1542 call!1538)))

(declare-fun b!1906 () Bool)

(assert (=> b!1906 (= e!968 (+ 1 call!1539 call!1537 call!1536))))

(declare-fun b!1907 () Bool)

(assert (=> b!1907 (= e!972 e!971)))

(declare-fun c!922 () Bool)

(assert (=> b!1907 (= c!922 ((_ is LessEquals!15) (s!69 expr!7)))))

(declare-fun bm!1543 () Bool)

(assert (=> bm!1543 (= call!1544 call!1543)))

(declare-fun bm!1544 () Bool)

(declare-fun c!928 () Bool)

(assert (=> bm!1544 (= call!1546 (complexity!0 (ite c!923 (lhs!279 (s!69 expr!7)) (ite c!929 (lhs!277 (s!69 expr!7)) (ite c!925 (s!69 (s!69 expr!7)) (ite c!926 (lhs!276 (s!69 expr!7)) (ite c!928 (base!39 (s!69 expr!7)) (ite c!930 (rhs!274 (s!69 expr!7)) (ite c!927 (rhs!273 (s!69 expr!7)) (ite c!922 (lhs!278 (s!69 expr!7)) (lhs!275 (s!69 expr!7))))))))))))))

(declare-fun c!924 () Bool)

(declare-fun bm!1545 () Bool)

(assert (=> bm!1545 (= call!1545 (complexity!0 (ite c!923 (rhs!279 (s!69 expr!7)) (ite c!924 (expr!101 (s!69 expr!7)) (ite c!925 (fac1!39 (s!69 expr!7)) (ite c!926 (rhs!276 (s!69 expr!7)) (ite c!930 (lhs!274 (s!69 expr!7)) (ite c!927 (lhs!273 (s!69 expr!7)) (ite c!922 (rhs!278 (s!69 expr!7)) (rhs!275 (s!69 expr!7)))))))))))))

(declare-fun b!1908 () Bool)

(assert (=> b!1908 (= c!928 ((_ is IntPow!15) (s!69 expr!7)))))

(assert (=> b!1908 (= e!966 e!974)))

(declare-fun b!1909 () Bool)

(assert (=> b!1909 (= e!973 (+ 1 call!1546 call!1545))))

(declare-fun bm!1546 () Bool)

(assert (=> bm!1546 (= call!1549 call!1547)))

(declare-fun b!1910 () Bool)

(assert (=> b!1910 (= e!974 (+ 1 call!1542))))

(declare-fun bm!1547 () Bool)

(assert (=> bm!1547 (= call!1548 call!1549)))

(declare-fun b!1911 () Bool)

(assert (=> b!1911 (= c!924 ((_ is UMinus!15) (s!69 expr!7)))))

(assert (=> b!1911 (= e!973 e!965)))

(assert (= (and d!161 c!931) b!1898))

(assert (= (and d!161 (not c!931)) b!1899))

(assert (= (and b!1899 c!923) b!1909))

(assert (= (and b!1899 (not c!923)) b!1911))

(assert (= (and b!1911 c!924) b!1902))

(assert (= (and b!1911 (not c!924)) b!1895))

(assert (= (and b!1895 c!929) b!1905))

(assert (= (and b!1895 (not c!929)) b!1903))

(assert (= (and b!1903 c!925) b!1906))

(assert (= (and b!1903 (not c!925)) b!1896))

(assert (= (and b!1896 c!926) b!1901))

(assert (= (and b!1896 (not c!926)) b!1908))

(assert (= (and b!1908 c!928) b!1910))

(assert (= (and b!1908 (not c!928)) b!1893))

(assert (= (and b!1893 c!930) b!1897))

(assert (= (and b!1893 (not c!930)) b!1904))

(assert (= (and b!1904 c!927) b!1900))

(assert (= (and b!1904 (not c!927)) b!1907))

(assert (= (and b!1907 c!922) b!1892))

(assert (= (and b!1907 (not c!922)) b!1894))

(assert (= (or b!1892 b!1894) bm!1533))

(assert (= (or b!1892 b!1894) bm!1540))

(assert (= (or b!1900 bm!1540) bm!1543))

(assert (= (or b!1900 bm!1533) bm!1547))

(assert (= (or b!1897 bm!1547) bm!1546))

(assert (= (or b!1897 bm!1543) bm!1535))

(assert (= (or b!1910 bm!1535) bm!1542))

(assert (= (or b!1901 bm!1542) bm!1536))

(assert (= (or b!1901 bm!1546) bm!1534))

(assert (= (or b!1906 bm!1534) bm!1537))

(assert (= (or b!1906 bm!1536) bm!1541))

(assert (= (or b!1905 b!1906) bm!1532))

(assert (= (or b!1905 bm!1541) bm!1539))

(assert (= (or b!1902 bm!1537) bm!1538))

(assert (= (or b!1909 bm!1538) bm!1545))

(assert (= (or b!1909 bm!1539) bm!1544))

(declare-fun m!567 () Bool)

(assert (=> bm!1532 m!567))

(declare-fun m!569 () Bool)

(assert (=> bm!1544 m!569))

(declare-fun m!571 () Bool)

(assert (=> bm!1545 m!571))

(assert (=> b!1811 d!161))

(check-sat (not bm!1512) (not bm!1500) (not bm!1513) (not bm!1528) (not bm!1544) (not bm!1532) (not bm!1529) (not bm!1516) (not bm!1545))
(check-sat)
