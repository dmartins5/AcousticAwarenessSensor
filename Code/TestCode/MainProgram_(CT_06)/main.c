#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/wdt.h>
#include <avr/sleep.h>
#include <math.h>

volatile uint16_t adc_num __attribute__((address(0x800100)));
volatile uint16_t adc_2sAvg __attribute__((address(0x800102)));
volatile uint16_t adc_20sAvg __attribute__((address(0x800104)));
volatile uint16_t adc_num_arr[50] __attribute__((address(0x800106)));
volatile uint16_t adc_avg __attribute__((address(0x80016A)));
volatile uint16_t adc_2sAvg_arr[10] __attribute__((address(0x80016C)));

volatile uint8_t adc_num_idx __attribute__((address(0x800180)));
volatile uint8_t adc_2sAvg_idx __attribute__((address(0x800181)));
volatile uint16_t adc_sum_squared __attribute__((address(0x800182)));
volatile uint16_t adc_std_dev __attribute__((address(0x800184)));

volatile uint16_t thresh_high __attribute__((address(0x800190)));
volatile uint16_t thresh_medium __attribute__((address(0x800192)));
volatile uint16_t thresh_low __attribute__((address(0x800194)));
volatile uint8_t thresh_sensitivity __attribute__((address(0x800195)));
// If thresh_mode == 0, Sensitivity = High
// If thresh_mode == 1, Sensitivity = Medium
// If thresh_mode >= 2, Sensitivity = Low

volatile uint8_t aux_switch __attribute__((address(0x8001A0)));
// If aux_switch == 3, Auxillary Ports are ON
// If aux_switch == 0, Auxillary Ports are OFF
volatile uint8_t sleep_code __attribute__((address(0x8001A1)));
// If sleep_mode = 0x00, then the device is powered on
// If sleep_mode = 0x0F, then the device restarts
// If sleep_mode = 0xFF, then the device is powered off

int main(void)
{
	// Initialization
	aux_switch = 3;
	adc_num = 0;
	adc_2sAvg = 0;
	adc_20sAvg = 0;
	adc_num_idx = 0;
	adc_2sAvg_idx = 0;
	adc_sum_squared = 0;
	adc_std_dev = 0;
	sleep_code = 0x00;
	DDRC &=~ 0x3F; // Set PINC4:0 as Button Inputs and PINC5 as Input for ADC
	DDRB |= 0x03; // Set PINB1:0 as Outputs for CD4066BE Switches
	
	for(adc_num_idx = 0; adc_num_idx < 50; adc_num_idx++)
	{
		adc_num_arr[adc_num_idx] = 0;
	}
	adc_num_idx = 0;
	adc_avg = 0;
	adc_num_idx = 0;
	for(adc_2sAvg_idx = 0; adc_2sAvg_idx < 10; adc_2sAvg_idx++)
	{
		adc_2sAvg_arr[adc_2sAvg_idx] = 0;
	}
	adc_2sAvg_idx = 0;
	
	thresh_sensitivity = 0; // Set sensitivity to High
	thresh_high = 44;		// High Sensitivity
	thresh_medium = 132;	// Medium Sensitivity
	thresh_low = 220;		// Low Sensitivity
	
	ADMUX = (1 << REFS0)|(1 << MUX2)|(1 << MUX0);
	ADCSRA |= (0b111 << ADPS0);
	ADCSRA |= (1 << ADEN);
	
	PCICR = (1 << PCIE1);
	PCMSK1 = (1 << PCINT12)|(1 << PCINT11)|(1 << PCINT10)|(1 << PCINT9)|(1 << PCINT8);
	
	TCNT1 = 12499;
	TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	TCCR1B = (0b00<<WGM12)|(0b010<<CS10);
	TIMSK1 = (1 << TOIE1);

	sei();
	
	while(1)
	{
		asm("NOP");
	}
}

ISR(TIMER0_OVF_vect)
{
	TCNT1 = 12499;
	ADCSRA |= (1 << ADSC);
	while(ADCSRA & (1 << ADSC));
	// Sleep Button is pressed while the program is running.
	adc_num = ADC;
	if(adc_num_idx >= 0 && adc_num_idx < 100)
	{
		adc_num += adc_num_idx + 1;
		} else {
		adc_num += 200 - adc_num_idx;
	}
	adc_num_arr[adc_num_idx % 50] = adc_num; // Adds Element to the Array
	adc_avg += adc_num_arr[adc_num_idx % 50];
	adc_num_idx++;
	
	if((adc_num_idx > 0) && (adc_num_idx % 50 == 0))
	{
		adc_avg /= 50;
		adc_2sAvg += adc_avg;
		adc_avg = 0;
	}
	
	if(adc_num_idx == 200)
	{
		adc_num_idx = 0;
		adc_2sAvg /= 4;
		adc_2sAvg_arr[adc_2sAvg_idx] = adc_2sAvg;
		adc_2sAvg = 0;
		adc_20sAvg += adc_2sAvg_arr[adc_2sAvg_idx];
		adc_2sAvg_idx++;
	}
	
	if(adc_2sAvg_idx == 10)
	{
		adc_std_dev = 0;
		adc_2sAvg_idx = 0;
		adc_20sAvg /= 10;
		for(adc_2sAvg_idx = 0; adc_2sAvg_idx < 10; adc_2sAvg_idx++)
		{
			adc_sum_squared = adc_2sAvg_arr[adc_2sAvg_idx] - adc_20sAvg;
			adc_sum_squared *= adc_sum_squared;
			adc_std_dev += adc_sum_squared;
		}
		adc_std_dev = (uint16_t)sqrt(adc_std_dev / 10);
		adc_sum_squared = 0;
	}
	
	if(adc_20sAvg + (adc_std_dev * thresh_high) > adc_2sAvg_arr[adc_2sAvg_idx] && thresh_sensitivity == 0) // Above the High Sensitivity Threshold
	{
		aux_switch = 0;
		// Disable Audio
	} else if(adc_20sAvg + (adc_std_dev * thresh_medium) > adc_2sAvg && thresh_sensitivity == 1) // Above the Medium Sensitivity Threshold
	{
		aux_switch = 0;
		// Disable Audio
	} else if(adc_20sAvg + (adc_std_dev * thresh_low) > adc_2sAvg && thresh_sensitivity >= 2) // Above the Low Sensitivity Threshold
	{
		aux_switch = 0;
		// Disable Audio
	}
	
	if(adc_20sAvg + (adc_std_dev * thresh_high) <= adc_2sAvg && thresh_sensitivity == 0) // Below or Equal to the High Sensitivity Threshold
	{
		aux_switch = 3;
		// Enable Audio
	} else if(adc_20sAvg + (adc_std_dev * thresh_medium) <= adc_2sAvg && thresh_sensitivity == 1) // Below or Equal to the Medium Sensitivity Threshold
	{
		aux_switch = 3;
		// Enable Audio
	} else if(adc_20sAvg + (adc_std_dev * thresh_low) <= adc_2sAvg && thresh_sensitivity >= 2) // Below or Equal to Low Sensitivity Threshold
	{
		aux_switch = 3;
		// Enable Audio
	}
	
	if(adc_2sAvg_idx == 10)
	{
		adc_2sAvg_idx = 0;
		adc_20sAvg = 0;
	}

	PORTB = aux_switch;
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
		aux_switch = 3;
		PORTB = aux_switch;
		set_sleep_mode(2);
		sleep_mode();
		} else if(sleep_code == 0x0F) {
		sleep_disable();
		// Initialization
		aux_switch = 3;
		adc_num = 0;
		adc_2sAvg = 0;
		adc_20sAvg = 0;
		adc_num_idx = 0;
		adc_2sAvg_idx = 0;
		adc_sum_squared = 0;
		adc_std_dev = 0;
		sleep_code = 0x00;
		
		for(adc_num_idx = 0; adc_num_idx < 50; adc_num_idx++)
		{
			adc_num_arr[adc_num_idx] = 0;
		}
		adc_num_idx = 0;
		adc_avg = 0;
		adc_num_idx = 0;
		for(adc_2sAvg_idx = 0; adc_2sAvg_idx < 10; adc_2sAvg_idx++)
		{
			adc_2sAvg_arr[adc_2sAvg_idx] = 0;
		}
		adc_2sAvg_idx = 0;
		
		thresh_sensitivity = 0; // Set sensitivity to High
		wdt_enable(WDTO_250MS);
	}
	sei();
}
