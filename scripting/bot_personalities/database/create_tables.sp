#include "populate_tables.sp"

static const char g_sCreateQueries[][] = {
    "CREATE TABLE IF NOT EXISTS cosmetic (id INTEGER PRIMARY KEY);",
    
    "CREATE TABLE IF NOT EXISTS tf_class (id INTEGER PRIMARY KEY, name VARCHAR(255) UNIQUE);",
    
    "CREATE TABLE IF NOT EXISTS cosmetic_set (id INTEGER PRIMARY KEY, name VARCHAR(255) UNIQUE);",
    
    "CREATE TABLE IF NOT EXISTS equip_region (id INTEGER PRIMARY KEY, name VARCHAR(255) UNIQUE);",
    
    "CREATE TABLE IF NOT EXISTS cosmetic_set_member (\
        cosmetic_set_id INTEGER, cosmetic_id INTEGER, \
        PRIMARY KEY (cosmetic_set_id, cosmetic_id), \
        FOREIGN KEY (cosmetic_set_id) REFERENCES cosmetic_set(id), \
        FOREIGN KEY (cosmetic_id) REFERENCES cosmetic(id));",
        
    "CREATE TABLE IF NOT EXISTS tf_class_cosmetic (\
        class_id INTEGER, cosmetic_id INTEGER, \
        PRIMARY KEY (class_id, cosmetic_id), \
        FOREIGN KEY (class_id) REFERENCES tf_class(id), \
        FOREIGN KEY (cosmetic_id) REFERENCES cosmetic(id));",
        
    "CREATE TABLE IF NOT EXISTS equip_region_cosmetic (\
        equip_region_id INTEGER, cosmetic_id INTEGER, \
        PRIMARY KEY (equip_region_id, cosmetic_id), \
        FOREIGN KEY (equip_region_id) REFERENCES equip_region(id), \
        FOREIGN KEY (cosmetic_id) REFERENCES cosmetic(id));",
        
    "CREATE TABLE IF NOT EXISTS equip_region_conflict (\
        equip_region_id INTEGER, conflicting_equip_region_id INTEGER, \
        PRIMARY KEY (equip_region_id, conflicting_equip_region_id), \
        FOREIGN KEY (equip_region_id) REFERENCES equip_region(id), \
        FOREIGN KEY (conflicting_equip_region_id) REFERENCES equip_region(id));"
};

void CreateTables()
{
    ExecuteCreationStep(0);
}

void ExecuteCreationStep(int index)
{
    if (index >= sizeof(g_sCreateQueries))
    {
        PopulateTables();
        return;
    }
    
    g_DB.Query(SQL_OnTableCreated, g_sCreateQueries[index], index);
}

public void SQL_OnTableCreated(Database db, DBResultSet results, const char[] error, any data)
{
    int index = data;

    if (error[0] != '\0') 
    { 
        SetFailState("[DB] Error on creating %s table: %s", g_sTableNames[index], error); 
        return; 
    }

    ExecuteCreationStep(index + 1);
}
