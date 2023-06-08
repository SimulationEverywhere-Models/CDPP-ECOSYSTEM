#include(shape.inc)

[top]
components : shape plant 
components : generateSeed@Generator generateReSource1@Generator generateReSource2@Generator generateReSource3@Generator
link : out@generateSeed inputSeed@shape
link : out@generateReSource1 inputReSource1@plant
link : out@generateReSource2 inputReSource2@plant
link : out@generateReSource3 inputReSource3@plant


[generateSeed]
distribution : exponential
mean : 3
initial : 2
increment : 0

[generateReSource1]
distribution : exponential
mean : 50
initial : 1
increment : 0

[generateReSource2]
distribution : exponential
mean : 50
initial : 1
increment : 0

[generateReSource3]
distribution : exponential
mean : 50
initial : 1
increment : 0



[plant]
type : cell
dim : (8, 8, 9)
delay : transport
defaultDelayTime  : 1000
border : wrapped 

neighbors : plant(-1,-1,0) 	plant(-1,0,0)	plant(-1,1,0)	
neighbors : plant(0,-1,0)	plant(0,0,0)	plant(0,1,0) 
neighbors : plant(1,-1,0)	plant(1,0,0)	plant(1,1,0)
neighbors : plant(-1,-1,1) 	plant(-1,0,1)	plant(-1,1,1)	
neighbors : plant(0,-1,1)	plant(0,0,1)	plant(0,1,1) 
neighbors : plant(1,-1,1)	plant(1,0,1)	plant(1,1,1)
neighbors : plant(-1,-1,2) 	plant(-1,0,2)	plant(-1,1,2)	
neighbors : plant(0,-1,2)	plant(0,0,2)	plant(0,1,2) 
neighbors : plant(1,-1,2)	plant(1,0,2)	plant(1,1,2)
neighbors : plant(-1,-1,3) 	plant(-1,0,3)	plant(-1,1,3)	
neighbors : plant(0,-1,3)	plant(0,0,3)	plant(0,1,3) 
neighbors : plant(1,-1,3)	plant(1,0,3)	plant(1,1,3)
neighbors : plant(-1,-1,-2) plant(-1,0,-2)	plant(-1,1,-2)	
neighbors : plant(0,-1,-2)	plant(0,0,-2)	plant(0,1,-2) 
neighbors : plant(1,-1,-2)	plant(1,0,-2)	plant(1,1,-2)
neighbors : plant(0,0,-1)	plant(0,0,-2)	plant(0,0,-3)	plant(0,0,-4)
neighbors : plant(0,0,-5)	plant(0,0,-6)	plant(0,0,-7)	plant(0,0,-8)
neighbors : plant(0,0,1)	plant(0,0,2)	plant(0,0,3)	plant(0,0,4)	
neighbors : plant(0,0,5)	plant(0,0,6)	plant(0,0,7)	plant(0,0,8)
%neighbors : plant(-1,-1,5)	plant(-1,0,5)	plant(-1,1,5)		
%neighbors : plant(0,-1,5)	plant(0,0,5)	plant(0,1,5)		
%neighbors : plant(1,-1,5)	plant(1,0,5)	plant(1,1,5)

initialvalue : 0
initialCellsValue : plant.val
%initialCellsValue : plant2.val

in : inputReSource1
in : inputReSource2
in : inputReSource3
link : inputReSource1  in@plant(2,7,6)
link : inputReSource1  in@plant(6,7,7)
link : inputReSource1  in@plant(4,7,8)


localtransition : plant_rule

zone : sunamount { (0,0,6)..(7,6,6) }
zone : mineralamount { (0,0,7)..(7,6,7) }
zone : wateramount { (0,0,8)..(7,6,8) }

zone : addsun { (0,7,6)..(7,7,6) }
zone : addmineral { (0,7,7)..(7,7,7) }
zone : addwater { (0,7,8)..(7,7,8) }

zone : plantage { (0,0,0)..(7,7,0) }
zone : plantheight { (0,0,1)..(7,7,1) }
zone : planttypeproduce { (0,0,2)..(7,7,2) }
zone : graseed { (0,0,3)..(7,7,3) }
zone : oakseed { (0,0,4)..(7,7,4) }
zone : mapleseed { (0,0,5)..(7,7,5) }

portInTransition : in@plant(2,7,6)  setReSource1
portInTransition : in@plant(6,7,7)  setReSource2
portInTransition : in@plant(4,7,8)  setReSource3

[plantage]
%age growth rule for grass 
%maximum grass age is "4" years and resources does not affect aging process
%assume for each year one unit is added to the grass age
rule : { (0,0,0) + 1 } 1000 { (0,0,2) = 1 and (0,0,0) < 4 }
%dead rules for the grass(If minimum resources not available to survive and not to die) 
rule : { 0 } 1000 { (0,0,2) = 1 and ((0,0,0) >= 4 or (0,0,6) < 1 or (0,0,7) < 6 or (0,0,8) < 2 ) }


%age growth rule for oak 
%maximum grass age is "55" years and resources does not affect aging process
%assume for each year one unit is added to the oak age
rule : { (0,0,0) + 1 } 1000 { (0,0,2) = 2 and (0,0,0) < 55 }
%dead rules for the oak (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { (0,0,2) = 2 and ( (0,0,0) >= 55 or (0,0,6) < 2 or (0,0,7) < 8 or (0,0,8) < 6 ) }


%age growth rule for maple 
%maximum grass age is "60" years and resources does not affect aging process
%assume for each year one unit is added to the maple age
rule : { (0,0,0) + 1 } 1000 { (0,0,2) = 3 and (0,0,0) < 60 }
%dead rules for the maple (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { (0,0,2) = 3 and ( (0,0,0) >= 60 or (0,0,6) < 2 or  (0,0,7) < 8 or (0,0,8) < 5 ) }


rule : { (0,0,0) } 1000 { t } 
 

[plantheight]

%growing height rule for the grass
%maximum height for grass is "5cm"
%assume for each year "0.01m"  is added to the grass height and resources affect height growth
%more resources needed to grow than survive
rule : { (0,0,0) + 0.01 } 1000 { (0,0,-1) < 4 and (0,0,1) = 1 and (0,0,0) < 0.05 and (0,0,5) >= 2 and (0,0,6) >= 7 and (0,0,7) >= 4 }
%dead rules for the oak(If minimum resources not available to survive and not to die) 
rule : { 0 } 1000 { ( (0,0,-1) <= 4 or (0,0,5) < 1 or (0,0,6) < 6 or (0,0,7) < 2  or (0,0,0) >= 0.05 ) and (0,0,1) = 1 }


%growing height rule for the oak 
%maximum grass height is "20m"
%assume for each year "0.2m"  is added to the oak height and resources affect height growth
rule : { (0,0,0) + 0.2 } 1000 { (0,0,5) >= 3 and (0,0,6) >= 10 and (0,0,7) >= 7 and (0,0,1) = 2 and (0,0,0) < 20 }
%dead rules for the oak (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { ( (0,0,5) < 2 or (0,0,6) < 8 or (0,0,7) < 6  or (0,0,0) >= 20 ) and (0,0,1) = 2 }


%growing height rule for the maple 
%maximum maple height is "25m"
%assume for each year "0.25m"  is added to the oak height and resources affect height growth
rule : { (0,0,0) + 0.25 } 1000 { (0,0,5) >= 3 and (0,0,6) >= 10 and (0,0,7) >= 6 and (0,0,1) = 3 and (0,0,0) < 25 }
%dead rules for the maple (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { ( (0,0,5) < 2 or (0,0,6) < 8 or (0,0,7) < 5  or (0,0,0) >= 25 ) and (0,0,1) = 3 }

rule : { (0,0,0) } 1000 { t } 
 
[planttypeproduce]

%we assume for the type plat type production the plant must reach certain age to spread the seed to adjanct neighbour
%production age for the grass is "2" for the oak is "5" and for maple "7"
%also the higher probability of survivability of the seed type with higher number is presented
%in case of equal number the priority order is 1-grass 2-oak 3-maple

rule : { 1 } 1000 { (-1,-1,-2) >= 2 and (-1,-1,0)= 1 and ((-1,-1,1) >= (-1,-1,2)) and ((-1,-1,1) >= (-1,-1,3)) }
rule : { 1 } 1000 { (-1,0,-2) >= 2 and (-1,0,0)= 1 and ((-1,0,1) >= (-1,0,2)) and ((-1,0,1) >= (-1,0,3)) }
rule : { 1 } 1000 { (-1,1,-2) >= 2 and (-1,1,0)= 1 and ((-1,1,1) >= (-1,1,2)) and ((-1,1,1) >= (-1,1,3)) }
rule : { 1 } 1000 { (0,-1,-2) >= 2 and (0,-1,0)= 1 and ((0,-1,1) >= (0,-1,2)) and ((0,-1,1) >= (0,-1,3)) }
rule : { 1 } 1000 { (0,1,-2) >= 2 and (0,1,0)= 1 and ((0,1,1) >= (0,1,2)) and ((0,1,1) >= (0,1,3)) }
rule : { 1 } 1000 { (1,-1,-2) >= 2 and (1,-1,0)= 1 and ((1,-1,1) >= (1,-1,2)) and ((1,-1,1) >= (1,-1,3)) }
rule : { 1 } 1000 { (1,0,-2) >= 2 and (1,0,0)= 1 and ((1,0,1) >= (1,0,2)) and ((1,0,1) >= (1,0,3)) }
rule : { 1 } 1000 { (1,1,-2) >= 2 and (1,1,0)= 1 and ((1,1,1) >= (1,1,2)) and ((1,1,1) >= (1,1,3)) }

rule : { 2 } 1000 { (-1,-1,-2) >= 5 and (-1,-1,0)= 2 and ((-1,-1,2) > (-1,-1,1)) and ((-1,-1,2) >= (-1,-1,3)) }
rule : { 2 } 1000 { (-1,0,-2) >= 5 and (-1,0,0)= 2 and ((-1,0,2) > (-1,0,1)) and ((-1,0,2) >= (-1,0,3)) }
rule : { 2 } 1000 { (-1,1,-2) >= 5 and (-1,1,0)= 2 and ((-1,1,2) > (-1,1,1)) and ((-1,1,2) >= (-1,1,3)) }
rule : { 2 } 1000 { (0,-1,-2) >= 5 and (0,-1,0)= 2 and ((0,-1,2) > (0,-1,1)) and ((0,-1,2) >= (0,-1,3)) }
rule : { 2 } 1000 { (0,1,-2) >= 5 and (0,1,0)= 2 and ((0,1,2) > (0,1,1)) and ((0,1,2) >= (0,1,3)) }
rule : { 2 } 1000 { (1,-1,-2) >= 5 and (1,-1,0)= 2 and ((1,-1,2) > (1,-1,1)) and ((1,-1,2) >= (1,-1,3)) }
rule : { 2 } 1000 { (1,0,-2) >= 5 and (1,0,0)= 2 and ((1,0,2) > (1,0,1)) and ((1,0,2) >= (1,0,3)) }
rule : { 2 } 1000 { (1,1,-2) >= 5 and (1,1,0)= 2 and ((1,1,2) > (1,1,1)) and ((1,1,2) >= (1,1,3)) }


rule : { 3 } 1000 { (-1,-1,-2) >= 7 and (-1,-1,0)= 3 and ((-1,-1,3) > (-1,-1,1)) and ((-1,-1,3) > (-1,-1,2)) }
rule : { 3 } 1000 { (-1,0,-2) >= 7 and (-1,0,0)= 3 and ((-1,0,3) > (-1,0,1)) and ((-1,0,3) > (-1,0,2)) }
rule : { 3 } 1000 { (-1,1,-2) >= 7 and (-1,1,0)= 3 and ((-1,1,3) > (-1,1,1)) and ((-1,1,3) > (-1,1,2)) }
rule : { 3 } 1000 { (0,-1,-2) >= 7 and (0,-1,0)= 3 and ((0,-1,3) > (0,-1,1)) and ((0,-1,3) > (0,-1,2)) }
rule : { 3 } 1000 { (0,1,-2) >= 7 and (0,1,0)= 3 and ((0,1,3) > (0,1,1)) and ((0,1,3) > (0,1,2)) }
rule : { 3 } 1000 { (1,-1,-2) >= 7 and (1,-1,0)= 3 and ((1,-1,3) > (1,-1,1)) and ((1,-1,3) > (1,-1,2)) }
rule : { 3 } 1000 { (1,0,-2) >= 7 and (1,0,0)= 3 and ((1,0,3) > (1,0,1)) and ((1,0,3) > (1,0,2)) }
rule : { 3 } 1000 { (1,1,-2) >= 7 and (1,1,0)= 3 and ((1,1,3) > (1,1,1)) and ((1,1,3) > (1,1,2)) }



%dead rules for the grass(If minimum resources not available to survive and not to die) 
rule : { 0 } 1000 { (0,0,0) = 1 and ((0,0,-2) >= 4 or (0,0,4) < 1 or (0,0,5) < 6 or (0,0,6) < 2 ) }

%dead rules for the oak (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { (0,0,0) = 2 and ( (0,0,-2) >= 55 or (0,0,4) < 2 or (0,0,5) < 8 or (0,0,6) < 6 ) }

%dead rules for the maple (If minimum resources not available to survive and not to die)
rule : { 0 } 1000 { (0,0,0) = 3 and ( (0,0,-2) >= 60 or (0,0,4) < 2 or  (0,0,5) < 8 or (0,0,6) < 5 ) }



%rule : { 0 } 1000 { (0,0,-2) = 0 }

rule : { (0,0,0) } 1000 { t }

[graseed]

%calculate the number of grass seed in each cell
rule : { (0,0,0) + 1 } 1000 { (0,0,-3) >= 2 and (0,0,-1) = 1 }

rule : { (0,0,0) } 1000 { t }

[oakseed]

%calculate the number of oak seed in each cell
rule : { (0,0,0) + 1 } 1000 { (0,0,-4) >= 5 and (0,0,-2) = 2 }

rule : { (0,0,0) } 1000 { t }

[mapleseed]

%calculate the number of maple seed in each cell
rule : { (0,0,0) + 1 } 1000 { (0,0,-5) >= 7 and (0,0,-3) = 3 }

rule : { (0,0,0) } 1000 { t }

[sunamount]

%each cell can not contain more than maximum resource
rule : { 12 } 1000 { (0,0,0) > 12 }

%sun amount is calculated by subtraction of sun light resource of the current cell and the grass use to grow(2 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 2) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,-4) = 1 and (0,0,1) >= 7 and (0,0,2) >= 4 and (0,0,0) <= 12 }

%sun amount is calculated by subtraction of sun light resource of the current cell and the grass use to survive(1 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 1) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 1 and (0,0,0) < 2 and (0,0,-4) = 1 and (0,0,1) >= 6 and (0,0,1) < 7 and (0,0,2) >= 2 and (0,0,2) < 4 }


%sun amount is calculated by subtraction of sun light resource of the current cell and the oak use to grow(3 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 3) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 3 and (0,0,-4) = 2 and (0,0,1) >= 10 and (0,0,2) >= 7 and (0,0,0) <= 12 }

%sun amount is calculated by subtraction of sun light resource of the current cell and the oak use to survive(2 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 2) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,0) < 3 and (0,0,-4) = 2 and (0,0,1) >= 8 and (0,0,1) < 10 and (0,0,2) >= 6 and (0,0,2) < 7 }



%sun amount is calculated by subtraction of sun light resource of the current cell and the maple use to grow(3 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 3) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 3 and (0,0,-4) = 3 and (0,0,1) >= 10 and (0,0,2) >= 6 and (0,0,0) <= 12 }

%sun amount is calculated by subtraction of sun light resource of the current cell and the oak use to survive(2 calories)
%new sun light resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0) - 2) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,0) < 3 and (0,0,-4) = 3 and (0,0,1) >= 8 and (0,0,1) < 10 and (0,0,2) >= 5 and (0,0,2) < 6 }


%if none of the none of the plant type exist to make use of the sun light
%the sun light resources redistribute according to above rule .

rule : {((-1,1,0)+(0,1,0) + (1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 12  } 



rule : { (0,0,0) } 1000 { t }

[addsun]
%extra sun light added to the addsun zone or add via input port to a cell  and use sun light rule to grow grass and redistribute remaining sun light into adjacent  cells
rule : { ((0,0,0)- 2) + uniform(9,15) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,-4) = 1 and (0,0,1) >= 7 and (0,0,2) >= 4 }
 
%extra sun light added to the addsun zone or add via input port to a cell  and use sun light rule to grow oak and redistribute remaining sun light into adjacent  cells
rule : { ((0,0,0)- 3) + uniform(9,15) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 3 and (0,0,-4) =  2 and (0,0,1) >= 10 and (0,0,2) >= 7 }

%extra sun light added to the addsun zone or add via input port to a cell  and use sun light rule to grow maple and redistribute remaining sun light into adjacent  cells
rule : { ((0,0,0)- 3) + uniform(9,15) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 3 and (0,0,-4) =  3 and (0,0,1) >= 10 and (0,0,2) >= 6 }

%extra sun light added to the addsun zone or add via input port to a cell  and use sun light rule if no tree exists or not enough resource available then redistribute remaining sun light into adjacent  cells.
 
rule : { uniform(9,15) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 12  } 

rule : { (0,0,0) } 1000 { t }

[mineralamount]

%mineral amount is calculated by subtraction of mineral resource of the current cell and the grass use to grow(7 grams)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 7)+ ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 7 and (0,0,-5) = 1 and (0,0,1) >= 4 and (0,0,-1) >= 2  }

%mineral amount is calculated by subtraction of mineral resource of the current cell and the grass use to survive(6 grams)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 6)+ ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 6 and (0,0,0) < 7 and (0,0,-5) = 1 and (0,0,1) >= 2 and (0,0,1) < 4 and (0,0,-1) >= 1 and (0,0,-1) < 2 }


%mineral amount is calculated by subtraction of mineral resource of the current cell and the oak use to grow(10 grams)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 10) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 10  and (0,0,-5)=  2 and (0,0,1) >= 7 and (0,0,-1) >= 3  }

%mineral amount is calculated by subtraction of mineral resource of the current cell and the oak use to survive(8 calories)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 8) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 8 and (0,0,0) < 10 and (0,0,-5) = 2 and (0,0,1) >= 6 and (0,0,1) < 7 and (0,0,-1) >= 2 and (0,0,-1) < 3 }



%mineral amount is calculated by subtraction of mineral resource of the current cell and the maple use to grow(10 calories)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 10) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 10  and (0,0,-5)=  3 and (0,0,1) >= 6 and (0,0,-1) >= 3  }

%mineral amount is calculated by subtraction of mineral resource of the current cell and the oak use to survive(8 calories)
%new mineral resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 8) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,0) < 3 and (0,0,-5) = 3 and (0,0,1) >= 5 and (0,0,1) < 6 and (0,0,-1) >= 2 and (0,0,-1) < 3 }


%if none of the none of the plant type exist to make use of the mineral
%the mineral resources redistribute according to above rule .
%each cell can not contain more than maximum resource
 
rule : {((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 80  } 

rule : { (0,0,0) } 1000 { t }

[addmineral]

%random value amount of mineral added to the addmineral zone or add via input port to a cell  and use mineral light rule to grow grass and redistribute remaining mineral light into adjacent  cells
rule : { ((0,0,0)- 7) + uniform(35,65) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 7 and (0,0,-5) = 1 and (0,0,1) >= 4 and (0,0,-1) >= 2 }
 
%random value amount of mineral added to the addmineral zone or add via input port to a cell  and use mineral light rule to grow oak and redistribute remaining mineral light into adjacent  cells
rule : { ((0,0,0)- 10) + uniform(35,65) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 10  and (0,0,-5)=  2 and (0,0,1) >= 7 and (0,0,-1) >= 3 }

%random value amount of mineral added to the addmineral zone or add via input port to a cell  and use mineral light rule to grow maple and redistribute remaining mineral light into adjacent  cells
rule : { ((0,0,0)- 10) + uniform(35,65) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 10  and (0,0,-5)=  3 and (0,0,1) >= 6 and (0,0,-1) >= 3 }

%random value amount of mineral added to the addmineral zone or add via input port to a cell  and use mineral light rule if no tree exists or not enough resource available then redistribute remaining mineral light into adjacent  cells.
 
rule : { uniform(35,65) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 80  } 

rule : { (0,0,0) } 1000 { t }


[wateramount]
%water amount is calculated by subtraction of water resource of the current cell and the grass use to grow(2 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 4)+ ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 4 and (0,0,-6) = 1 and (0,0,-1) >= 7 and (0,0,-2) >= 2  }

%water amount is calculated by subtraction of water resource of the current cell and the grass use to survive(1 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 2)+ ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 2 and (0,0,0) < 4 and (0,0,-6) = 1 and (0,0,-1) >= 6 and (0,0,-1) < 7 and (0,0,-2) >= 1 and (0,0,-2) < 2 }


%water amount is calculated by subtraction of water resource of the current cell and the oak use to grow(3 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 7) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 7  and (0,0,-6)=  2 and (0,0,-1) >= 10 and (0,0,-2) >= 3  }

%sun amount is calculated by subtraction of water resource of the current cell and the oak use to survive(2 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 6) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 6 and (0,0,0) < 7 and (0,0,-6) = 2 and (0,0,-1) >= 8 and (0,0,-1) < 10 and (0,0,-2) >= 2 and (0,0,-2) < 3 }



%sun amount is calculated by subtraction of water resource of the current cell and the maple use to grow(3 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 6) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 6  and (0,0,-6)=  3 and (0,0,-1) >= 10 and (0,0,-2) >= 3  }

%sun amount is calculated by subtraction of water resource of the current cell and the oak use to survive(2 calories)
%new water resource(remaining) redistribution to the cell and adjacent  cells
rule : { ((0,0,0)- 5) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 5 and (0,0,0) < 6 and (0,0,-6) = 3 and (0,0,-1) >= 8 and (0,0,-1) < 10 and (0,0,-2) >= 2 and (0,0,-2) < 3 }


%if none of the none of the plant type exist to make use of the water
%the water resources redistribute according to above rule .
%each cell can not contain more than maximum resource
 
rule : {((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 16  } 

rule : { (0,0,0) } 1000 { t }

[addwater]
%random value amount of water added to the addsun zone or add via input port to a cell  and use water rule to grow grass and redistribute remaining water into adjacent  cells
rule : { ((0,0,0)- 2) + uniform(10,20) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 4 and (0,0,-6) = 1 and (0,0,-1) >= 7 and (0,0,-2) >= 2 }
 
%random value amount of water added to the addsun zone or add via input port to a cell  and use water rule to grow oak and redistribute remaining water into adjacent  cells
rule : { ((0,0,0)- 3) + uniform(10,20) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 7  and (0,0,-6)=  2 and (0,0,-1) >= 10 and (0,0,-2) >= 3 }

%random value amount of water added to the addsun zone or add via input port to a cell  and use water rule to grow maple and redistribute remaining water into adjacent  cells
rule : { ((0,0,0)- 3) + uniform(10,20) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9 } 1000 { (0,0,0) >= 6  and (0,0,-6)=  3 and (0,0,-1) >= 10 and (0,0,-2) >= 3 }

%random value amount of water added to the addsun zone or add via input port to a cell  and use water rule if no tree exists or not enough resource available then redistribute remaining water into adjacent  cells.
 
rule : { uniform(10,20) + ((-1,1,0)+(0,1,0)+(1,1,0)+(-1,0,0)+(0,0,0)+(1,0,0)+(-1,-1,0)+(0,-1,0)+(1,-1,0))/9} 1000 { (0,0,0) < 16  } 

rule : { (0,0,0) } 1000 { t }


[plant_rule]
rule : { (0,0,0) } 1000 { t }




[shape]
type : cell
dim : (20, 30)
delay : transport
defaultDelayTime  : 100
border : nowrapped 

neighbors : shape(-1,-1) 	shape(-1,0)		shape(-1,1) 
neighbors : shape(0,-1)  	shape(0,0)		shape(0,1)
neighbors : shape(1,-1)  	shape(1,0)		shape(1,1)


initialvalue : 0

%shapeMA1.val

%initialrowvalue :  0      000000000000000000000000000000
%initialrowvalue :  1      000000000000000000000000000000
%initialrowvalue :  2      000000000000000000000000000000
%initialrowvalue :  3      000000000000000000000000000000
%initialrowvalue :  4      000000000000000000000000000000
%initialrowvalue :  5      000000000000000000000000000000
%initialrowvalue :  6      000000000000000000000000000000
%initialrowvalue :  7      000000000000000000000000000000
%initialrowvalue :  8      000000000000000000000000000000
%initialrowvalue :  9      000000000000000000000000000000
%initialrowvalue : 10      000000000000000000000000000000
%initialrowvalue : 11      000000000000000000000000000000
%initialrowvalue : 12      000000000000000000000000000000
%initialrowvalue : 13      000000000000000000000000000000
%initialrowvalue : 14      000000000000000000000000000000
%initialrowvalue : 15      000000000000000000000000000000
%initialrowvalue : 16      000000000000000000000000000000
%initialrowvalue : 17      000000000000000000000000000000
%initialrowvalue : 18      000000000000001000000000000000
%initialrowvalue : 19      000000000000000000000000000000

in : inputSeed
link : inputSeed  in@shape(18,14)

localtransition : shape-rule
zone : trunk-rule { (15,14)..(18,14) }
zone : branch-rule { (1,2)..(14,27) }

portInTransition : in@shape(18,14)  setseed

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

[shape-rule]

rule : {(0,0)} 100 {t}

[setseed]

rule : { 1 } 100 { portValue(thisPort) = 2 }

rule : {(0,0)} 100 {t}

[setReSource1]
rule : { uniform(9,15) } 1000 { t }

[setReSource2]
rule : { uniform(35,65) } 1000 { t }

[setReSource3]
rule : { uniform(10,20) } 1000 { t }


