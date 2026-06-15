#define COSMETICS_CONFIG_PATH "configs/bp_cosmetics.cfg"

int defaultCosmetics[22] = {
	52, 107, //SCOUT
	181, 600, //SNIPER
	54, 98, //SOLDIER
	47, 146, //DEMOMAN
	104, 978, 982, //MEDIC
	49, 97, //HEAVY
	105, 253, //PYRO
	55, 319, //SPY
	48, 95, //ENGINEER
	940, 263, 30422 //ALL CLASS
};

char g_ConfigPath[PLATFORM_MAX_PATH];

public void GenerateCosmeticsConfig()
{
	CreateCosmeticsConfigFile();
}

public void CreateCosmeticsConfigFile()
{
    BuildPath(Path_SM, g_ConfigPath, sizeof(g_ConfigPath), COSMETICS_CONFIG_PATH);

    if (!FileExists(g_ConfigPath)) CreateDefaultConfig(g_ConfigPath);
}

public void CreateDefaultConfig(const char[] configPath)
{
	File configFile = OpenFile(configPath, "w");

	if (configFile == null) { LogError("Failed to create config file: %s", configPath); return; }

    configFile.WriteLine("\"cosmetics\"");
    configFile.WriteLine("{");
	
	char itemDefString[16];
	for (int i = 0; i < sizeof(defaultCosmetics); i++) 
	{
		IntToString(defaultCosmetics[i], itemDefString, sizeof(itemDefString));
		WriteConfigLine(configFile, itemDefString);
	}

    configFile.WriteLine("}");

    delete configFile;
}

void WriteConfigLine(File file, const char[] itemIndex)
{
    file.WriteLine("\t\"%s\" \"\"", itemIndex);
}
