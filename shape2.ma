#include(shape2.inc)

[top]
components : tree

[tree]
type : cell
dim : (20, 30)
delay : transport
defaultDelayTime  : 100
border : nowrapped 

neighbors : tree(-1,-1) 	tree(-1,0)		tree(-1,1) 
neighbors : tree(0,-1)  	tree(0,0)		tree(0,1)
neighbors : tree(1,-1)  	tree(1,0)		tree(1,1)


initialvalue : 0

initialrowvalue :  0      000000000000000000000000000000
initialrowvalue :  1      000000000000000000000000000000
initialrowvalue :  2      000000000000000000000000000000
initialrowvalue :  3      000000000000000000000000000000
initialrowvalue :  4      000000000000000000000000000000
initialrowvalue :  5      000000000000000000000000000000
initialrowvalue :  6      000000000000000000000000000000
initialrowvalue :  7      000000000000000000000000000000
initialrowvalue :  8      000000000000000000000000000000
initialrowvalue :  9      000000000000000000000000000000
initialrowvalue : 10      000000000000000000000000000000
initialrowvalue : 11      000000000000000000000000000000
initialrowvalue : 12      000000000000000000000000000000
initialrowvalue : 13      000000000000000000000000000000
initialrowvalue : 14      000000000000000000000000000000
initialrowvalue : 15      000000000000000000000000000000
initialrowvalue : 16      000000000000000000000000000000
initialrowvalue : 17      000000000001000000000000000000
initialrowvalue : 18      000000000000000000000000000000
initialrowvalue : 19      000000000000000000000000000000

localtransition : tree-rule
zone : trunk-rule { (15,11)..(18,11) }
zone : branch-rule { (1,2)..(14,27) }


[trunk-rule]


rule : { 2 } 100 { (0,0) = 0 and (1,0)=1 }
rule : { 2 } 100 { (0,0) = 0 and (1,0)=2 }
rule : {(0,0)} 100 {t}

[branch-rule]

rule : { 3 } 100 { (0,0) = 0 and ( cellPos(1) = #macro(YseedPos) ) and (#macro(XseedPos) - cellPos(0) ) < 8 and ( (1,0) = 2 or (1,0) = 3 ) }
rule : { 3 } 100 { (0,0) = 0 and (1,1) = 3  and (#macro(XseedPos) - cellPos(0) ) > 7 and (#macro(XseedPos) - cellPos(0) ) < 12 and ( cellPos(1) = (#macro(branch1) + cellPos(0) ) ) }
rule : { 3 } 100 { (0,0) = 0 and ( cellPos(1) = #macro(YseedPos) ) and (#macro(XseedPos) - cellPos(0) ) < 12 and (#macro(XseedPos) - cellPos(0) ) > 7 and (1,0) = 3 }
rule : { 3 } 100 { (0,0) = 0 and (1,-1) = 3  and (#macro(XseedPos) - cellPos(0) ) > 11 and (#macro(XseedPos) - cellPos(0) ) < 16 and ( cellPos(1) = (#macro(branch2) + ( 20 - cellPos(0) ) ) ) }
rule : { 3 } 100 { (0,0) = 0 and ( cellPos(1) = #macro(YseedPos) ) and (#macro(XseedPos) - cellPos(0) ) < 16 and (#macro(XseedPos) - cellPos(0) ) > 11 and (1,0) = 3 }
rule : {(0,0)} 100 {t}



[tree-rule]

rule : {(0,0)} 100 {t}
