.ORIG x3000

;reset the registers
AND R0, R0, #0  ; player x coord
AND R1, R1, #0  ; player y coord
AND R2, R2, #0  ; player z coord
AND R3, R3, #0  ; to store block ID
AND R4, R4, #0  ; NUMBER_TO_CONVERT
AND R5, R5, #0  ; get the bits
AND R6, R6, #0  ; loop counter

;get the player position
TRAP 0x29

;load NUMBER_TO_CONVERT into R4
LD R4, NUMBER_TO_CONVERT

;set to 1 start to with the least significant bit
ADD R5, R5, #1

;load R6 with 16 so the loop happens 16 times
LD R6, SIXTEEN

;begin looping
LOOP

;check the current bit of the NUMBER_TO_CONVERT using the mask in R5
AND R3, R4, R5  ;get the current bit
BRz AIR_BLOCK   ;if the bit is 0, go to AIR_BLOCK

LD R3, STONE_ID ;if the bit is 1, load the stone block ID
BR PLACE_BLOCK

AIR_BLOCK
LD R3, AIR_ID   ;load air block ID if the bit is 0

PLACE_BLOCK
ADD R2, R2, #1  ;move to the next z-coordinate (z+1)
TRAP 0x2C       

;shift to the left to check the next bit
ADD R5, R5, R5

;decrement the loop counter
ADD R6, R6, #-1
BRp LOOP     ;repeat for the next bit


HALT

NUMBER_TO_CONVERT .FILL #237   
STONE_ID .FILL #1   ;stone block ID
AIR_ID .FILL #0     ;air block ID
SIXTEEN .FILL #16   ;loop counter value

.END


