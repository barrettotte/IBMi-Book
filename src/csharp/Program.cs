using System.Data.Odbc;

namespace Example
{
    class Program
    {
        static void Main(string[] args)
        {
            // Setup connection
            var conn = new OdbcConnection("Driver={IBM i Access ODBC Driver};" + String.Format(
            "System={0};Uid={1};Pwd={2}", "MY400", "USER", "MYPASSWORD"));

            // Create SQL statement
            var sqlCmd = ibmi.Db2Conn.CreateCommand();
            sqlCmd.CommandText = @"
                SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE
                FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'OTTEB1'
                ORDER BY TABLE_PARTITION";

            // Execute
            var dbReader = sqlCmd.ExecuteReader();

            // Print the results
            int colCount = dbReader.FieldCount;
            for(int i = 0; i < colCount; i++){
                String col = dbReader.GetName(i);
                Console.Write(col + ",");
            }
            Console.WriteLine();

            while(dbReader.Read()){
                for(int i = 0; i < colCount; i++){
                    object obj = dbReader.GetValue(i);
                    String col = (obj == null ? "NULL" : obj.ToString());
                    Console.Write(col + ",");
                }
                Console.WriteLine();
            }

            // Cleanup objects
            dbReader.Close();
            sqlCmd.Dispose();
            conn.Close();
        }
    }
}