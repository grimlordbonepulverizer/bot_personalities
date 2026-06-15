#include <sourcemod>
#include <tf_econ_data>
#include "bot_personalities/generate_cosmetics_config.sp"

public Plugin myinfo =
{
	name = "Bot Personalities",
	author = "Grimlord bone pulverizer",
	description = "Gives the tfbots a bit more personality",
	version = "1.0",
	url = "https://github.com/grimlordbonepulverizer/bot_personalities"
};

public void OnPluginStart() 
{
	GenerateCosmeticsConfig();
}

public void OnAllPluginsLoaded() 
{
	/*
	int cosmeticId = 53;	
	char cosmeticName[64];

	bool canSpyWear = TF2Econ_GetItemLoadoutSlot(cosmeticId, TFClass_Spy) != -1;
	TF2Econ_GetItemName(cosmeticId, cosmeticName, sizeof(cosmeticName));

	PrintToServer("Spy can%s wear %s", canSpyWear ? "" : "'t", cosmeticName);
	*/
}
