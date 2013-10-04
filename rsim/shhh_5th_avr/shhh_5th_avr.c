/*
 * shhh_5th_avr.c
 *
 * Created: 28/09/2013 5:57:33 PM
 *  Author: Richard
 */ 

#define F_CPU 1000000UL  // 1 MHz
#include <avr/io.h>
#include <util/delay.h>

#include <string.h>


#define DELAY_SET_COL		//_delay_us(1)
#define DELAY_SET_ROW		//_delay_ms(1)
#define DELAY_H_BLANK		_delay_ms(500)
#define DELAY_V_BLANK		//_delay_ms(1000)

#define NUM_ROWS		8
#define NUM_COLS		16

struct ButtonState
{
	uint8_t up;
	uint8_t down;
	uint8_t left;
	uint8_t right;
	uint8_t center;
	uint8_t action;
};
#define BUTTON_PRESSED(CURR_BUTTONS, PREV_BUTTONS, BUTTON)		((CURR_BUTTONS.BUTTON != 0) && (PREV_BUTTONS.BUTTON == 0))

struct Pixel
{
	uint8_t g, r;
};

struct Pixel gLEDMatrix[NUM_COLS][NUM_ROWS];

struct ButtonState gButtons;

int gCurrRow;
int gCurrCol;


void GetButtonState(struct ButtonState* pButtonState)
{
	uint8_t bval = (PINC >> 1) & 0b00000111;
	pButtonState->up = (bval == 1);
	pButtonState->left = (bval == 3);
	pButtonState->right = (bval == 4);
	pButtonState->down = (bval == 6);
	pButtonState->center = (bval == 7);

	pButtonState->action = 1 - (PINC & 0b00000001);
}

void SetColumn(uint8_t c)
{
	c = c & 0x00001111;
	PORTD = (PORTD & 0b01111111) | ((c & 0b00000001) << PORTD7);
	
	c = (c >> 1) & 0b00000111;
	PORTB = (PORTB & 0b11111000) | c;

	DELAY_SET_COL;
}

void ClockRowData(uint8_t data)
{
	data = data & 0b1;

	PORTD = (PORTD & 0b10111111) | (data << PORTD6);
	asm("nop");
	//_delay_us(1);
	
	PORTD = (PORTD & 0b11011111) | (1 << PORTD5);
	asm("nop");
	_delay_us(1);
	
	PORTD = (PORTD & 0b11011111) | (0 << PORTD5);
	asm("nop");
	//_delay_us(1);
	
	DELAY_SET_ROW;
}

void updateInput(void)
{
	struct ButtonState prev_buttons = gButtons;
	GetButtonState(&gButtons);

	if (BUTTON_PRESSED(gButtons, prev_buttons, up))
	{
		gCurrRow--;
		if (gCurrRow < 0)
			gCurrRow = NUM_ROWS - 1;
	}
	else if (BUTTON_PRESSED(gButtons, prev_buttons, down))
	{
		gCurrRow++;
		if (gCurrRow == NUM_ROWS)
			gCurrRow = 0;
	}
	else if (BUTTON_PRESSED(gButtons, prev_buttons, left))
	{
		gCurrCol--;
		if (gCurrCol < 0)
			gCurrCol = NUM_COLS - 1;
	}
	else if (BUTTON_PRESSED(gButtons, prev_buttons, right))
	{
		gCurrCol++;
		if (gCurrCol == NUM_COLS)
			gCurrCol = 0;
	}
	else if (BUTTON_PRESSED(gButtons, prev_buttons, center))
	{
		asm("nop");
	}
	
	if (BUTTON_PRESSED(gButtons, prev_buttons, action))
	{
		struct Pixel* pCurrPixel = &(gLEDMatrix[gCurrCol][gCurrRow]);
		
		if ((pCurrPixel->g == 0) && (pCurrPixel->r == 0))
			pCurrPixel->g = 1;
		else if ((pCurrPixel->g != 0) && (pCurrPixel->r == 0))
			pCurrPixel->r = 1;
		else if ((pCurrPixel->g != 0) && (pCurrPixel->r != 0))
			pCurrPixel->g = 0;
		else if ((pCurrPixel->g == 0) && (pCurrPixel->r != 0))
			pCurrPixel->r = 0;
	}
}

void refreshLEDMatrix(void)
{
// 	for (uint8_t row=0; row<NUM_ROWS; row++)
// 	{
// 		ClockRowData(gLEDMatrix[0][row].g != 0);
// 		ClockRowData(gLEDMatrix[0][row].r != 0);
// 	}

	for (uint8_t col=0; col<NUM_COLS; col++)
	{
		SetColumn(col);
		
		for (uint8_t row=0; row<NUM_ROWS; row++)
		{
			ClockRowData(gLEDMatrix[col][row].g != 0);
			ClockRowData(gLEDMatrix[col][row].r != 0);
		}
		
		DELAY_H_BLANK;
	}
	
	DELAY_V_BLANK;
}

void loop(void)
{
	updateInput();
	
	refreshLEDMatrix();
}

int main(void)
{
	DDRC = 0b00110000;	// PC inputs (I2C? ADC6/7?)
	DDRD = 0b11111110;
	DDRB = 0b00101111;
	
	// Turn pullup on for PC0 (action button)
	PORTC = 0b00000001;
	
// 	memset(gLEDMatrix, 0x0, sizeof(gLEDMatrix));
	memset(&gButtons, 0, sizeof(gButtons));
	GetButtonState(&gButtons);
	
	gCurrCol = 0;
	gCurrRow = 0;
	
	for (uint8_t row=0; row<NUM_ROWS; row++)
	{
		ClockRowData(0);	// G
		ClockRowData(0);	// R
	}

	for (uint8_t col=0; col<NUM_COLS; col++)
	{
		for (uint8_t row=0; row<NUM_ROWS; row++)
		{
			gLEDMatrix[col][row].g = (row % 2);
			gLEDMatrix[col][row].r = (col % 2);
// 			gLEDMatrix[col][row].g = 0;
// 			gLEDMatrix[col][row].r = 0;
		}
	}
	
    while(1)
    {
		loop();
    }
}
