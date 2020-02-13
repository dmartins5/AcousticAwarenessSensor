// Jared Alves
// Stephen Felix
// Michael Benker


using System;
using System.Linq;
using System.Collections.Generic;

namespace DSPSrDesign
{
    class Program
    {
        static void Main(string[] args)
        {
            double two_avg = 0;
            double twenty_avg = 0;
            //double std_20 = 0;
            //double T1 = 0;
            //double T2 = 0;
            //double T3 = 0;

            int time = 0;
            int alltime = 0;

            int A = 4;
            double Threshold;
            double sd = 0;

            double[] inputdata_two = new double[200];
            double[] inputdata_twenty = new double[10];

            while (true) {



                Console.WriteLine("Time is {0} seconds", alltime);

                Console.WriteLine("Enter a minimum value (dB) between 30 and 90:");
                string Min = Console.ReadLine();
                Console.WriteLine("Enter maximum value (dB) between 30 and 90:");
                string Max = Console.ReadLine();

                int Min_int = Int32.Parse(Min);
                int Max_int = Int32.Parse(Max);


                Random randNum = new Random();
                for (int i = 0; i < inputdata_two.Length; i++)
                {
                    inputdata_two[i] = randNum.Next(Min_int, Max_int);
                }


                two_avg = inputdata_two.Average();   //Get average of random data
                Console.WriteLine("The two second average is {0}", two_avg);


                inputdata_twenty[time/2] = two_avg;

                foreach (double item in inputdata_twenty)
                {
                    Console.WriteLine(item.ToString());
                }
                Threshold= A*sd + twenty_avg;

                if (alltime > 20)
                {
                    if (two_avg >= Threshold)
                    {
                        alltime = -2;

                        Console.WriteLine("Interrupt has occurred");
                    }
                }

                if (alltime >= 20)
                {
                    
                   
                    twenty_avg = inputdata_twenty.Average();
                    Console.WriteLine("The twenty second average is {0}", twenty_avg);

                    double sumOfSquaresOfDifferences = inputdata_twenty.Select(val => (val - twenty_avg) * (val - twenty_avg)).Sum();
                    sd = Math.Sqrt(sumOfSquaresOfDifferences / inputdata_twenty.Length);
                    Console.WriteLine("The twenty second standard deviation is {0}", sd);

                }
                

                Console.WriteLine("------------------------------------------\n \n");
                alltime = alltime + 2;
                if (time < 18)
                {
                    time = time + 2;
                }
                else
                {
                    time = 0;
                }


            }
        }
    }
}
