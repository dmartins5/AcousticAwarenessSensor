#include <avr/io.h>
#include <avr/interrupt.h>
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

volatile uint8_t thresh_sensitivity __attribute__((address(0x800190)));
// If thresh_sensitivity = 220, then Sensitivity is Low
// If thresh_sensitivity = 132, then Sensitivity is Medium
// If thresh_sensitivity = 44, then Sensitivity is High

int main(void)
{
	adc_num = 0;
	adc_2sAvg = 0;
	adc_20sAvg = 0;
	adc_num_idx = 0;
	adc_2sAvg_idx = 0;
	adc_sum_squared = 0;
	adc_std_dev = 0;
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
	
	thresh_sensitivity = 44;
	
	//TCNT1 = 12499;
	//TCCR1A = (0b00<<COM1A0)|(0b00<<COM1B0)|(0b00<<WGM10);
	//TCCR1B = (0b00<<WGM12)|(0b010<<CS10);
	//TIMSK1 = (1 << TOIE1);

	sei();
	
    while(1)
    {
		adc_num = adc_2sAvg_idx + adc_num_idx + 1; // Reads ADC
		
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
			adc_20sAvg = 0;
			adc_2sAvg_idx = 0;
			adc_sum_squared = 0;
		}
    }
}

//ISR(TIMER0_OVF_vect)
//{
//	TCNT1 = 12499;
//	
//}
