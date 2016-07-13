function LoadGamePlayScripts()
	dofile("./Data/Scripting/Player/PlayerFMS.lua") --To fix OnIdleEnter bug
	dofile("./Data/Scripting/Player/Player.lua")
	dofile("./Data/Scripting/Weapons/Armor.lua")
	dofile("./Data/Scripting/Weapons/Weapon.lua")
	dofile("./Data/Scripting/Enemies/Enemy.lua")
	dofile("./Data/Scripting/Enemies/BasicEnemy.lua")
	dofile("./Data/Scripting/Enemies/BasicEnemyFSM.lua")
	dofile("./Data/Scripting/Enemies/RangedEnemy.lua")
	dofile("./Data/Scripting/Enemies/RangedEnemyFSM.lua")
	dofile("./Data/Scripting/Enemies/BruteEnemy.lua")
	dofile("./Data/Scripting/Enemies/BruteEnemyFSM.lua")
	dofile("./Data/Scripting/Enemies/Dragon.lua")
	dofile("./Data/Scripting/Enemies/DragonFSM.lua")
	dofile("./Data/Scripting/Elements/ActivableElement.lua")
	dofile("./Data/Scripting/Elements/DestructibleWall.lua")
	dofile("./Data/Scripting/Elements/Pedestal.lua")
	dofile("./Data/Scripting/Elements/ShadowManager.lua")
	dofile("./Data/Scripting/Elements/LightsManager.lua")
	g_LogManager:Log("Gameplayscripts loaded.")
end