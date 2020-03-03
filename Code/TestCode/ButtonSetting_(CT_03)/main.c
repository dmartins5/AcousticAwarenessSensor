#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <avr/sleep.h>

volatile uint8_t thresh_sensitivity __attribute__((address(0x800100)));
// If thresh_sensitivity = 0, then Sensitivity is Low
// If thresh_sensitivity = 1, then Sensitivity is Medium
// If thresh_sensitivity = 2, then Sensitivity is High
volatile uint8_t sleep_code __attribute__((address(0x800101)));
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
	sleep_code = 0x00;
	thresh_sensitivity = 3;
	PCICR = (1 << PCIE1);
	PCMSK1 = (1 << PCINT12)|(1 << PCINT11)|(1 << PCINT10)|(1 << PCINT9)|(1 << PCINT8);

	sei();
	while(1)
	{
		asm("NOP");
	}
}

ISR (PCINT1_vect)
{
	cli();
	if(PINC & (1 << PINC4))
	{
		if(sleep_code == 0x00)
		{
			sleep_code = 0xFF;
		} else if (sleep_code == 0xFF) {
			sleep_code = 0x00;
		}
	}
	if(PINC & (1 << PINC3))
	{
		wdt_enable(WDTO_250MS);
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
	
	if(sleep_code == 0xFF)
	{
		sei();
		PORTD = 0x00;
		set_sleep_mode(2);
		sleep_mode();
	} else if(sleep_code == 0x00) {
		sleep_disable();
		wdt_enable(WDTO_250MS);
	}
	sei();
}
