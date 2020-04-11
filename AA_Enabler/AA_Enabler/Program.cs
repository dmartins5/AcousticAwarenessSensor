using System;
using System.Data;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;
using System.Linq;

//In order to use ClosedXML namespace, you must download nuget from nuget website
//To enable it, go to Tools -> Nuget package manager -> Manage nuget packages for solution


namespace AA_Enabler

{
    class Program
    {

        /*
         * Select environment from the environments that we have data for. 
         * Loads selected environment. Choose 10 random numbers from the list of 30 numbers from the column for Ambient data.
         * Display the 10 random numbers. We currently do this, but instead of typing in 10 numbers, we want the environment to be simulated in some level as though the last 20 seconds were in that environment.
         * Calculate average and standard deviation for the environment and display threshold
         * Ask user to submit a new 2 second average for the environment.
         * Calculate if that new 2 second average is an interrupt for each threshold setting
         * 
         * average of each environments - real interrupt level
         * 
         * 
         **/

        static void Main(string[] args)
        {
            Console.WriteLine("Select Environment by Environment No (1-6):");
            string selection = Console.ReadLine();

            int select = int.Parse(selection);
            DataTable _dt = new DataTable(); //DataTable Stores values
            DataSet _ds = new DataSet(); //DataSet is used to display values

            string Book1 = @"C:\Users\Jared\source\repos\AA_Enabler\Book1.xlsx";
            string Book2 = @"C:\Users\Jared\source\repos\AA_Enabler\Book2.xlsx";  //Load file from computer location, change as necessary based on where the file is
            string Book3 = @"C:\Users\Jared\source\repos\AA_Enabler\Book3.xlsx";
            string Book4 = @"C:\Users\Jared\source\repos\AA_Enabler\Book4.xlsx";
            string Book5 = @"C:\Users\Jared\source\repos\AA_Enabler\Book5.xlsx";
            string Book6 = @"C:\Users\Jared\source\repos\AA_Enabler\Book6.xlsx";


            switch (select)  //scan user input and select appropriate file
            {
                case 1:
                _dt = ImportSheet(Book1);
                    break;
                    

                case 2:
                    _dt = ImportSheet(Book2);
                    break;

                case 3:
                    _dt = ImportSheet(Book3);
                    break;

                case 4:
                    _dt = ImportSheet(Book4);
                    break;

                case 5:
                    _dt = ImportSheet(Book5);
                    break;

                case 6:
                    _dt = ImportSheet(Book6);
                    break;
            }

            DataTableReader reader = _ds.CreateDataReader(_dt);
            Console.WriteLine("\nData for the set (Ambient, Low, Med, High):\n");
            PrintColumns(reader);

            //string[] str_col = new string[_dt.Rows.Count];
            double[] d_col_Ambient = new double[30];
            double[] d_col_Low = new double[30];
            double[] d_col_Med = new double[30];
            double[] d_col_High = new double[30];


            for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)
            {
                int index_c = 0;

                d_col_Ambient[index_r] = double.Parse(_dt.Rows[index_r][index_c].ToString());

            }

            for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)
            {
                int index_c = 1;

                d_col_Low[index_r] = double.Parse(_dt.Rows[index_r][index_c].ToString());

            }

            for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)
            {
                int index_c = 2;

                d_col_Med[index_r] = double.Parse(_dt.Rows[index_r][index_c].ToString());

            }

            for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)
            {
                int index_c = 3;

                d_col_High[index_r] = double.Parse(_dt.Rows[index_r][index_c].ToString());

            }

            //foreach (double q in d_col_Ambient)     //Test ambient double array
            //{
            //    Console.WriteLine(q);
            //}

            Console.WriteLine();

        double[] ten_rand_ambient = new double[10];

            ten_rand_ambient = ten_Random(d_col_Ambient);

            Console.WriteLine("Ten Random Numbers from Ambient Data Set");

            foreach (double i in ten_rand_ambient)     //Test random integer array of 10
            {
                Console.WriteLine(i);
            }

            Console.WriteLine();
            double ten_avg_ambient = ten_rand_ambient.Average();
            double std;


            Console.WriteLine("Select a Sensitivity Level (Low [1], Medium [2], High [3])");
            string x = Console.ReadLine();
            int t = Int32.Parse(x);


            double sumOfSquaresOfDifferences = d_col_Ambient.Select(val => (val - ten_avg_ambient) * (val - ten_avg_ambient)).Sum();
            std = Math.Sqrt(sumOfSquaresOfDifferences / d_col_Ambient.Length);


            double t1 = ten_avg_ambient + 3.5 * std;
            double t2 = ten_avg_ambient + 12.17 * std;
            double t3 = ten_avg_ambient + 24.03 * std;

            if (t == 3)
            {
                Console.WriteLine("The Instantaneous Threshold Level is: {0}", t1 );

            }
            else if (t == 2)
            {
                Console.WriteLine("The Instantaneous Threshold Level is: {0}", t2);
            }
            else
            {
                Console.WriteLine("The Instantaneous Threshold Level is: {0}", t3);
            }

            Console.WriteLine();


            while (true)
            {
                Console.WriteLine("Enter a two second average:");
                string str = Console.ReadLine();
                double two_avg = double.Parse(str);


                if (t == 3)
                {
                    if (two_avg >= t1)
                    {
                        Console.WriteLine("Interrupt has occurred");
                    }
                    else
                    {
                        Console.WriteLine("No interrupt");
                    }
                }
                if (t == 2)
                {
                    if (two_avg >= t2)
                    {
                        Console.WriteLine("Interrupt has occurred");
                    }
                    else
                    {
                        Console.WriteLine("No interrupt");
                    }
                }
                if (t == 1)
                {
                    if (two_avg >= t3)
                    {
                        Console.WriteLine("Interrupt has occurred");
                    }
                    else
                    {
                        Console.WriteLine("No interrupt");
                    }
                }
            }
        }

   



        public static DataTable ImportSheet(string fileName) 
        {
            var datatable = new DataTable();
            var workbook = new XLWorkbook(fileName);
            var xlWorksheet = workbook.Worksheet(1);
            var range = xlWorksheet.Range(xlWorksheet.FirstCellUsed(), xlWorksheet.LastCellUsed());

            var col = range.ColumnCount();
            var row = range.RowCount();

            //if a datatable already exists, clear the existing table 
            datatable.Clear();
            for (var i = 1; i <= col; i++)
            {
                var column = xlWorksheet.Cell(1, i);
                datatable.Columns.Add(column.Value.ToString());
            }

            var firstHeadRow = 0;
            foreach (var item in range.Rows())
            {
                if (firstHeadRow != 0)
                {
                    var array = new object[col];
                    for (var y = 1; y <= col; y++)
                    {
                        array[y - 1] = item.Cell(y).Value;
                    }

                    datatable.Rows.Add(array);
                }
                firstHeadRow++;
            }
            return datatable;
        }
        static void PrintColumns(DataTableReader reader)
        {
            // Loop through all the rows in the DataTableReader
            while (reader.Read())
            {
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    Console.Write(reader[i] + " ");
                }
                Console.WriteLine();
            }
        }

        static double[] ten_Random(double[] array)
        {
            //Gets 10 random integers from an integer array
            Random rand = new Random();

            double[] ten_array = new double[10];

            for (int i = 0; i < 10; i++)
            {
                int r = rand.Next(array.Length - 1);
                ten_array[i] = array[r];
            }

            return ten_array;
        }
    }
}
