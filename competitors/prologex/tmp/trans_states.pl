% States and Subformulae:
% q_1 = eventually(and(and(eventually(on(b1,b2)),and(eventually(on(b2,b3)),eventually(on(b3,b4)))),on(b6,b1)))
% q_2 = and(and(eventually(on(b1,b2)),and(eventually(on(b2,b3)),eventually(on(b3,b4)))),on(b6,b1))
% q_3 = and(eventually(on(b1,b2)),and(eventually(on(b2,b3)),eventually(on(b3,b4))))
% q_4 = and(eventually(on(b2,b3)),eventually(on(b3,b4)))
% q_5 = eventually(on(b3,b4))
% q_6 = eventually(on(b2,b3))
% q_7 = eventually(on(b1,b2))
% q_8 = on(b6,b1)
% q_9 = on(b3,b4)
% q_10 = on(b2,b3)
% q_11 = on(b1,b2)
% q_12 = q_r
% q_13 = q_f
% 
% Goal:eventually(and(and(eventually(on(b1,b2)),and(eventually(on(b2,b3)),eventually(on(b3,b4)))),on(b6,b1)))