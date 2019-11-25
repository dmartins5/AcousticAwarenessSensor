#include <avr/io.h>
#include <avr/interrupt.h>
#include <math.h>

uint8_t decodes[] __attribute__((address(0x800100))) = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67};
volatile uint16_t num __attribute__((address(0x800110)));
volatile uint8_t digLut __attribute__((address(0x800112)));

uint16_t Hex2Dec(uint8_t n)
{
	uint16_t decDig __attribute__((address(0x800117)));
	uint8_t remainder __attribute__((address(0x800119)));
	uint8_t count __attribute__((address(0x80011A)));
	count = 0;
	if(n == 0)
	{
		decDig = 0;
	} else {	
		while(n > 0)
		{
			remainder = n % 10;
			decDig = decDig + remainder * pow(16, count);
			n = n / 10;
			count++;
		}
	}
	return decDig;
}

void displayNum()
{
	volatile uint16_t num2Display __attribute__((address(0x80011B)));
	num2Display = Hex2Dec(num);

	uint8_t num_high __attribute__((address(0x800113)));
	num_high = ((num2Display & 0xFF00) >> 8);
	uint8_t num_low __attribute__((address(0x800114)));
	num_low = num2Display & 0x00FF;
	uint8_t mask_digit_high __attribute__((address(0x800115)));
	mask_digit_high = 0xF0;
	uint8_t mask_digit_low __attribute__((address(0x800116)));
	mask_digit_low = 0x0F;
	
	if(digLut == 3)
	{
		//clear_ports();
		mask_digit_high &= num_high;
		mask_digit_high >>= 4;
		PORTD = decodes[mask_digit_high];
		PORTB = ~(1<<PORTB0);
		} else if(digLut == 2) {
		//clear_ports();
		mask_digit_low &= num_high;
		PORTD = decodes[mask_digit_low];
		PORTB = ~(1<<PORTB1);
		} else if(digLut == 1) {
		//clear_ports();
		mask_digit_high &= num_low;
		mask_digit_high >>= 4;
		PORTD = decodes[mask_digit_high];
		PORTB = ~(1<<PORTB2);
		} else  if(digLut == 0) {
		//clear_ports();
		mask_digit_low &= num_low;
		PORTD = decodes[mask_digit_low];
		PORTB = ~(1<<PORTB3);
	}
}

void clear_ports()
{
	PORTD = 0x00;
	PORTB = 0x00;
}

int main()
{
	num = 0;
	TCNT0 = -71;
	TCCR0A = (0b00<<COM0A0)|(0b00<<COM0B0)|(0b00<<WGM00); // Normal mode
	TCCR0B = (0b0<<WGM02)|(0b100<<CS00); // prescaler = divide by 256
	TIMSK0 = (0b1<<TOIE0); // enable interrupts for TOV0
	
	TCNT1 = -9765; // Sets the timer to go off every 500.4 ms.
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b001<<CS10); // Set Prescaler to 1
	TIMSK1 = (0b1<<TOIE1); // Enables interrupts for TOV1

	ADMUX = (0b01<<REFS0);
	ADMUX &=~ (0b1111<<MUX0);
	ADCSRA = (0b111 << ADPS0);
	ADCSRA |= (1 << ADEN);
	
	sei();
	// this is a C function to enable global interrupts
	while(1)
	{
		DDRC &= ~(1<<DDC0);
		//PC0 is now an Input
		DDRB |= (1<<DDB3)|(1<<DDB2)|(1<<DDB1)|(1<<DDB0);
		//PORTB.3:0 = Each digit of the display
		DDRD |= 0b11111111;
		//Output to segments
	}
}

ISR (TIMER0_OVF_vect)
{
	cli();
	clear_ports();
	if(digLut == 0)
	digLut = 3;
	else
	digLut--;
	displayNum();
	TCNT0 = -71;
	sei();
}

ISR (TIMER1_OVF_vect)
{
	cli();
	num = ADC;
	TCNT1 = -9765;
	sei();
}
