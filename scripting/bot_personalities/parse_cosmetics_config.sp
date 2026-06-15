public ArrayList ParseCosmeticsConfig()
{	
	ArrayList tempCosmetics = new ArrayList();
	KeyValues kv = new KeyValues("cosmetics");
    
    if (!kv.ImportFromFile(g_ConfigPath))
    {
        LogError("Failed to load cosmetics config");
        delete kv;
        return tempCosmetics;
    }	

    if (kv.GotoFirstSubKey(false))
    {
        do
        {
            char sCosmeticId[16];

            kv.GetSectionName(sCosmeticId, sizeof(sCosmeticId));
            int cosmeticId = StringToInt(sCosmeticId);
			
			tempCosmetics.Push(cosmeticId);
        } 
		while (kv.GotoNextKey(false));
    }

    delete kv;
	return tempCosmetics;
}
