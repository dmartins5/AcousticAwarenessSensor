using System;
using System.Data;
using Excel = Microsoft.Office.Interop.Excel;
using ClosedXML.Excel;




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
            DataTable _dt = new DataTable();

            string Book1 = @"C:\Users\Jared\source\repos\AA_Enabler\Book1.xlsx";
            string Book2 = @"C:\Users\Jared\source\repos\AA_Enabler\Book2.xlsx";
            string Book3 = @"C:\Users\Jared\source\repos\AA_Enabler\Book3.xlsx";
            string Book4 = @"C:\Users\Jared\source\repos\AA_Enabler\Book4.xlsx";
            string Book5 = @"C:\Users\Jared\source\repos\AA_Enabler\Book5.xlsx";
            string Book6 = @"C:\Users\Jared\source\repos\AA_Enabler\Book6.xlsx";


            switch (select)
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
    }
}
