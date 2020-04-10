using System;
using System.Data;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;

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
         * Calculate average and standard deviation for the environment and display it.
         * Ask user to submit a new 2 second average for the environment.
         * Calculate if that new 2 second average is an interrupt for each threshold setting
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

            string[] str_col = new string[_dt.Rows.Count];
            double[] d_col_Ambient = new double[30];
            double[] d_col_Low = new double[30];
            double[] d_col_Med = new double[30];
            double[] d_col_High = new double[30];


            for (int index_c = 0; index_c < 4; index_c++)
            {
                for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)   //Printing out data
            {

                    str_col[index_r] = _dt.Rows[index_r][index_c].ToString();

                    int result;

                    switch (index_c) //Each iteration of the table, store into separate double column
                    {
                        case 0:
                            //d_col_Ambient = Array.ConvertAll(str_col, s => double.Parse(s)); //ATTEMPT 1 - CAUSES A NULL EXCEPTION -- TRY INT32 INSTEAD

                            /* foreach (string value in str_col)
                             * try {
                                 result = Convert.ToInt32(value);
                             * 
                             * 
                             */



                            break;
                        case 1:
                            d_col_Low = Array.ConvertAll(str_col, s => double.Parse(s));
                            break;
                        case 2:
                            d_col_Med = Array.ConvertAll(str_col, s => double.Parse(s));
                            break;
                        case 3:
                            d_col_High = Array.ConvertAll(str_col, s => double.Parse(s));
                            break;

                    }

                }
            }

            double[] ten_rand_ambient = new double[10];

            ten_rand_ambient = ten_Random(d_col_Ambient);

            foreach (double i in ten_rand_ambient)     //Test random integer array of 10
            {
                Console.WriteLine(i);
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

            int r = rand.Next(array.Length);

            double[] ten_array = new double[10];

            for (int i = 0; i < 10; i++)
            {
                ten_array[i] = array[r];
            }

            return ten_array;
        }
    }
}
