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
            DataTable _dt = new DataTable(); //DataTable Stores valus
            DataSet _ds = new DataSet(); //DataSet is used to display values

            string Book1 = @"C:\Users\Jared\source\repos\AA_Enabler\Book1.xlsx";
            string Book2 = @"C:\Users\Jared\source\repos\AA_Enabler\Book2.xlsx";  //Load file from computer location
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


            for (int index_c = 0; index_c < 4; index_c++)
            {
                for (int index_r = 0; index_r < _dt.Rows.Count; index_r++)
            {

                    str_col[index_r] = _dt.Rows[index_r][index_c].ToString();

                }
            }

            foreach (string str in str_col)
            {
                Console.WriteLine(str);
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
    }
}
