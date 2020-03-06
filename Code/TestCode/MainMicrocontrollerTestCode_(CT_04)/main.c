#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <avr/sleep.h>

volatile uint8_t thresh_sensitivity __attribute__((address(0x800100)));
// If thresh_sensitivity = 0, then Sensitivity is Low
// If thresh_sensitivity = 1, then Sensitivity is Medium
// If thresh_sensitivity = 2, then Sensitivity is High
volatile uint8_t sleep_code __attribute__((address(0x800101)));
// If sleep_mode = 0x00, then the device is powered on
// If sleep_mode = 0x0F, then the device restarts
// If sleep_mode = 0xFF, then the device is powered off
volatile uint8_t aux_switch __attribute__((address(0x800102)));

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

	aux_switch = 0;

	DDRB = 0x03; // Set PB1:0 as outputs

	TCNT1 = 39062; // Sets the timer to go off every 1s.
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b101<<CS10); // Set the Prescaler to 256
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1

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
			sleep_code = 0x0F;
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
	} else if(sleep_code == 0x0F) {
		sleep_disable();
		wdt_enable(WDTO_250MS);
	}
	sei();
}


ISR (TIMER1_OVF_vect)
{
	// This interrupt is non-atomic
	TCNT1 = 39062;
	aux_switch++;
	PORTB = aux_switch;
}
