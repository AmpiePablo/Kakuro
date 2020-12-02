

spacegen(N, M) :-
    spacegen_tophalf(N, M),
    spacegen_reflect(N, M),
    spacegen_middle(N, M),
    spacegen_midreflect(N, M),
    fixlonghorizontal(N, M),
    fixlongvertical(N, M),
    fixlongmidhorizontal(N, M),
    fixlongmidvertical(N, M).


spacegen_tophalf(N, M) :-
    Nhf is N div 2,
    Mm1 is M-1,
    spacegen_tophalf(1, 1, Nhf, Mm1).

spacegen_tophalf(I, J, Nhf, Mm1) :-
    I =:= Nhf;
    (   J =:= Mm1
    ->  I1 is I+1,
        spacegen_tophalf(I1, 1, Nhf, Mm1)
    );
    random(R), I1 is I+1, J1 is J+1,
    (   R < 0.3
    ->  makeblank(I, J),
        makeblank(I1, J),
        makeblank(I, J1),
        makeblank(I1, J1)
    ;   true
    ),
    spacegen_tophalf(I, J1, Nhf, Mm1).


spacegen_reflect(N, M) :-
    Nhf1 is N div 2 + 1,
    spacegen_reflect(1, 1, N, Nhf1, M).

spacegen_reflect(I, J, N, Nhf1, M) :-
    I =:= Nhf1;
    (   J =:= M
    ->  I1 is I+1,
        spacegen_reflect(I1, 1, N, Nhf1, M)
    );
    (   blank(I,J)
    ->  Ni is N-I,
        Mj is M-J,
        makeblank(Ni, Mj)
    ;   true
    ),
    J1 is J+1,
    spacegen_reflect(I, J1, N, Nhf1, M).


spacegen_middle(N, M) :-
    odd(N) ->
    (   I is N div 2,
        I1 is I+1,
        Mhf1 is M div 2 + 1,
        spacegen_middle(I, I1, 1, Mhf1)
    );
    true.
spacegen_middle(I, I1, J, Mhf1) :-
    J =:= Mhf1;
    random(R), J1 is J+1,
    (   R < 0.3
    ->  makeblank(I, J),
        makeblank(I1, J),
        makeblank(I, J1),
        makeblank(I1, J1)
    ;   true
    ),
    spacegen_middle(I, I1, J1, Mhf1).


odd(X) :- X /\ 1 =:= 1.


spacegen_midreflect(N, M) :-
    I is N div 2,
    Mhf1 is M div 2 + 1,
    spacegen_midreflect(I, 1, N, M, Mhf1).

spacegen_midreflect(I, J, N, M, Mhf1) :-
    J =:= Mhf1;
    Ni is N-I, Mj is M-J,
    (   blank(Ni, J)
    ->  makeblank(I, Mj)
    ;   true
    ),
    (   blank(I, J)
    ->  makeblank(Ni, Mj)
    ;   true
    ),
    J1 is J+1,
    spacegen_midreflect(I, J1, N, M, Mhf1).


fixlonghorizontal(N, M) :-
    Nhf is N div 2,
    fixlonghorizontal(2, 1, M, N, M, Nhf).

fixlonghorizontal(I, J, Gs, N, M, Nhf) :-
    I =:= Nhf;
    (   J =:= M
    ->  I1 is I+1,
        fixlonghorizontal(I1, 1, M, N, M, Nhf)
    );
    (   blank(I, J)
    ->  (   Gs =:= M
        ->  Ags is J
        ;   Ags is Gs
        )
    ;   Ags is M
    ),
    J1 is J+1,
    (   J-Ags+1 > 9
    ->  Low is Ags+2, High is J-2,
        random(Low, High, RC),
        makesolid(I, RC),
        check1ss(I, RC),
        On is N-I, Om is M-RC,
        makesolid(On, Om),
        check1ss(On, Om),
        fixlonghorizontal(I, J1, RC+1, N, M, Nhf)
    ;   fixlonghorizontal(I, J1, Ags, N, M, Nhf)
    ).



fixlongvertical(N, M) :-
    Mhf is M div 2,
    fixlongvertical(2, 1, N, N, M, Mhf).

fixlongvertical(I, J, Gs, N, M, Mhf) :-
    J =:= Mhf;
    (   I =:= M
    ->  J1 is J+1,
        fixlongvertical(1, J1, N, N, M, Mhf)
    );
    (   blank(I, J)
    ->  (   Gs =:= N
        ->  Ags is I
        ;   Ags is Gs
        )
    ;   Ags is N
    ),
    I1 is I+1,
    (   I-Ags+1 > 9
    ->  Low is Ags+2, High is I-2,
        random(Low, High, RR),
        makesolid(RR, J),
        check1ss(RR, J),
        On is N-RR, Om is M-J,
        makesolid(On, Om),
        check1ss(On, Om),
        fixlongvertical(I1, J, RR+1, N, M, Mhf)
    ;   fixlongvertical(I1, J, Ags, N, M, Mhf)
    ).



fixlongmidhorizontal(N, M) :-
    Nhf is N div 2,
    NhfC1 is N - Nhf + 1,
    Mhf1 is M div 2 + 1,
    fixlongmidhorizontal(Nhf, 1, M, N, M, NhfC1, Mhf1).

fixlongmidhorizontal(I, J, Gs, N, M, NhfC1, Mhf1) :-
    I =:= NhfC1;
    (   J =:= Mhf1
    ->  I1 is I+1,
        fixlongmidhorizontal(I1, 1, M, N, M, NhfC1, Mhf1)
    );
    (   blank(I, J)
    ->  (   Gs =:= M
        ->  Ags is J
        ;   Ags is Gs
        )
    ;   Ags is M
    ),
    J1 is J+1,
    (   J-Ags+1 >= 5
    ->  RC is Ags+2,
        makesolid(I, RC),
        check1ss(I, RC),
        On is N-I, Om is M-RC,
        makesolid(On, Om),
        check1ss(On, Om),
        fixlongmidhorizontal(I, J1, RC+1, N, M, NhfC1, Mhf1)
    ;   fixlongmidhorizontal(I, J1, Ags, N, M, NhfC1, Mhf1)
    ).



fixlongmidvertical(N, M) :-
    Mhf is M div 2,
    MhfC1 is M - Mhf + 1,
    Nhf1 is N div 2 + 1,
    fixlongmidvertical(1, Mhf, N, N, M, MhfC1, Nhf1).

fixlongmidvertical(I, J, Gs, N, M, MhfC1, Nhf1) :-
    J =:= MhfC1;
    (   I =:= Nhf1
    ->  J1 is J+1,
        fixlongmidvertical(1, J1, N, N, M, MhfC1, Nhf1)
    );
    (   blank(I, J)
    ->  (   Gs =:= N
        ->  Ags is I
        ;   Ags is Gs
        )
    ;   Ags is N
    ),
    I1 is I+1,
    (   I-Ags+1 >= 5
    ->  RR is Ags+2,
        makesolid(RR, J),
        check1ss(RR, J),
        On is N-RR, Om is M-J,
        makesolid(On, Om),
        check1ss(On, Om),
        fixlongmidvertical(I1, J, RR+1, N, M, MhfC1, Nhf1)
    ;   fixlongmidvertical(I1, J, Ags, N, M, MhfC1, Nhf1)
    ).


makeblank(I, J) :- \+ blank(I, J) -> assert(blank(I, J)); true.

makesolid(I, J) :- blank(I, J) -> retract(blank(I, J)); true.


check1ss(I, J) :-
    Im1 is I-1, Im2 is I-2, Ip1 is I+1, Ip2 is I+2,
    Jm1 is J-1, Jm2 is J-2, Jp1 is J+1, Jp2 is J+2,

    (   (   blank(Im1, J), \+ blank(Im2, J) )
    ->  (   makesolid(Im1, J), check1ss(Im1, J) )
    ;   true
    ),

    (   (   blank(Ip1, J), \+ blank(Ip2, J) )
    ->  (   makesolid(Ip1, J), check1ss(Ip1, J) )
    ;   true
    ),

    (   (   blank(I, Jm1), \+ blank(I, Jm2))
    ->  (   makesolid(I, Jm1), check1ss(I, Jm2) )
    ;   true
    ),

    (   (   blank(I, Jp1), \+ blank(I, Jp2))
    ->  (   makesolid(I, Jp1), check1ss(I, Jp2) )
    ;   true
    ).


printspaces(N, M) :-
    printspaces(0, 0, N, M).

printspaces(I, J, N, M) :-
    I =:= N;
    J =:= M ->
    (   nl, I1 is I+1,
        printspaces(I1, 0, N, M)
    );
    (
        (   blank(I, J)
        ->  write('   ')
        ;   write(' B ')
        ),
        J1 is J+1,
        printspaces(I, J1, N, M)
    ).


reset(N, M) :-
    reset(0, 0, N, M).

reset(I, J, N, M) :-
    I =:= N;
    (   J =:= M
    ->  I1 is I+1,
        reset(I1, 0, N, M)
    );
    (   makesolid(I, J),
        (   desasignar(I, J); true),
        J1 is J+1,
        reset(I, J1, N, M)
    ).


/****************************************************
 *                 definir solución
 ****************************************************/

enqueue(Qname, T) :-
    (   tail(Qname, R)
    ->  retract(tail(Qname, R)),
        assert(next(Qname, R, T))
    ;   assert(head(Qname, T))
    ),
    assert(tail(Qname, T)).

unenqueue(Qname, R) :-
    tail(Qname, R),
    retract(tail(Qname, R)),
    (   head(Qname, R)
    ->  retract(head(Qname, R))
    ;   next(Qname, S, R),
        assert(tail(Qname, S))
    ).

dequeue(Qname, R) :-
    head(Qname, R),
    retract(head(Qname, R)),
    (   tail(Qname, R)
    ->  retract(tail(Qname, R))
    ;   next(Qname, R, S),
        assert(head(Qname, S))
    ).

undequeue(Qname, H) :-
    (   head(Qname, R)
    ->  retract(head(Qname, R)),
        assert(next(Qname, H, R))
    ;   assert(tail(Qname, H))
    ),
    assert(head(Qname, H)).

empty(Qname) :-
    \+ head(Qname, _).


setrestrictions(I, J, [H|T]) :-
    retract(restrictions(I, J, _)),
    assert(restrictions(I, J, [H|T]));
    assert(restrictions(I, J, [H|T])).


ismarked(Sq) :-
    marked(Sq).

mark(Sq) :-
    retract(marked(Sq)),
    assert(marked(Sq));
    assert(marked(Sq)).

unmark(Sq) :-
    retract(marked(Sq));
    true.

sum(L, R) :-
    (   [H|T] = L
    ->  sum(T, S),
        R is H+S
    ;   R is 0
    ).


shuffle(L, R) :-
    length(L, Len),
    Len1 is Len + 1,
    shuffle(L, Len1, R).

shuffle(L, Len, R) :-
    (   Len > 2
    ->  random(1, Len, Chosen),
        extract(L, Chosen, RL, RE),
        NLen is Len - 1,
        shuffle(RL, NLen, S),
        R = [RE|S]
    ;   R = L
    ).

extract(L, I, RL, RE) :-
    (   [H|T] = L
    ->  (   I =:= 1
        ->  RE is H,
            RL = T
        ;   Im1 is I - 1,
            extract(T, Im1, RLR, RE),
            RL = [H | RLR]
        )
    ;   RL = []
    ).


addrestrictiontosquares(Res, Sqs) :-
    [[SqI, SqJ] | SqsT] = Sqs,
    restrictions(SqI, SqJ, PRes),
    setrestrictions(SqI, SqJ, [Res|PRes]),
    addrestrictiontosquares(Res, SqsT).


generatenumbercombos(N, Res, R) :-
    lowestnpossible(N, Res, Com),
    reverse(Com, RCom),
    (   N =:= 1
    ->  generate1combos(Res, R)
    ;   checknextcombo(0, RCom, N, Res, S),
        R = [Com | S]
    ).


lowestnpossible(N, Res, R) :-
    lowestnpossible(1, N, Res, R).

lowestnpossible(C, N, Res, R) :-
    (   N =:= 0
    ->  R = []
    ;   C =< 9,
        C1 is C+1,
        (   member(C, Res)
        ->  lowestnpossible(C1, N, Res, R)
        ;   Nm1 is N-1,
            lowestnpossible(C1, Nm1, Res, S),
            R = [C | S]
        )
    ).


generate1combos(Res, R) :-
    generate1combos(1, Res, R).

generate1combos(C, Res, R) :-
    (   C > 9
    ->  R = []
    ;   C1 is C + 1,
        generate1combos(C1, Res, S),
        (   member(C, Res)
        ->  R = S
        ;   R = [[C]|S]
        )
    ).


checknextcombo(Carr, Com, N, Res, R) :-
    (   Carr >= N
    ->  R = []
    ;   checknextcomboinc(Carr, Com, N, Res, Coms1),
        Carr1 is Carr + 1,
        checknextcombo(Carr1, Com, N, Res, Coms2),
        append(Coms1, Coms2, R)
    ).


checknextcomboinc(Carr, Com, N, Res, R) :-
    (   increment(Com, Carr, Res, NCom)
    ->  (   iscomboreplicable(NCom, N, Res)
        ->  R = []
        ;   checknextcomboinc(Carr, NCom, N, Res, S),
            R = [NCom | S]
        )
    ;   R = []
    ).


increment(Com, Carr, Res, R) :-
    (   Carr < 0
    ->  R = Com
    ;   [ComH | ComT] = Com,
        nextincrement(ComH, Res, Inc),
        Carrm1 is Carr - 1,
        increment(ComT, Carrm1, Res, RT),
        R = [Inc | RT]
    ).


nextincrement(N, Res, R) :-
    N1 is N + 1,
    N1 =< 9,
    (   member(N1, Res)
    ->  nextincrement(N1, Res, R)
    ;   R is N1
    ).


iscomboreplicable(Com, N, Res) :-
    reverse(Com, RCom),
    MaxX is (9 - N) div 2,
    [_ | ComB] = RCom,
    testnextpair(MaxX, RCom, ComB, Res, []).


testnextpair(MaxX, ComA, ComB, Res, PRes) :-
    (   [_] = ComA
    ->  false
    ;   [A | ARest] = ComA,
        (   ComB == []
        ->  [_ , NXBRest] = ARest,
            union(PRes, [A], NXPRes),
            testnextpair(MaxX, ARest, NXBRest, Res, NXPRes)
        ;   [B | BRest] = ComB,
            (   ispairreplicable(MaxX, A, B, Res, PRes, BRest)
            ;   union(PRes, [B], NXPRes),
                testnextpair(MaxX, ComA, BRest, Res, NXPRes)
            )
        )
    ).


ispairreplicable(MaxX, A, B, Res, PRes, RRes) :-
    testnextx(1, MaxX, A, B, Res, PRes, RRes).

testnextx(X, MaxX, A, B, Res, PRes, RRes) :-
    \+  (X > MaxX; A-X < 1; B+X > 9),
    (   AmX is A-X, BpX is B+X,
        (member(AmX, Res); member(AmX, PRes); member(AmX, RRes);
         member(BpX, Res); member(BpX, PRes); member(BpX, RRes))
    ->  X1 is X + 1,
        testnextx(X1, MaxX, A, B, Res, PRes, RRes)
    ;   true
    ).


definenextrow() :-
    empty(rows), empty(columns);

    (   dequeue(rows, CR)
    ->  (   definenextrowsquare(CR)
        ;   undequeue(rows, CR),
            false
        )
    ;   definenextcolumn()
    ).


definenextrowsquare(CR) :-
    [I, J] = CR,
    definenextrowsquare(CR, I, J, []).

definenextrowsquare(CR, I, J, WRes) :-
    (   \+ blank(I, J)
    ->  definethisrow(CR, WRes)
    ;   (   restrictions(I, J, Res)
        ->  shuffle(Res, SRes),
            (   trynextrowsquarerestriction(I, J, SRes, CR)
            ;   setrestrictions(I, J, Res),
                false
            )
        ;   J1 is J + 1,
            definenextrowsquare(CR, I, J1, WRes)
        )
    ).


trynextrowsquarerestriction(I, J, Res, CR) :-
    getcolumn(I, J, CC),
    trynextrowsquarerestriction(I, J, Res, [], CR, CC).

trynextrowsquarerestriction(I, J, Res, WRes, CR, CC) :-
    [ResH | ResT] = Res,
    (   (   columnhasexclusiverestriction(CC, I, ResH)
        ;   member(ResH, WRes)
        )
    ->  trynextrowsquarerestriction(I, J, ResT, WRes, CR, CC)
    ;   setrestrictions(I, J, [ResH]),
        (   ismarked(CC)
        ->  removerestrictionfromcolumn(CC, I, ResH, Sqs),
            PrevMarked = true
        ;   mark(CC),
            enqueue(columns, CC),
            PrevMarked = false
        ),
        J1 is J+1,
        definenextrowsquare(CR, I, J1, WRes);
        (   PrevMarked
        ->  addrestrictiontosquares(ResH, Sqs)
        ;   unenqueue(columns, CC),
            unmark(CC)
        ),
        trynextrowsquarerestriction(I, J, ResT, [ResH|WRes], CR, CC)
    ).


getcolumn(I, J, RC) :-
    (   \+ blank(I, J)
    ->  RC = [I, J]
    ;   Im1 is I - 1,
        getcolumn(Im1, J, RC)
    ).


columnhasexclusiverestriction([I, J], ExI, Res) :-
    I1 is I + 1,
    columnhasexclusiverestriction(I1, J, ExI, Res).

columnhasexclusiverestriction(I, J, ExI, Res) :-
    (   blank(I, J)
    ->  (
            I =:= ExI
        ->  I1 is I+1,
            columnhasexclusiverestriction(I1, J, ExI, Res)
        ;   (
                restrictions(I, J, CRes),
                [A] = CRes,
                A =:= Res
            ;   I1 is I + 1,
                columnhasexclusiverestriction(I1, J, ExI, Res)
            )
        )
    ).


removerestrictionfromcolumn([I, J], ExI, Res, Sqs) :-
    I1 is I + 1,
    removerestrictionfromcolumn(I1, J, ExI, Res, [], Sqs).

removerestrictionfromcolumn(I, J, ExI, Res, CSqs, Sqs) :-
    (   \+ blank(I, J)
    ->  Sqs = CSqs
    ;   (
            I1 is I+1,
            I =:= ExI
        ->  removerestrictionfromcolumn(I1, J, ExI, Res, CSqs, Sqs)
        ;   restrictions(I, J, CRes),
            (   member(Res, CRes)
            ->  subtract(CRes, [Res], NRes),
                setrestrictions(I, J, NRes),
                removerestrictionfromcolumn(I1, J, ExI, Res, [[I,J]|CSqs], Sqs)
            ;   removerestrictionfromcolumn(I1, J, ExI, Res, CSqs, Sqs)
            )
            ;   removerestrictionfromcolumn(I1, J, ExI, Res, CSqs, Sqs)
        )
    ).


definethisrow(CR, WRes) :-
    rowlength(CR, Len),
    generatenumbercombos(Len, WRes, Com),
    shuffle(Com, SCom),
    sum(WRes, RSum),
    trynextrowcombo(CR, SCom, RSum).


rowlength([I, J], R) :-
    J1 is J + 1,
    rowlength(I, J1, R).

rowlength(I, J, R) :-
    (   \+ blank(I, J)
    ->  R is 0
    ;   J1 is J + 1,
        rowlength(I, J1, S),
        R is S + 1
    ).


trynextrowcombo(CR, Com, RSum) :-
    [ComH | ComT] is Com,
    setrestrictionsrow(CR, ComH),
    sum(ComH, CSum),
    TSum is CSum + RSum,
    setrowhint(CR, TSum),
    (   definenextcolumn()
    ;   removerowhint(CR),
        removerestrictionsrow(CR, ComH),
        trynextrowcombo(CR, ComT, RSum)
    ).


setrestrictionsrow([I, J], Com) :-
    J1 is J + 1,
    setrestrictionsrow(I, J1, Com).

setrestrictionsrow(I, J, Com) :-
    (   \+ blank(I, J)
    ;   (   restrictions(I, J, _)
        ;   setrestrictions(I, J, Com)
        ),
        J1 is J + 1,
        setrestrictionsrow(I, J1, Com)
    ).


setrowhint(Sq, Hint) :-
    retract(rowhint(Sq, _)),
    assert(rowhint(Sq, Hint));
    assert(rowhint(Sq, Hint)).

removerowhint(Sq) :-
    retract(rowhint(Sq, _)).


removerestrictionsrow([I, J], Com) :-
    J1 is J + 1,
    removerestrictionsrow(I, J1, Com).

removerestrictionsrow(I, J, Com) :-
    (   \+ blank(I, J)
    ;   (   restrictions(I, J, Com)
        ->  retract(restrictions(I, J, Com))
        ;   true
        ),
        J1 is J + 1,
        removerestrictionsrow(I, J1, Com)
    ).


/* columns */


definenextcolumn() :-
    (   dequeue(columns, CC)
    ->  (   definenextcolumnsquare(CC)
        ;   undequeue(columns, CC),
            false
        )
    ;   definenextrow()
    ).


definenextcolumnsquare(CC) :-
    [I, J] = CC,
    definenextcolumnsquare(CC, I, J, []).

definenextcolumnsquare(CC, I, J, WRes) :-
    (   \+ blank(I, J)
    ->  definethiscolumn(CC, WRes)
    ;   (   restrictions(I, J, Res)
        ->  shuffle(Res, SRes),
            (   trynextcolumnsquarerestriction(I, J, SRes, CC)
            ;   setrestrictions(I, J, Res),
                false
            )
        ;   I1 is I + 1,
            definenextcolumnsquare(CC, I1, J, WRes)
        )
    ).


trynextcolumnsquarerestriction(I, J, Res, CC) :-
    getrow(I, J, CR),
    trynextcolumnsquarerestriction(I, J, Res, [], CC, CR).

trynextcolumnsquarerestriction(I, J, Res, WRes, CC, CR) :-
    [ResH | ResT] = Res,
    (   (   rowhasexclusiverestriction(CR, J, ResH)
        ;   member(ResH, WRes)
        )
    ->  trynextcolumnsquarerestriction(I, J, ResT, WRes, CC, CR)
    ;   setrestrictions(I, J, [ResH]),
        (   ismarked(CR)
        ->  removerestrictionfromrow(CR, J, ResH, Sqs),
            PrevMarked = true
        ;   mark(CR),
            enqueue(rows, CR),
            PrevMarked = false
        ),
        I1 is I+1,
        definenextcolumnsquare(CC, I1, J, WRes);
        (   PrevMarked
        ->  addrestrictiontosquares(ResH, Sqs)
        ;   unenqueue(rows, CR),
            unmark(CR)
        ),
        trynextcolumnsquarerestriction(I, J, ResT, [ResH|WRes], CC, CR)
    ).


getrow(I, J, RR) :-
    (   \+ blank(I, J)
    ->  RR = [I, J]
    ;   Jm1 is J - 1,
        getrow(I, Jm1, RR)
    ).


rowhasexclusiverestriction([I, J], ExJ, Res) :-
    J1 is J + 1,
    rowhasexclusiverestriction(I, J1, ExJ, Res).

rowhasexclusiverestriction(I, J, ExJ, Res) :-
    (   blank(I, J)
    ->  (
            J =:= ExJ
        ->  J1 is J+1,
            rowhasexclusiverestriction(I, J1, ExJ, Res)
        ;   (
                restrictions(I, J, CRes),
                [A] = CRes,
                A =:= Res
            ;   J1 is J + 1,
                columnhasexclusiverestriction(I, J1, ExJ, Res)
            )
        )
    ).


removerestrictionfromrow([I, J], ExJ, Res, Sqs) :-
    J1 is J + 1,
    removerestrictionfromrow(I, J1, ExJ, Res, [], Sqs).

removerestrictionfromrow(I, J, ExJ, Res, CSqs, Sqs) :-
    (   \+ blank(I, J)
    ->  Sqs = CSqs
    ;   (
            J1 is J+1,
            J =:= ExJ
        ->  removerestrictionfromrow(I, J1, ExJ, Res, CSqs, Sqs)
        ;   restrictions(I, J, CRes),
            (   member(Res, CRes)
            ->  subtract(CRes, [Res], NRes),
                setrestrictions(I, J, NRes),
                removerestrictionfromcolumn(I, J1, ExJ, Res, [[I,J]|CSqs], Sqs)
            ;   removerestrictionfromcolumn(I, J1, ExJ, Res, CSqs, Sqs)
            )
            ;   removerestrictionfromcolumn(I, J1, ExJ, Res, CSqs, Sqs)
        )
    ).


definethiscolumn(CC, WRes) :-
    columnlength(CC, Len),
    generatenumbercombos(Len, WRes, Com),
    shuffle(Com, SCom),
    sum(WRes, RSum),
    trynextcolumncombo(CC, SCom, RSum).


columnlength([I, J], R) :-
    I1 is I + 1,
    columnlength(I1, J, R).

columnlength(I, J, R) :-
    (   \+ blank(I, J)
    ->  R is 0
    ;   I1 is I + 1,
        columnlength(I1, J, S),
        R is S + 1
    ).


trynextcolumncombo(CC, Com, RSum) :-
    [ComH | ComT] is Com,
    setrestrictionscolumn(CC, ComH),
    sum(ComH, CSum),
    TSum is CSum + RSum,
    setcolumnhint(CC, TSum),
    (   definenextrow()
    ;   removecolumnhint(CC),
        removerestrictionscolumn(CC, ComH),
        trynextcolumncombo(CC, ComT, RSum)
    ).


setrestrictionscolumn([I, J], Com) :-
    I1 is I + 1,
    setrestrictionscolumn(I1, J, Com).

setrestrictionscolumn(I, J, Com) :-
    (   \+ blank(I, J)
    ;   (   restrictions(I, J, _)
        ;   setrestrictions(I, J, Com)
        ),
        I1 is I + 1,
        setrestrictionsrow(I1, J, Com)
    ).


setcolumnhint(Sq, Hint) :-
    retract(columnhint(Sq, _)),
    assert(columnhint(Sq, Hint));
    assert(columnhint(Sq, Hint)).

removecolumnhint(Sq) :-
    retract(columnhint(Sq, _)).


removerestrictionscolumn([I, J], Com) :-
    I1 is I + 1,
    removerestrictionscolumn(I1, J, Com).

removerestrictionscolumn(I, J, Com) :-
    (   \+ blank(I, J)
    ;   (   restrictions(I, J, Com)
        ->  retract(restrictions(I, J, Com))
        ;   true
        ),
        I1 is I + 1,
        removerestrictionscolumn(I1, J, Com)
    ).


/*
 ********************************************
 *             EL  PLAN   B
 ********************************************
 */

asignar(I, J, N) :-
    retract(num(I, J, _)),
    assert(num(I, J, N));
    assert(num(I, J, N)).

desasignar(I, J) :-
    retract(num(I, J, _)).

range(I, F, R) :-
    (   I > F
    ->  R = []
    ;   I1 is I+1,
        range(I1, F, S),
        R = [I | S]
    ).

llenar(N, M) :-
    llenar(1, 1, N, M).

llenar(I, J, N, M) :-
    I =:= N;
    (   J =:= M
    ->  I1 is I+1,
        llenar(I1, 1, N, M)
    ;   (   blank(I, J)
        ->  getcolumn(I, J, Col),
            numsincolumn(Col, ColList),
            getrow(I, J, Row),
            numsinrow(Row, RowList),
            range(1, 9, All),
            subtract(All, ColList, S),
            subtract(S, RowList, Options),
            shuffle(Options, SOptions),
            (   trynextoption(I, J, N, M, SOptions)
            ;   makesolid(I, J),
                check1ss(I, J),
                NmI is N - I, MmJ is M - J,
                makesolid(NmI, MmJ),
                check1ss(NmI, MmJ),
                J1 is J + 1,
                llenar(I, J1, N, M)
            )
        ;   J1 is J + 1,
            llenar(I, J1, N, M)
        )
    ).

trynextoption(I, J, N, M, Options) :-
    (   [OH | OT] = Options
    ->  asignar(I, J, OH),
        J1 is J + 1,
        (   llenar(I, J1, N, M)
        ;   trynextoption(I, J, N, M, OT)
        )
    ;   desasignar(I, J),
        false
    ).


numsincolumn([I, J], R) :-
    I1 is I + 1,
    numsincolumn(I1, J, R).

numsincolumn(I, J, R) :-
    (   \+ blank(I, J)
    ->  R = []
    ;   I1 is I + 1,
        (   num(I, J, N)
        ->  numsincolumn(I1, J, S),
            R = [N | S]
        ;   numsincolumn(I1, J, R)
        )
    ).

columnsum([I, J], R) :-
    numsincolumn([I, J], S),
    sum(S, R).

numsinrow([I, J], R) :-
    J1 is J + 1,
    numsinrow(I, J1, R).

numsinrow(I, J, R) :-
    (   \+ blank(I, J)
    ->  R = []
    ;   J1 is J + 1,
        (   num(I, J, N)
        ->  numsinrow(I, J1, S),
            R = [N | S]
        ;   numsinrow(I, J1, R)
        )
    ).

rowsum([I, J], R) :-
    numsinrow([I, J], S),
    sum(S, R).


printkakuro(N, M) :-
    printkakuro(0, 0, N, M).

printkakuro(I, J, N, M) :-
    I =:= N;
    J =:= M ->
    (   nl, I1 is I+1,
        printkakuro(I1, 0, N, M)
    );
    (
        (   blank(I, J)
        ->  (   num(I, J, Num)
            ->  write(' '),
                write(Num),
                write(' ')
            ;   write(' _ ')
            )
        ;   write('   ')
        ),
        J1 is J+1,
        printkakuro(I, J1, N, M)
    ).



getkakuro(N, M, R) :-
    getkakuro(0, 0, N, M, R).

getkakuro(I, J, N, M, R) :-
    (   I =:= N
    ->  R = []
    ;   (   J =:= M
        ->  I1 is I + 1,
            getkakuro(I1, 0, N, M, R)
        ;   J1 is J + 1,
            getkakuro(I, J1, N, M, S),
            (   blank(I, J)
            ->  num(I, J, Num),
                R = [[Num] | S]
            ;   columnsum([I, J], ColSum),
                rowsum([I, J], RowSum),
                (   (ColSum > 0, RowSum > 0)
                ->  R = [[ColSum, RowSum] | S]
                ;   R = [[] | S]
                )
            )
        )
    ).


generarkakuro(N, M, R) :-
    (   retract(blank(-1,-1)),
        assert(blank(-1,-1))
    ;   assert(blank(-1,-1))
    ),
    (   retract(num(-1,-1,-1)),
        assert(num(-1,-1,-1))
    ;   assert(num(-1,-1,-1))
    ),
    reset(N, M),
    spacegen(N, M),
    llenar(N, M),
    getkakuro(N, M, R).















