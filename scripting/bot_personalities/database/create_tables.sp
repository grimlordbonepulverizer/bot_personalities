void CreateTables()
{
	SQL_CreateCosmeticTable();
}

public void SQL_CreateCosmeticTable()
{
	char query[] = 
		"CREATE TABLE IF NOT EXISTS cosmetic (\
        	id INTEGER PRIMARY KEY \
        );";
	//Having this be a table isn't necessary rn but I'm adding it just in case I'll want to add some more fields to it later;
    g_DB.Query(SQL_CreateTFClassTable, query);
}

public void SQL_CreateTFClassTable(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') { SetFailState("[DB] Error on creating cosmetic table: %s", error); return; }

	char query[] =
		"CREATE TABLE IF NOT EXISTS tf_class (\
			id INTEGER PRIMARY KEY, \
			name VARCHAR(255) \
		);";
	
	g_DB.Query(SQL_CreateCosmeticSetTable, query);
}

public void SQL_CreateCosmeticSetTable(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') { SetFailState("[DB] Error on creating tf_class table: %s", error); return; }

	char query[] =
        "CREATE TABLE IF NOT EXISTS cosmetic_set (\
			id INTEGER PRIMARY KEY, \
			name VARCHAR(255) \
		);";
	
	g_DB.Query(SQL_CreateCosmeticSetMemberTable, query);
}

public void SQL_CreateCosmeticSetMemberTable(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') { SetFailState("[DB] Error on creating cosmetic_set table: %s", error); return; }
	
	char query[] =
		"CREATE TABLE IF NOT EXISTS cosmetic_set_member (\
			cosmetic_set_id INTEGER, \
			cosmetic_id INTEGER, \
			\
			PRIMARY KEY (cosmetic_set_id, cosmetic_id), \
			FOREIGN KEY (cosmetic_set_id) REFERENCES cosmetic_set(id), \
			FOREIGN KEY (cosmetic_id) REFERENCES cosmetic(id) \
		);";

	g_DB.Query(SQL_CreateTFClassCosmeticTable, query);
}

public void SQL_CreateTFClassCosmeticTable(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') { SetFailState("[DB] Error on creating cosmetic_set_member table: %s", error); return; }

    char query[] =
		"CREATE TABLE IF NOT EXISTS tf_class_cosmetic (\
			class_id INTEGER, \
			cosmetic_id INTEGER, \
			\
			PRIMARY KEY (class_id, cosmetic_id), \
			FOREIGN KEY (class_id) REFERENCES tf_class(id), \
			FOREIGN KEY (cosmetic_id) REFERENCES cosmetic(id) \
		);";

	g_DB.Query(SQL_OnTablesInitialized, query);
}

public void SQL_OnTablesInitialized(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') { SetFailState("[DB] Error on creating tf_class_cosmetic table: %s", error); return; }
}
