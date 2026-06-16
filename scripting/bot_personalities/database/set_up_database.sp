Database g_DB;

void SetUpDatabase()
{
    KeyValues kv = new KeyValues("db");

    kv.SetString("driver", "sqlite");
    kv.SetString("database", "bot_personalities");

    char error[255];
    g_DB = SQL_ConnectCustom(kv, error, sizeof(error), false);

    delete kv;

    if (g_DB == null) SetFailState("DB connection failed: %s", error);
}


