#define TEMP_COSMETICS_CONFIG_PATH "configs/bp_cosmetics.tmp"

void StripNewline(char[] text)
{
    int len = strlen(text);
    
    if (len > 0 && text[len - 1] == '\n') text[--len] = '\0'; 
    if (len > 0 && text[len - 1] == '\r') text[len - 1] = '\0';
}

public void AddCosmeticsConfigComments(ArrayList cosmetics)
{
    File configFile = OpenFile(g_ConfigPath, "r");
    if (configFile == null) return;

    char tempConfigPath[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, tempConfigPath, sizeof(tempConfigPath), TEMP_COSMETICS_CONFIG_PATH);
    File tempConfigFile = OpenFile(tempConfigPath, "w");
    
    if (tempConfigFile == null) { delete configFile; return; }

    int cosmeticIndex = 0;
    int totalCosmetics = cosmetics.Length;
    char line[256];
	bool done = false;
    
    while (configFile.ReadLine(line, sizeof(line)))
    {        
        StripNewline(line);	

        if (line[0] == '\0' || line[0] == '{' || line[0] == '}' || done) { tempConfigFile.WriteLine(line); continue; }

        char sLineCosmeticId[16];
        int quoteCount = 0, sLineCosmeticIdIndex = 0;

        for (int i = 0; i < strlen(line); i++)
        {
            if (line[i] == '"') { quoteCount++; continue; }
			else if (line[i] == '/') break;

            if (quoteCount == 1)
                sLineCosmeticId[sLineCosmeticIdIndex++] = line[i];
			else if (quoteCount > 1) break;
        }
		
		if (sLineCosmeticIdIndex == 0) { tempConfigFile.WriteLine(line); continue; }

        sLineCosmeticId[sLineCosmeticIdIndex] = '\0';
        
        int lineCosmeticId = StringToInt(sLineCosmeticId);

        if (cosmeticIndex < totalCosmetics)
        {
            int cosmeticId = cosmetics.Get(cosmeticIndex);

            if (lineCosmeticId == cosmeticId)
            {
                char cosmeticName[64];

                if (TF2Econ_GetItemName(cosmeticId, cosmeticName, sizeof(cosmeticName)) && StrContains(line, "//") == -1 && StrContains(line, "/*") == -1)
                    Format(line, sizeof(line), "%s \t // %s", line, cosmeticName);

                cosmeticIndex++;

				if (cosmeticIndex >= totalCosmetics) done = true;
            }
        }

        tempConfigFile.WriteLine(line);
    }

    delete configFile;
    delete tempConfigFile;

    DeleteFile(g_ConfigPath);
    RenameFile(g_ConfigPath, tempConfigPath);
}
