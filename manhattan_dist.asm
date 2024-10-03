.ORIG x3000
;reset the registers
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0 ;register to do calculations
AND R4, R4, #0 ;register to store results

;not all the variables
    ;NOT A_X
    LD R3, A_X
    ADD R0, R0, R3
    NOT R0, R0
    ADD R0, R0, #1
    STI R0, Not_A_X

    ;NOT A_Y
    LD R3, A_Y
    ADD R1, R1, R3
    NOT R1, R1
    ADD R1, R1, #1
    STI R1, Not_A_Y

    ;NOT A_Z
    LD R3, A_Z
    ADD R2, R2, R3
    NOT R2, R2
    ADD R2, R2, #1
    STI R2, Not_A_Z

;reset the registers
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0

    ;NOT B_X
    LD R3, B_X
    ADD R0, R0, R3
    NOT R0, R0
    ADD R0, R0, #1
    STI R0, Not_B_X

    ;NOT B_Y
    LD R3, B_Y
    ADD R1, R1, R3
    NOT R1, R1
    ADD R1, R1, #1
    STI R1, Not_B_Y

    ;NOT B_Z
    LD R3, B_Z
    ADD R2, R2, R3
    NOT R2, R2
    ADD R2, R2, #1
    STI R2, Not_B_Z

;reset the registers
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0

;get player position
TRAP 0x29

;compute manhattan distance
;player position - point A
    ;x coord
    LDI R3, Not_A_X
    ADD R4, R0, R3

        ;absolute value
        BRzp ABS_AX
        NOT R4, R4
        ADD R4, R4, #1
        ABS_AX

    STI R4, Player_Xpos_Minus_A_X

;reset registers
AND R3, R3, #0
AND R4, R4, #0

    ;ycoord
    LDI R3, Not_A_Y
    ADD R4, R1, R3

        ;absolute value
        BRzp ABS_AY
        NOT R4, R4
        ADD R4, R4, #1
        ABS_AY

    STI R4, Player_Ypos_Minus_A_Y

;reset registers
AND R3, R3, #0
AND R4, R4, #0

    ;zcoord
    LDI R3, Not_A_Z
    ADD R4, R2, R3

        ;absolute value
        BRzp ABS_AZ
        NOT R4, R4
        ADD R4, R4, #1
        ABS_AZ

    STI R4, Player_Zpos_Minus_A_Z

;reset registers
AND R3, R3, #0
AND R4, R4, #0

;player position - point B
    ;x coord
    LDI R3, Not_B_X
    ADD R4, R0, R3

        ;absolute value
        BRzp ABS_BX
        NOT R4, R4
        ADD R4, R4, #1
        ABS_BX

    STI R4, Player_Xpos_Minus_B_X

;reset registers
AND R3, R3, #0
AND R4, R4, #0

    ;ycoord
    LDI R3, Not_B_Y
    ADD R4, R1, R3

        ;absolute value
        BRzp ABS_BY
        NOT R4, R4
        ADD R4, R4, #1
        ABS_BY

    STI R4, Player_Ypos_Minus_B_Y

;reset registers
AND R3, R3, #0
AND R4, R4, #0

    ;zcoord
    LDI R3, Not_B_Z
    ADD R4, R2, R3

        ;absolute value
        BRzp ABS_BZ
        NOT R4, R4
        ADD R4, R4, #1
        ABS_BZ

    STI R4, Player_Zpos_Minus_B_Z

;reset the registers
AND R3, R3, #0 
AND R4, R4, #0

;compute manhattan distance
    ;manhattan point A
    LDI R3, Player_Xpos_Minus_A_X
    ADD R4, R4, R3

    AND R3, R3, #0 
    LDI R3, Player_Ypos_Minus_A_Y
    ADD R4, R4, R3

    AND R3, R3, #0 
    LDI R3, Player_Zpos_Minus_A_Z
    ADD R4, R4, R3

    STI R4, A_PointManhattan

;reset the registers
AND R3, R3, #0 
AND R4, R4, #0

    ;manhattan point B
    LDI R3, Player_Xpos_Minus_B_X
    ADD R4, R4, R3

    AND R3, R3, #0 
    LDI R3, Player_Ypos_Minus_B_Y
    ADD R4, R4, R3

    AND R3, R3, #0 
    LDI R3, Player_Zpos_Minus_B_Z
    ADD R4, R4, R3

    STI R4, B_PointManhattan

;reset the registers
AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0

;finding if point A or B is smaller
LDI R0, A_PointManhattan
LDI R1, B_PointManhattan
NOT R1, R1
ADD R1, R1, #1
ADD R2, R0, R1

;branches
LEA R0, Points_Are_Equal
ADD R2, R2, #0

BRz Finish
BRn A_is_Smaller
    AND R0, R0, #0
    LEA R0, Point_B_Wins
BR Finish
BRp Finish

A_is_Smaller
    AND R0, R0, #0
    LEA R0, Point_A_Wins

Finish
CHAT

HALT
A_X .FILL #1
A_Y .FILL #2
A_Z .FILL #3
B_X .FILL #20
B_Y .FILL #32
B_Z .FILL #-8

;not variables
Not_A_X .FILL x3100
Not_A_Y .FILL x3101
Not_A_Z .FILL x3102
Not_B_X .FILL x3103
Not_B_Y .FILL x3104
Not_B_Z .FILL x3105

;player poitions - points
Player_Xpos_Minus_A_X .FILL x3106
Player_Ypos_Minus_A_Y .FILL x3107
Player_Zpos_Minus_A_Z .FILL x3108

Player_Xpos_Minus_B_X .FILL x3109
Player_Ypos_Minus_B_Y .FILL x310A
Player_Zpos_Minus_B_Z .FILL x310B

;manhattan points
A_PointManhattan .FILL x310C
B_PointManhattan .FILL x310D

Point_A_Wins .STRINGZ "The player is closer to point A"
Point_B_Wins .STRINGZ "The player is closer to point B"
Points_Are_Equal .STRINGZ "The player is equally far from both points"

.END