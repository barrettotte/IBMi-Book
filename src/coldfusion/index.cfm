<html>
    <body>
        <h2>Calling IBM i with ColdFusion</h2>
        <hr>
        <cfscript>
            local.sql = "
                SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE
                FROM QSYS2.SYSPARTITIONSTAT
                WHERE TABLE_SCHEMA = 'YOURLIB' -- CHANGE ME
                ORDER BY TABLE_PARTITION
            ";

            local.query = new Query();
            local.query.setDataSource("IBMi");
            local.result = local.query.execute(sql=local.sql);

            writeDump(local.result);
        </cfscript>
    </body>
</html>