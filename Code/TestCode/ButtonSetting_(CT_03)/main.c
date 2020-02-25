#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>

volatile uint8_t thresh_sensitivity __attribute__((address(0x800100)));
// If thresh_sensitivity = 0, then Sensitivity is Low
// If thresh_sensitivity = 1, then Sensitivity is Medium
// If thresh_sensitivity = 2, then Sensitivity is High
volatile uint8_t sleep_mode __attribute__((address(0x800101)));
// If sleep_mode = 0xFF, then the device is powered off
// If sleep_mode = 0x00, then the device is powered on
void WDT_init() __attribute__((naked)) __attribute__((section(".init3")));

void WDT_init()
{
	MCUSR = 0;
	wdt_disable();
	return;
}

int main()
{
	DDRC &=~ 0x1F;
	DDRD |= 0x07;
	PORTD = 0x07;
	thresh_sensitivity = 3;
	PCICR = (1 << PCIE1);

	sei();
	while(1)
	{
		//asm("NOP");
	}
}

ISR (PCINT1_vect)
{
	cli(); // Disables all other Interrupts, making this an Atomic ISR
	
	if(PINC & (1 << PINC4))
	{
		if(sleep_mode == 0x00)
		{
			sleep_mode = 0xFF; // Entering Sleep Mode
			SMCR = (1 << SM1);
			SMCR |= (1 << SE);
		} else {
			SMCR &=~ (1 << SE); // Exiting Sleep Mode
			sleep_mode = 0x00;
			wdt_enable(WDTO_15MS);
		}
	}
	if(PINC & (1 << PINC3))
	{
		wdt_enable(WDTO_15MS);
		// Perform a Soft Reset on the System
	}
	if(PINC & (1 << PINC2))
        {
		thresh_sensitivity = 2;
		// High Sensitivity On
        }
        if(PINC & (1 << PINC1))
        {
		thresh_sensitivity = 1;
		// Medium Sensitivity On
        }
	if(PINC & (1 << PINC0))
        {
		thresh_sensitivity = 0;
		// Low Sensitivity On
        }
	
	switch(thresh_sensitivity)
	{
		case 0:
			PORTD = 0x01;
			break;
		case 1:
			PORTD = 0x02;
			break;
		case 2:
			PORTD = 0x04;
			break;
		default:
			PORTD = 0x07;
			break;
	}
	
	sei(); // Enable Interrupts before exiting the ISR
}
