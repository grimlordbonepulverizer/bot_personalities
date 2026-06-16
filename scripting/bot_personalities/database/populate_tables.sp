public void PopulateTables()
{
	CheckTFClassEmpty();
	CheckEquipRegionEmpty();
}

public void CheckTFClassEmpty()
{
	char query[] = "SELECT COUNT(*) FROM tf_class;";
    g_DB.Query(SQL_OnCheckTFClassEmpty, query);
}

public void CheckEquipRegionEmpty()
{
	char query[] = "SELECT COUNT(*) FROM equip_region;";
    g_DB.Query(SQL_OnCheckEquipRegionEmpty, query);
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

public void SQL_OnCheckEquipRegionEmpty(Database db, DBResultSet results, const char[] error, any data)
{
	if (error[0] != '\0') SetFailState("[DB] Error checking equip_region count: %s", error);

	if (results.FetchRow())
	{
		int rowCount = results.FetchInt(0);
		if (rowCount == 0) PopulateEquipRegionTable();
	}
}

public void PopulateTFClassTable()
{
	char query[] =
		"INSERT INTO tf_class (name) VALUES \
			('scout'), \
			('sniper'), \
			('soldier'), \
			('demoman'), \
			('medic'), \
			('heavy'), \
			('pyro'), \
			('spy'), \
			('engineer') \
		";

	g_DB.Query(SQL_OnPopulateTFClassTable, query);
}

public void PopulateEquipRegionTable()
{
	char query[] =
		"INSERT INTO equip_region (name) VALUES \
			('scout_wings'), ('scout_hands'), ('scout_bandages'), ('scout_pants'), ('scout_backpack'), \
			('soldier_coat'), ('soldier_pocket'), ('soldier_legs'), ('soldier_cigar'), \
			('sniper_headband'), ('sniper_bullets'), ('sniper_legs'), ('sniper_pocket'), ('sniper_vest'), ('sniper_quiver'), ('sniper_pocket_left'), \
			('spy_coat'), \
			('medic_hip'), ('medic_gloves'), ('medic_pipe'), \
			('heavy_bullets'), ('heavy_belt_back'), ('heavy_hair'), ('heavy_belt'), ('heavy_towel'), ('heavy_hip'), ('heavy_pocket'), \
			('pyro_spikes'), ('pyro_tail'), ('pyro_wings'), ('pyro_head_replacement'), \
			('engineer_hair'), ('engineer_wings'), ('engineer_belt'), ('engineer_left_arm'), ('engineer_pocket'), \
			('demo_eyepatch'), ('demoman_collar'), ('demo_head_replacement'), ('demo_belt'), \
			\
			('hat'), ('whole_head'), ('beard'), ('ears'), ('face'), ('head_skin'), ('glasses'), ('lenses'), \
			('flair'), ('shirt'), ('sleeves'), ('right_shoulder'), ('left_shoulder'), ('grenades'), ('necklace'), ('arms'), ('medal'), ('arm_tattoos'), \
			('belt_misc'), ('pants'), ('feet'), \
			\
			('disconnected_floating_item'), ('back'), ('Back'), ('zombie_body'), ('medigun_accessories') \
		";

	g_DB.Query(SQL_OnPopulateEquipRegionTable, query);
}

public void SQL_OnPopulateTFClassTable(Database db, DBResultSet results, const char[] error, any data)
{
    if (error[0] != '\0') { LogError("[DB] Failed to populate tf_class table: %s", error); return; }
}

public void SQL_OnPopulateEquipRegionTable(Database db, DBResultSet results, const char[] error, any data)
{
    if (error[0] != '\0') { LogError("[DB] Failed to populate equip_region table: %s", error); return; }
}
