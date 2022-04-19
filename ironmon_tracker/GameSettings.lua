GameSettings = {
	game = 0,
	gamename = "",
	gamecolor = 0,
	rngseed = 0,
	mapbank = 0,
	mapid = 0,
	encountertable = 0,
	pstats = 0,
	estats = 0,
	rng = 0,
	rng2 = 0,
	wram = 0,
	version = 0,
	language = 0,
	trainerpointer = 0,
	coords = 0,
	roamerpokemonoffset = 0,

	versiongroup = 0,
	beginbattleaddress = 0,
	endbattleaddress = 0,
	attacktriggeraddress = 0,
	chosenmoveaddress = 0,
	lastusedabilityaddress = 0,
	attackeraddress = 0,
	whiteoutaddress = 0
}
GameSettings.VERSIONS = {
	RS = 1,
	E = 2,
	FRLG = 3
}
GameSettings.LANGUAGES = {
	U = 1,
	J = 2,
	F = 3,
	S = 4,
	G = 5,
	I = 6
}

function GameSettings.initialize()
	local gamecode = memory.read_u32_be(0x0000AC, "ROM")
	local pstats = {0x3004360, 0x20244EC, 0x2024284, 0x3004290, 0x2024190, 0x20241E4} -- Player stats
	local estats = {0x30045C0, 0x2024744, 0x202402C, 0x30044F0, 0x20243E8, 0x2023F8C} -- Enemy stats
	local rng    = {0x3004818, 0x3005D80, 0x3005000, 0x3004748, 0x3005AE0, 0x3005040} -- RNG address
	local coords = {0x30048B0, 0x2037360, 0x2036E48, 0x30047E0, 0x2037000, 0x2036D7C} -- X/Y coords
	local rng2   = {0x0000000, 0x0000000, 0x20386D0, 0x0000000, 0x0000000, 0x203861C} -- RNG encounter (FRLG only)
	local wram	 = {0x0000000, 0x2020000, 0x2020000, 0x0000000, 0x0000000, 0x201FF4C} -- WRAM address
	local mapbank = {0x20392FC, 0x203BC80, 0x203F3A8, 0x2038FF4, 0x203B94C, 0x203F31C} -- Map Bank
	local mapid = {0x202E83C, 0x203732C, 0x2036E10, 0x202E59C, 0x2036FCC, 0x2036D44} -- Map ID
	local trainerpointer = {0x3001FB4, 0x3005D90, 0x300500C, 0x3001F28, 0x3005AF0, 0x300504C} -- Trainer Data Pointer
	local roamerpokemonoffset = {0x39D4, 0x4188, 0x4074, 0x39D4, 0x4188, 0x4074}
	
	if gamecode == 0x42504545 then
		GameSettings.game = 2
		GameSettings.gamename = "Pokemon Emerald (U)"
		GameSettings.gamecolor = 0xFF009D07
		GameSettings.encountertable = 0x8552D48
		GameSettings.version = GameSettings.VERSIONS.E
		GameSettings.language = GameSettings.LANGUAGES.U
		GameSettings.versiongroup = 1
		GameSettings.beginbattleaddress = 0x08039ECC --BeginBattleIntro
		GameSettings.endbattleaddress = 0x0803DF70 --ReturnFromBattleToOverworld
		GameSettings.abilityaddress = 0x0203aba4 --sBattlerAbilities
		GameSettings.attacktriggeraddress = 0x0814f8f8 --ChooseMoveUsedParticle
		GameSettings.chosenmoveaddress = 0x020241EC --gChosenMove
		GameSettings.attackeraddress = 0x0202420B --gBattlerAttacker
		GameSettings.whiteoutaddress = 0x08084620 --DoWhiteOut
	elseif gamecode == 0x42505245 then
		GameSettings.game = 3
		GameSettings.gamename = "Pokemon FireRed (U)"
		GameSettings.gamecolor = 0xFFF85800
		GameSettings.encountertable = 0x83C9CB8
		GameSettings.version = GameSettings.VERSIONS.FRLG
		GameSettings.language = GameSettings.LANGUAGES.U
		GameSettings.versiongroup = 2
		GameSettings.beginbattleaddress = 0x080123d4
		GameSettings.endbattleaddress = 0x08015b6c
		GameSettings.abilityaddress = 0x02039a30
		GameSettings.attacktriggeraddress = 0x080d86dc
		GameSettings.chosenmoveaddress = 0x02023d4c
		GameSettings.attackeraddress = 0x02023d6b
		GameSettings.whiteoutaddress = 0x08054bdc
	elseif gamecode == 0x42504745 then
		GameSettings.game = 3
		GameSettings.gamename = "Pokemon LeafGreen (U)"
		GameSettings.gamecolor = 0xFF40D060
		GameSettings.encountertable = 0x83C9AF4
		GameSettings.version = GameSettings.VERSIONS.FRLG
		GameSettings.language = GameSettings.LANGUAGES.U
		GameSettings.versiongroup = 2
		GameSettings.beginbattleaddress = 0x080123d4
		GameSettings.endbattleaddress = 0x08015b6c
		GameSettings.abilityaddress = 0x02039a30
		GameSettings.attacktriggeraddress = 0x080d86b0
		GameSettings.chosenmoveaddress = 0x02023d4c
		GameSettings.attackeraddress = 0x02023d6b
		GameSettings.whiteoutaddress = 0x08054bdc
	else
		GameSettings.game = 0
		GameSettings.gamename = "Unsupported game"
		GameSettings.encountertable = 0
	end
	
	if GameSettings.game > 0 then
		GameSettings.pstats  = pstats[GameSettings.game]
		GameSettings.estats  = estats[GameSettings.game]
		GameSettings.rng     = rng[GameSettings.game]
		GameSettings.rng2    = rng2[GameSettings.game]
		GameSettings.wram	 = wram[GameSettings.game]
		GameSettings.mapbank = mapbank[GameSettings.game]
		GameSettings.mapid = mapid[GameSettings.game]
		GameSettings.trainerpointer = trainerpointer[GameSettings.game]
		GameSettings.coords = coords[GameSettings.game]
		GameSettings.roamerpokemonoffset = roamerpokemonoffset[GameSettings.game]
	end
	
	if GameSettings.game % 3 == 1 then
		GameSettings.rngseed = 0x5A0
	else
		GameSettings.rngseed = Memory.readword(GameSettings.wram)
	end
end