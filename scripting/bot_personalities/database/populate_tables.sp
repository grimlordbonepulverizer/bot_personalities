char g_sTableNames[][] = {
    "cosmetic", "tf_class", "cosmetic_set", "equip_region",
    "cosmetic_set_member", "tf_class_cosmetic", "equip_region_cosmetic", "equip_region_conflict"
};

public void PopulateTables()
{
    char queryClass[] =
        "INSERT OR IGNORE INTO tf_class (name) VALUES \
            ('scout'), ('sniper'), ('soldier'), ('demoman'), \
            ('medic'), ('heavy'), ('pyro'), ('spy'), ('engineer');";

    g_DB.Query(SQL_OnPopulateTable, queryClass, 1);

	char queryRegion[] =
		"INSERT OR IGNORE INTO equip_region (id, name) VALUES \
			(1, 'scout_wings'), (2, 'scout_hands'), (3, 'scout_bandages'), (4, 'scout_pants'), (5, 'scout_backpack'), \
			(6, 'soldier_coat'), (7, 'soldier_pocket'), (8, 'soldier_legs'), (9, 'soldier_cigar'), \
			(10, 'sniper_headband'), (11, 'sniper_bullets'), (12, 'sniper_legs'), (13, 'sniper_pocket'), (14, 'sniper_vest'), \
			(15, 'sniper_quiver'), (16, 'sniper_pocket_left'), \
			(17, 'spy_coat'), \
			(18, 'medic_hip'), (19, 'medic_gloves'), (20, 'medic_pipe'), \
			(21, 'heavy_bullets'), (22, 'heavy_belt_back'), (23, 'heavy_hair'), (24, 'heavy_belt'), \
			(25, 'heavy_towel'), (26, 'heavy_hip'), (27, 'heavy_pocket'), \
			(28, 'pyro_spikes'), (29, 'pyro_tail'), (30, 'pyro_wings'), (31, 'pyro_head_replacement'), \
			(32, 'engineer_hair'), (33, 'engineer_wings'), (34, 'engineer_belt'), (35, 'engineer_left_arm'), (36, 'engineer_pocket'), \
			(37, 'demo_eyepatch'), (38, 'demoman_collar'), (39, 'demo_head_replacement'), (40, 'demo_belt'), \
			(41, 'hat'), (42, 'whole_head'), (43, 'beard'), (44, 'ears'), (45, 'face'), (46, 'head_skin'), (47, 'glasses'), \
			(48, 'lenses'), (49, 'flair'), (50, 'shirt'), (51, 'sleeves'), (52, 'right_shoulder'), (53, 'left_shoulder'), \
			(54, 'grenades'), (55, 'necklace'), (56, 'arms'), (57, 'medal'), (58, 'arm_tattoos'), \
			(59, 'belt_misc'), (60, 'pants'), (61, 'feet'), \
			(62, 'disconnected_floating_item'), (63, 'back'), (64, 'Back'), (65, 'zombie_body'), (66, 'medigun_accessories') \
		";

    g_DB.Query(SQL_OnPopulateTable, queryRegion, 3);

	char queryRegionConflict[] =
		"INSERT OR IGNORE INTO equip_region_conflict (equip_region_id, conflicting_equip_region_id) VALUES \
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), \
			(15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20), (21, 21), (22, 22), (23, 23), (24, 24), (25, 25), (26, 26), \
			(27, 27), (28, 28), (29, 29), (30, 30), (31, 31), (32, 32), (33, 33), (34, 34), (35, 35), (36, 36), (37, 37), (38, 38), \
			(39, 39), (40, 40), (41, 41), (41, 42), (42, 41), (42, 42), (42, 45), (42, 47), (43, 43), (44, 44), (45, 42), (45, 45), \
			(45, 47), (46, 46), (47, 42), (47, 45), (47, 47), (47, 48), (48, 48), (49, 49), (50, 50), (51, 51), (52, 52), (53, 53), \
			(54, 54), (55, 55), (56, 56), (57, 57), (58, 58), (59, 59), (60, 60), (61, 61), (62, 62), (63, 63), (64, 64), (65, 65), \
			(66, 66) \
		";
	
    g_DB.Query(SQL_OnPopulateTable, queryRegionConflict, 7);
}

public void SQL_OnPopulateTable(Database db, DBResultSet results, const char[] error, any data)
{
    if (error[0] != '\0') 
    { 
        LogError("[DB] Failed to populate %s table: %s", g_sTableNames[data], error); 
        return; 
    }
}
