using System;

namespace Environment_Interrupt
{
    class Program
    {
        //The goal of this program is to use collected averages and standard deviation values to simulate acoustic awareness enabler in particular environment
        //The distinction between this and interrupt.cs is that this does not require a new environment to be made, but uses pre-acquired data from meter
        static void Main()
        {
            double A;

            Console.WriteLine("Enter the average sound level value (dB) for the environment: ");
            string temp_avg = Console.ReadLine();
            Console.WriteLine("Enter the standard deviation of environment:");
            string temp_std = Console.ReadLine();

            double avg = double.Parse(temp_avg);
            double std = double.Parse(temp_std);

            Console.WriteLine("Enter the threshold level (1, 2 or 3):");
            string temp_level = Console.ReadLine();

            int level = int.Parse(temp_level);

            if (level == 1)
            {
                A = 3.5;
            }
            else if (level == 2)
            {
                A = 12.17;
            }
            else if (level == 3)
            {
                A = 24.03;
            }
            else
            {
                A = 0;
                Console.WriteLine("Only three thresholds");
            }

            double threshold = avg + A * std;
            while (true)
            {
                Console.WriteLine("Enter possible interrupt (dB):");
                string temp_interrupt = Console.ReadLine();

                double interrupt = double.Parse(temp_interrupt);

                if (interrupt >= threshold)
                {
                    Console.WriteLine("Interrupt Has Occured");
                    
                }
                else
                {
                    Console.WriteLine("No interrupt. Input another value");
                }
            }

        }
    }
}
