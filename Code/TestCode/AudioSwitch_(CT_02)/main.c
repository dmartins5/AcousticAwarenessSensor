#include <avr/io.h>
#include <avr/interrupt.h>

volatile uint8_t aux_switch __attribute__((address(0x800100)));

int main()
{
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

ISR (TIMER1_OVF_vect)
{
        // This interrupt is non-atomic
        TCNT1 = 39062;
        aux_switch++;
        PORTB = aux_switch;
}
