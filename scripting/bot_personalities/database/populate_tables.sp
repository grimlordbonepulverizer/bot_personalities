public void PopulateTables()
{
	CheckTFClassEmpty();
}

public void CheckTFClassEmpty()
{
	char query[] = "SELECT COUNT(*) FROM tf_class;";
    g_DB.Query(SQL_OnCheckTFClassEmpty, query);
}

public void SQL_OnCheckTFClassEmpty(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') SetFailState("[DB] Error checking tf_class count: %s", error);

	if (results.FetchRow())
	{
		int rowCount = results.FetchInt(0);

		if (rowCount == 0) PopulateTFClassTable();
	}
}

public void PopulateTFClassTable()
{
	char query[] =
		"INSERT INTO tf_class (id, name) VALUES \
			(1, 'scout'), \
			(2, 'sniper'), \
			(3, 'soldier'), \
			(4, 'demoman'), \
			(5, 'medic'), \
			(6, 'heavy'), \
			(7, 'pyro'), \
			(8, 'spy'), \
			(9, 'engineer') \
		";

	g_DB.Query(SQL_OnPopulateTFClassTable, query);
}

public void SQL_OnPopulateTFClassTable(Database db, DBResultSet results, const char[] error, any data)
{
    if (error[0] != '\0') { LogError("[DB] Failed to populate tf_class table: %s", error); return; }
}
