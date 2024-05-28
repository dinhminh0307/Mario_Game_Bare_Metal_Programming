
#include "../uart/uart0.h"
#include "../uart/uart1.h"
#include "goomba.h"


#include "../image/defaultMario.h"
#include "../image/mariofw.h"
#include "../image/terrian1.h"
#include "../image/terrian2.h"
#include "../image/terrian3.h"
#include "../image/defaultGoomba.h"

#include "../image/terrian22.h"
#include "../image/terrian23.h"
#include "../image/terrian25.h"
#include "../image/terrian28.h"
#include "../image/terrian29.h"


//define transition offset
#define TRANSITION_OFF 5

#define INPUT_DELAY 1

// State define

#define GAME_ON 1
#define GAME_OFF 0

// Check if the game is init
#define INIT 1


// Plus or minus new value
#define INCREMENT_VAL 1
#define DECREMENT_VAL -1

// Define he offset of obstacle position in the array bit
#define TERRIAN2_OBSTACLE_X_OFFSET 194
#define TERRIAN2_OBSTACLE_Y_OFFSET 37

#define TERRIAN2_STAIR_X_OFFSET 385
#define TERRIAN2_STAIR_Y_OFFSET 0

#define TERRIAN3_STAIR_X_OFFSET 170 // position (1924, 0) of the 
#define TERRIAN3_STAIR_Y_OFFSET 0




// game state
extern volatile int gameState;
extern volatile int isGameInit;
//extern int extra_shadow;

// Function prototypes
void gameOn(void);
void drawGround(void);