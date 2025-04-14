; Options: -in -smt2
(set-option :produce-unsat-assumptions true)

(declare-fun start!126 () Bool)

(assert start!126)

(declare-fun res!190 () Bool)

(declare-fun e!1817 () Bool)

(assert (=> start!126 (=> (not res!190) (not e!1817))))

(declare-datatypes ((Expr!27 0))(
  ( (FMA!26 (fac1!50 Expr!27) (fac2!50 Expr!27) (s!91 Expr!27)) (IntegerLiteral!26 (value!99 Int)) (GreaterThan!26 (lhs!350 Expr!27) (rhs!350 Expr!27)) (LessThan!26 (lhs!351 Expr!27) (rhs!351 Expr!27)) (GreaterEquals!26 (lhs!352 Expr!27) (rhs!352 Expr!27)) (UMinus!26 (expr!116 Expr!27)) (IntPow!26 (base!50 Expr!27) (exp!50 Int)) (Division!26 (lhs!353 Expr!27) (rhs!353 Expr!27)) (Times!26 (lhs!354 Expr!27) (rhs!354 Expr!27)) (LessEquals!26 (lhs!355 Expr!27) (rhs!355 Expr!27)) (Minus!26 (lhs!356 Expr!27) (rhs!356 Expr!27)) )
))
(declare-fun expr!7 () Expr!27)

(get-info :version)

(assert (=> start!126 (= res!190 (and (not ((_ is IntegerLiteral!26) expr!7)) (not ((_ is Minus!26) expr!7)) (not ((_ is UMinus!26) expr!7)) (not ((_ is Times!26) expr!7)) (not ((_ is FMA!26) expr!7)) (not ((_ is Division!26) expr!7)) (not ((_ is IntPow!26) expr!7)) (not ((_ is LessThan!26) expr!7)) ((_ is GreaterThan!26) expr!7)))))

(assert (=> start!126 e!1817))

(assert (=> start!126 true))

(declare-fun b!3564 () Bool)

(declare-fun complexity!0 (Expr!27) Int)

(assert (=> b!3564 (= e!1817 (<= (+ 1 (complexity!0 (lhs!350 expr!7)) (complexity!0 (rhs!350 expr!7))) 0))))

(assert (= (and start!126 res!190) b!3564))

(declare-fun m!1089 () Bool)

(assert (=> b!3564 m!1089))

(declare-fun m!1091 () Bool)

(assert (=> b!3564 m!1091))

(check-sat (not b!3564))
(check-sat)
(get-model)

(declare-fun bm!2946 () Bool)

(declare-fun call!2951 () Int)

(declare-fun call!2952 () Int)

(assert (=> bm!2946 (= call!2951 call!2952)))

(declare-fun b!3605 () Bool)

(declare-fun e!1843 () Int)

(declare-fun call!2963 () Int)

(declare-fun call!2954 () Int)

(assert (=> b!3605 (= e!1843 (+ 1 call!2963 call!2954))))

(declare-fun bm!2947 () Bool)

(declare-fun call!2958 () Int)

(declare-fun c!1767 () Bool)

(declare-fun c!1771 () Bool)

(declare-fun c!1769 () Bool)

(declare-fun c!1764 () Bool)

(declare-fun c!1763 () Bool)

(declare-fun c!1766 () Bool)

(declare-fun c!1768 () Bool)

(declare-fun c!1765 () Bool)

(declare-fun c!1770 () Bool)

(assert (=> bm!2947 (= call!2958 (complexity!0 (ite c!1768 (rhs!356 (lhs!350 expr!7)) (ite c!1765 (expr!116 (lhs!350 expr!7)) (ite c!1763 (rhs!354 (lhs!350 expr!7)) (ite c!1766 (s!91 (lhs!350 expr!7)) (ite c!1770 (lhs!353 (lhs!350 expr!7)) (ite c!1769 (base!50 (lhs!350 expr!7)) (ite c!1767 (rhs!351 (lhs!350 expr!7)) (ite c!1764 (rhs!350 (lhs!350 expr!7)) (ite c!1771 (lhs!355 (lhs!350 expr!7)) (lhs!352 (lhs!350 expr!7)))))))))))))))

(declare-fun b!3606 () Bool)

(declare-fun e!1839 () Int)

(declare-fun call!2959 () Int)

(assert (=> b!3606 (= e!1839 (+ 1 call!2959))))

(declare-fun bm!2948 () Bool)

(declare-fun call!2953 () Int)

(declare-fun call!2950 () Int)

(assert (=> bm!2948 (= call!2953 call!2950)))

(declare-fun bm!2949 () Bool)

(declare-fun call!2964 () Int)

(declare-fun call!2962 () Int)

(assert (=> bm!2949 (= call!2964 call!2962)))

(declare-fun bm!2950 () Bool)

(declare-fun call!2956 () Int)

(assert (=> bm!2950 (= call!2952 call!2956)))

(declare-fun b!3607 () Bool)

(declare-fun e!1840 () Int)

(assert (=> b!3607 (= e!1840 1)))

(declare-fun e!1841 () Int)

(declare-fun b!3608 () Bool)

(assert (=> b!3608 (= e!1841 (+ 1 call!2964 (complexity!0 (fac2!50 (lhs!350 expr!7))) call!2952))))

(declare-fun bm!2951 () Bool)

(declare-fun call!2961 () Int)

(assert (=> bm!2951 (= call!2961 call!2964)))

(declare-fun b!3609 () Bool)

(assert (=> b!3609 (= c!1764 ((_ is GreaterThan!26) (lhs!350 expr!7)))))

(declare-fun e!1846 () Int)

(declare-fun e!1838 () Int)

(assert (=> b!3609 (= e!1846 e!1838)))

(declare-fun b!3610 () Bool)

(assert (=> b!3610 (= c!1766 ((_ is FMA!26) (lhs!350 expr!7)))))

(declare-fun e!1842 () Int)

(assert (=> b!3610 (= e!1842 e!1841)))

(declare-fun bm!2952 () Bool)

(declare-fun call!2949 () Int)

(assert (=> bm!2952 (= call!2950 call!2949)))

(declare-fun b!3611 () Bool)

(assert (=> b!3611 (= e!1843 (+ 1 call!2963 call!2954))))

(declare-fun d!313 () Bool)

(declare-fun lt!175 () Int)

(assert (=> d!313 (> lt!175 0)))

(assert (=> d!313 (= lt!175 e!1840)))

(declare-fun c!1762 () Bool)

(assert (=> d!313 (= c!1762 ((_ is IntegerLiteral!26) (lhs!350 expr!7)))))

(assert (=> d!313 (= (complexity!0 (lhs!350 expr!7)) lt!175)))

(declare-fun b!3612 () Bool)

(declare-fun e!1845 () Int)

(assert (=> b!3612 (= e!1845 e!1846)))

(assert (=> b!3612 (= c!1767 ((_ is LessThan!26) (lhs!350 expr!7)))))

(declare-fun bm!2953 () Bool)

(declare-fun call!2957 () Int)

(assert (=> bm!2953 (= call!2957 call!2961)))

(declare-fun bm!2954 () Bool)

(declare-fun call!2960 () Int)

(assert (=> bm!2954 (= call!2962 call!2960)))

(declare-fun b!3613 () Bool)

(declare-fun e!1844 () Int)

(assert (=> b!3613 (= e!1841 e!1844)))

(assert (=> b!3613 (= c!1770 ((_ is Division!26) (lhs!350 expr!7)))))

(declare-fun b!3614 () Bool)

(assert (=> b!3614 (= e!1846 (+ 1 call!2957 call!2950))))

(declare-fun bm!2955 () Bool)

(declare-fun call!2955 () Int)

(assert (=> bm!2955 (= call!2955 call!2957)))

(declare-fun bm!2956 () Bool)

(assert (=> bm!2956 (= call!2949 call!2951)))

(declare-fun b!3615 () Bool)

(assert (=> b!3615 (= e!1838 (+ 1 call!2955 call!2953))))

(declare-fun b!3616 () Bool)

(declare-fun e!1847 () Int)

(assert (=> b!3616 (= e!1847 (+ 1 call!2960 call!2958))))

(declare-fun b!3617 () Bool)

(assert (=> b!3617 (= e!1844 (+ 1 call!2951 call!2961))))

(declare-fun bm!2957 () Bool)

(assert (=> bm!2957 (= call!2956 call!2959)))

(declare-fun bm!2958 () Bool)

(assert (=> bm!2958 (= call!2959 call!2958)))

(declare-fun b!3618 () Bool)

(assert (=> b!3618 (= c!1769 ((_ is IntPow!26) (lhs!350 expr!7)))))

(assert (=> b!3618 (= e!1844 e!1845)))

(declare-fun b!3619 () Bool)

(assert (=> b!3619 (= e!1842 (+ 1 call!2962 call!2956))))

(declare-fun b!3620 () Bool)

(assert (=> b!3620 (= e!1845 (+ 1 call!2949))))

(declare-fun b!3621 () Bool)

(assert (=> b!3621 (= e!1838 e!1843)))

(assert (=> b!3621 (= c!1771 ((_ is LessEquals!26) (lhs!350 expr!7)))))

(declare-fun b!3622 () Bool)

(assert (=> b!3622 (= c!1765 ((_ is UMinus!26) (lhs!350 expr!7)))))

(assert (=> b!3622 (= e!1847 e!1839)))

(declare-fun bm!2959 () Bool)

(assert (=> bm!2959 (= call!2963 call!2953)))

(declare-fun b!3623 () Bool)

(assert (=> b!3623 (= e!1839 e!1842)))

(assert (=> b!3623 (= c!1763 ((_ is Times!26) (lhs!350 expr!7)))))

(declare-fun bm!2960 () Bool)

(assert (=> bm!2960 (= call!2954 call!2955)))

(declare-fun b!3624 () Bool)

(assert (=> b!3624 (= e!1840 e!1847)))

(assert (=> b!3624 (= c!1768 ((_ is Minus!26) (lhs!350 expr!7)))))

(declare-fun bm!2961 () Bool)

(assert (=> bm!2961 (= call!2960 (complexity!0 (ite c!1768 (lhs!356 (lhs!350 expr!7)) (ite c!1763 (lhs!354 (lhs!350 expr!7)) (ite c!1766 (fac1!50 (lhs!350 expr!7)) (ite c!1770 (rhs!353 (lhs!350 expr!7)) (ite c!1767 (lhs!351 (lhs!350 expr!7)) (ite c!1764 (lhs!350 (lhs!350 expr!7)) (ite c!1771 (rhs!355 (lhs!350 expr!7)) (rhs!352 (lhs!350 expr!7)))))))))))))

(assert (= (and d!313 c!1762) b!3607))

(assert (= (and d!313 (not c!1762)) b!3624))

(assert (= (and b!3624 c!1768) b!3616))

(assert (= (and b!3624 (not c!1768)) b!3622))

(assert (= (and b!3622 c!1765) b!3606))

(assert (= (and b!3622 (not c!1765)) b!3623))

(assert (= (and b!3623 c!1763) b!3619))

(assert (= (and b!3623 (not c!1763)) b!3610))

(assert (= (and b!3610 c!1766) b!3608))

(assert (= (and b!3610 (not c!1766)) b!3613))

(assert (= (and b!3613 c!1770) b!3617))

(assert (= (and b!3613 (not c!1770)) b!3618))

(assert (= (and b!3618 c!1769) b!3620))

(assert (= (and b!3618 (not c!1769)) b!3612))

(assert (= (and b!3612 c!1767) b!3614))

(assert (= (and b!3612 (not c!1767)) b!3609))

(assert (= (and b!3609 c!1764) b!3615))

(assert (= (and b!3609 (not c!1764)) b!3621))

(assert (= (and b!3621 c!1771) b!3611))

(assert (= (and b!3621 (not c!1771)) b!3605))

(assert (= (or b!3611 b!3605) bm!2960))

(assert (= (or b!3611 b!3605) bm!2959))

(assert (= (or b!3615 bm!2959) bm!2948))

(assert (= (or b!3615 bm!2960) bm!2955))

(assert (= (or b!3614 bm!2955) bm!2953))

(assert (= (or b!3614 bm!2948) bm!2952))

(assert (= (or b!3620 bm!2952) bm!2956))

(assert (= (or b!3617 bm!2956) bm!2946))

(assert (= (or b!3617 bm!2953) bm!2951))

(assert (= (or b!3608 bm!2951) bm!2949))

(assert (= (or b!3608 bm!2946) bm!2950))

(assert (= (or b!3619 bm!2950) bm!2957))

(assert (= (or b!3619 bm!2949) bm!2954))

(assert (= (or b!3606 bm!2957) bm!2958))

(assert (= (or b!3616 bm!2958) bm!2947))

(assert (= (or b!3616 bm!2954) bm!2961))

(declare-fun m!1093 () Bool)

(assert (=> bm!2947 m!1093))

(declare-fun m!1095 () Bool)

(assert (=> b!3608 m!1095))

(declare-fun m!1097 () Bool)

(assert (=> bm!2961 m!1097))

(assert (=> b!3564 d!313))

(declare-fun bm!2962 () Bool)

(declare-fun call!2967 () Int)

(declare-fun call!2968 () Int)

(assert (=> bm!2962 (= call!2967 call!2968)))

(declare-fun b!3625 () Bool)

(declare-fun e!1853 () Int)

(declare-fun call!2979 () Int)

(declare-fun call!2970 () Int)

(assert (=> b!3625 (= e!1853 (+ 1 call!2979 call!2970))))

(declare-fun c!1778 () Bool)

(declare-fun c!1777 () Bool)

(declare-fun bm!2963 () Bool)

(declare-fun c!1779 () Bool)

(declare-fun call!2974 () Int)

(declare-fun c!1775 () Bool)

(declare-fun c!1781 () Bool)

(declare-fun c!1776 () Bool)

(declare-fun c!1780 () Bool)

(declare-fun c!1773 () Bool)

(declare-fun c!1774 () Bool)

(assert (=> bm!2963 (= call!2974 (complexity!0 (ite c!1778 (rhs!356 (rhs!350 expr!7)) (ite c!1775 (expr!116 (rhs!350 expr!7)) (ite c!1773 (rhs!354 (rhs!350 expr!7)) (ite c!1776 (s!91 (rhs!350 expr!7)) (ite c!1780 (lhs!353 (rhs!350 expr!7)) (ite c!1779 (base!50 (rhs!350 expr!7)) (ite c!1777 (rhs!351 (rhs!350 expr!7)) (ite c!1774 (rhs!350 (rhs!350 expr!7)) (ite c!1781 (lhs!355 (rhs!350 expr!7)) (lhs!352 (rhs!350 expr!7)))))))))))))))

(declare-fun b!3626 () Bool)

(declare-fun e!1849 () Int)

(declare-fun call!2975 () Int)

(assert (=> b!3626 (= e!1849 (+ 1 call!2975))))

(declare-fun bm!2964 () Bool)

(declare-fun call!2969 () Int)

(declare-fun call!2966 () Int)

(assert (=> bm!2964 (= call!2969 call!2966)))

(declare-fun bm!2965 () Bool)

(declare-fun call!2980 () Int)

(declare-fun call!2978 () Int)

(assert (=> bm!2965 (= call!2980 call!2978)))

(declare-fun bm!2966 () Bool)

(declare-fun call!2972 () Int)

(assert (=> bm!2966 (= call!2968 call!2972)))

(declare-fun b!3627 () Bool)

(declare-fun e!1850 () Int)

(assert (=> b!3627 (= e!1850 1)))

(declare-fun b!3628 () Bool)

(declare-fun e!1851 () Int)

(assert (=> b!3628 (= e!1851 (+ 1 call!2980 (complexity!0 (fac2!50 (rhs!350 expr!7))) call!2968))))

(declare-fun bm!2967 () Bool)

(declare-fun call!2977 () Int)

(assert (=> bm!2967 (= call!2977 call!2980)))

(declare-fun b!3629 () Bool)

(assert (=> b!3629 (= c!1774 ((_ is GreaterThan!26) (rhs!350 expr!7)))))

(declare-fun e!1856 () Int)

(declare-fun e!1848 () Int)

(assert (=> b!3629 (= e!1856 e!1848)))

(declare-fun b!3630 () Bool)

(assert (=> b!3630 (= c!1776 ((_ is FMA!26) (rhs!350 expr!7)))))

(declare-fun e!1852 () Int)

(assert (=> b!3630 (= e!1852 e!1851)))

(declare-fun bm!2968 () Bool)

(declare-fun call!2965 () Int)

(assert (=> bm!2968 (= call!2966 call!2965)))

(declare-fun b!3631 () Bool)

(assert (=> b!3631 (= e!1853 (+ 1 call!2979 call!2970))))

(declare-fun d!315 () Bool)

(declare-fun lt!176 () Int)

(assert (=> d!315 (> lt!176 0)))

(assert (=> d!315 (= lt!176 e!1850)))

(declare-fun c!1772 () Bool)

(assert (=> d!315 (= c!1772 ((_ is IntegerLiteral!26) (rhs!350 expr!7)))))

(assert (=> d!315 (= (complexity!0 (rhs!350 expr!7)) lt!176)))

(declare-fun b!3632 () Bool)

(declare-fun e!1855 () Int)

(assert (=> b!3632 (= e!1855 e!1856)))

(assert (=> b!3632 (= c!1777 ((_ is LessThan!26) (rhs!350 expr!7)))))

(declare-fun bm!2969 () Bool)

(declare-fun call!2973 () Int)

(assert (=> bm!2969 (= call!2973 call!2977)))

(declare-fun bm!2970 () Bool)

(declare-fun call!2976 () Int)

(assert (=> bm!2970 (= call!2978 call!2976)))

(declare-fun b!3633 () Bool)

(declare-fun e!1854 () Int)

(assert (=> b!3633 (= e!1851 e!1854)))

(assert (=> b!3633 (= c!1780 ((_ is Division!26) (rhs!350 expr!7)))))

(declare-fun b!3634 () Bool)

(assert (=> b!3634 (= e!1856 (+ 1 call!2973 call!2966))))

(declare-fun bm!2971 () Bool)

(declare-fun call!2971 () Int)

(assert (=> bm!2971 (= call!2971 call!2973)))

(declare-fun bm!2972 () Bool)

(assert (=> bm!2972 (= call!2965 call!2967)))

(declare-fun b!3635 () Bool)

(assert (=> b!3635 (= e!1848 (+ 1 call!2971 call!2969))))

(declare-fun b!3636 () Bool)

(declare-fun e!1857 () Int)

(assert (=> b!3636 (= e!1857 (+ 1 call!2976 call!2974))))

(declare-fun b!3637 () Bool)

(assert (=> b!3637 (= e!1854 (+ 1 call!2967 call!2977))))

(declare-fun bm!2973 () Bool)

(assert (=> bm!2973 (= call!2972 call!2975)))

(declare-fun bm!2974 () Bool)

(assert (=> bm!2974 (= call!2975 call!2974)))

(declare-fun b!3638 () Bool)

(assert (=> b!3638 (= c!1779 ((_ is IntPow!26) (rhs!350 expr!7)))))

(assert (=> b!3638 (= e!1854 e!1855)))

(declare-fun b!3639 () Bool)

(assert (=> b!3639 (= e!1852 (+ 1 call!2978 call!2972))))

(declare-fun b!3640 () Bool)

(assert (=> b!3640 (= e!1855 (+ 1 call!2965))))

(declare-fun b!3641 () Bool)

(assert (=> b!3641 (= e!1848 e!1853)))

(assert (=> b!3641 (= c!1781 ((_ is LessEquals!26) (rhs!350 expr!7)))))

(declare-fun b!3642 () Bool)

(assert (=> b!3642 (= c!1775 ((_ is UMinus!26) (rhs!350 expr!7)))))

(assert (=> b!3642 (= e!1857 e!1849)))

(declare-fun bm!2975 () Bool)

(assert (=> bm!2975 (= call!2979 call!2969)))

(declare-fun b!3643 () Bool)

(assert (=> b!3643 (= e!1849 e!1852)))

(assert (=> b!3643 (= c!1773 ((_ is Times!26) (rhs!350 expr!7)))))

(declare-fun bm!2976 () Bool)

(assert (=> bm!2976 (= call!2970 call!2971)))

(declare-fun b!3644 () Bool)

(assert (=> b!3644 (= e!1850 e!1857)))

(assert (=> b!3644 (= c!1778 ((_ is Minus!26) (rhs!350 expr!7)))))

(declare-fun bm!2977 () Bool)

(assert (=> bm!2977 (= call!2976 (complexity!0 (ite c!1778 (lhs!356 (rhs!350 expr!7)) (ite c!1773 (lhs!354 (rhs!350 expr!7)) (ite c!1776 (fac1!50 (rhs!350 expr!7)) (ite c!1780 (rhs!353 (rhs!350 expr!7)) (ite c!1777 (lhs!351 (rhs!350 expr!7)) (ite c!1774 (lhs!350 (rhs!350 expr!7)) (ite c!1781 (rhs!355 (rhs!350 expr!7)) (rhs!352 (rhs!350 expr!7)))))))))))))

(assert (= (and d!315 c!1772) b!3627))

(assert (= (and d!315 (not c!1772)) b!3644))

(assert (= (and b!3644 c!1778) b!3636))

(assert (= (and b!3644 (not c!1778)) b!3642))

(assert (= (and b!3642 c!1775) b!3626))

(assert (= (and b!3642 (not c!1775)) b!3643))

(assert (= (and b!3643 c!1773) b!3639))

(assert (= (and b!3643 (not c!1773)) b!3630))

(assert (= (and b!3630 c!1776) b!3628))

(assert (= (and b!3630 (not c!1776)) b!3633))

(assert (= (and b!3633 c!1780) b!3637))

(assert (= (and b!3633 (not c!1780)) b!3638))

(assert (= (and b!3638 c!1779) b!3640))

(assert (= (and b!3638 (not c!1779)) b!3632))

(assert (= (and b!3632 c!1777) b!3634))

(assert (= (and b!3632 (not c!1777)) b!3629))

(assert (= (and b!3629 c!1774) b!3635))

(assert (= (and b!3629 (not c!1774)) b!3641))

(assert (= (and b!3641 c!1781) b!3631))

(assert (= (and b!3641 (not c!1781)) b!3625))

(assert (= (or b!3631 b!3625) bm!2976))

(assert (= (or b!3631 b!3625) bm!2975))

(assert (= (or b!3635 bm!2975) bm!2964))

(assert (= (or b!3635 bm!2976) bm!2971))

(assert (= (or b!3634 bm!2971) bm!2969))

(assert (= (or b!3634 bm!2964) bm!2968))

(assert (= (or b!3640 bm!2968) bm!2972))

(assert (= (or b!3637 bm!2972) bm!2962))

(assert (= (or b!3637 bm!2969) bm!2967))

(assert (= (or b!3628 bm!2967) bm!2965))

(assert (= (or b!3628 bm!2962) bm!2966))

(assert (= (or b!3639 bm!2966) bm!2973))

(assert (= (or b!3639 bm!2965) bm!2970))

(assert (= (or b!3626 bm!2973) bm!2974))

(assert (= (or b!3636 bm!2974) bm!2963))

(assert (= (or b!3636 bm!2970) bm!2977))

(declare-fun m!1099 () Bool)

(assert (=> bm!2963 m!1099))

(declare-fun m!1101 () Bool)

(assert (=> b!3628 m!1101))

(declare-fun m!1103 () Bool)

(assert (=> bm!2977 m!1103))

(assert (=> b!3564 d!315))

(check-sat (not b!3628) (not b!3608) (not bm!2977) (not bm!2961) (not bm!2963) (not bm!2947))
(check-sat)
