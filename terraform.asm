.ORIG x3000

;clear registers
AND R0, R0, #0      ;x coord
AND R1, R1, #0      ;y coord
AND R2, R2, #0      ;z coord
AND R3, R3, #0 
AND R4, R4, #0 
AND R5, R5, #0 
AND R6, R6, #0 

;get and store the player x and z coords
TRAP 0x29
STI R0, PLAYER_X_COORD
STI R2, PLAYER_Z_COORD

;get the highest non-air block
TRAP 0x2D
STI R1, PLAYER_Y_COORD

;NOT the y coordinate
LDI R5, PLAYER_Y_COORD
NOT R5, R5
ADD R5, R5, #1 

;put the air block ID into R3
LD R3, AIR_BLOCK_ID

;-----------------------------------AIR---------------------------------------|

;top left
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #-1
ADD R2, R2, #-1
JSR REMOVE

;top middle
JSR CLEAR_AND_LOAD_REMOVE
ADD R2, R2, #-1
JSR REMOVE

;top right
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #1
ADD R2, R2, #-1
JSR REMOVE

;left
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #-1
JSR REMOVE

;right
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #1
JSR REMOVE

;bottom left
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #-1
ADD R2, R2, #1
JSR REMOVE

;bottom middle
JSR CLEAR_AND_LOAD_REMOVE
ADD R2, R2, #1
JSR REMOVE

;bottom right
JSR CLEAR_AND_LOAD_REMOVE
ADD R0, R0, #1
ADD R2, R2, #1
JSR REMOVE

;-------------------------------COBBLESTONE-----------------------------------|

;top left
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #-1
ADD R2, R2, #-1
JSR REPLACE

;top middle
JSR CLEAR_AND_LOAD_REPLACE
ADD R2, R2, #-1
JSR REPLACE

;top right
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #1
ADD R2, R2, #-1
JSR REPLACE

;left
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #-1
JSR REPLACE

;middle
JSR CLEAR_AND_LOAD_REPLACE
JSR REPLACE

;right
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #1
JSR REPLACE

;bottom left
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #-1
ADD R2, R2, #1
JSR REPLACE

;bottom middle
JSR CLEAR_AND_LOAD_REPLACE
ADD R2, R2, #1
JSR REPLACE

;bottom right
JSR CLEAR_AND_LOAD_REPLACE
ADD R0, R0, #1
ADD R2, R2, #1
JSR REPLACE

HALT

PLAYER_X_COORD .FILL x4100
PLAYER_Y_COORD .FILL x4101
PLAYER_Z_COORD .FILL x4102

AIR_BLOCK_ID .FILL #0
COBBLESTONE_ID .FILL #4

;loop to remove blocks above the highest middle block
REMOVE
AND R6, R6, #0          ;label separator
AIR_LOOP
TRAP 0x2D
ADD R1, R1, R5          ;Current highest non-air block minus PLAYER_Y_COORD
BRnz FINISH             ;if current block height is less than or greater than player Y coord, exit loop
TRAP 0x2D
TRAP 0x2C
BRzp AIR_LOOP
FINISH
RET

;loop to fill the air spots in the ground
REPLACE
AND R6, R6, #0          ;label separator
STONE_LOOP
TRAP 0x2B
ADD R5, R3, #-7         ;7 is the id for bedrock
BRz FINISHED
AND R5, R5, #0
ADD R5, R3, #0          ;check if the block is air
BRnp KEEP_GOING
AND R3, R3, #0
LD R3, COBBLESTONE_ID   ;load cobblestone into R3
TRAP 0x2C
KEEP_GOING
ADD R1, R1, #-1         ;decrement y
BR STONE_LOOP
FINISHED
RET

CLEAR_AND_LOAD_REMOVE
AND R0, R0, #0
AND R2, R2, #0
LDI R0, PLAYER_X_COORD
LDI R2, PLAYER_Z_COORD
RET

CLEAR_AND_LOAD_REPLACE
AND R0, R0, #0
AND R1, R1, #0 
AND R2, R2, #0
AND R3, R3, #0 
AND R5, R5, #0 
LDI R0, PLAYER_X_COORD
LDI R1, PLAYER_Y_COORD
LDI R2, PLAYER_Z_COORD
RET

.END