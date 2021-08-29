extends Node

var save_path = "user://saves/save.dat"
var dir_save_path = "user://saves"

var FirstTimeSave = false

var AllData = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime,
	"EG.RivaleName" : EG.RivalName,
	"PG.Badge" : PG.Badge,
	"PG.Argent" : PG.Argent,
	"PG.ActualScene" : PG.ActualScene,
	"PG.ActualSceneFile" : PG.ActualSceneFile,
	"PG.Last_position" : PG.Last_position,
	"PG.NodePositionPath" : PG.NodePositionPath,
	"PG.ActualPlace" : PG.ActualPlace,
	"PSS.PSSList" : PSS.PSSList,
	"PG.AllObject" : PG.AllObject}
var DefaulValue = {
	"PG.PlayerName" : "1",
	"PG.Pokemon1" : null,
	"PG.Pokemon2" : null,
	"PG.Pokemon3" : null,
	"PG.Pokemon4" : null,
	"PG.Pokemon5" : null,
	"PG.Pokemon6" : null,
	"PG.GameTime" : {Minutes = 0,Hours = 0,Days = 0},
	"EG.RivaleName" : "Rival",
	"PG.Badge" : {BadgeRoche = false,BadgeCascade = false,BadgeFoudre = false,BadgePrisme = false,BadgeAme = false,BadgeMarais = false,BadgeVolcan = false,BadgeTerre = false},
	"PG.Argent" : 0,
	"PG.ActualScene" : "/root/StartHouse1-Top",
	"PG.ActualSceneFile" : "res://Map/AllInsideObject/BourgPalette/StartHouse1-Top.tscn",
	"PG.Last_position" : Vector2(0,0),
	"PG.NodePositionPath" : "StartHouse1",
	"PG.ActualPlace" : "Bourg-Palette",
	"PSS.PSSList" : [null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],
	"PG.AllObject" : { 
		"NumberObject" : {Potion = 10,SuperPotion = 0,HyperPotion = 0,MaxPotion = 0,Guerison = 0,Rappel = 0,RappelMax = 0,Antidote = 0,AntiPara = 0,AntiBrule = 0,Reveil = 0,TotalSoin = 0,Eau = 0,Soda = 0,Limonade = 0,Lait = 0,Pokeball = 10,SuperBall = 5,HyperBall = 0,FiletBall = 0,FaibloBall = 0,MasterBall = 0,Repousse = 0,SuperRepousse = 0},
		"Unlock" : {ChaussuresDeCourse = true,OrbeMysterieuse = false}},
	"PG.PNJActivate" : {"Scout Omar" : true,"Scout Alfred" : true,"Scout Anthony" : true,"Scout Charles" : true,"Scout Sammy" : true}}
#Save Game -> Get all importants values and add the dictionnary to a file -> path = user://saves/save.txt
func saveGame(restart) :
	if restart : 
		var save = File.new()
		var error = save.open(save_path,File.WRITE)
		if error == OK :
			save.store_var(DefaulValue)
			save.close()
	else :
		var save = File.new()
		if save.file_exists(save_path) :
			var error = save.open(save_path,File.WRITE)
			if error == OK :
				saveData()
				save.store_var(AllData)
				save.close()
func saveData() : 
	AllData = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime,
	"EG.RivaleName" : EG.RivalName,
	"PG.Badge" : PG.Badge,
	"PG.Argent" : PG.Argent,
	"PG.ActualScene" : PG.ActualScene,
	"PG.ActualSceneFile" : PG.ActualSceneFile,
	"PG.Last_position" : PG.Last_position,
	"PG.NodePositionPath" : "LastPosition",
	"PG.ActualPlace" : PG.ActualPlace,
	"PSS.PSSList" : PSS.PSSList,
	"PG.AllObject" : PG.AllObject,
	"PG.PNJActivate" : PG.PNJActivate
	}

#Load Game -> Get Var in a file and load value in Dictionnary
func loadGame() :
	loadAllDataFromFile()
	for x in AllData :
		loadActualData(x)
func loadAllDataFromFile() :
	var save = File.new()
	save.open(save_path, File.READ)
	AllData = save.get_var()
	save.close()
	if AllData == null : restartGame()
func loadActualData(TheData) :
	var save = File.new()
	save.open(save_path, File.READ)
	match TheData :
		"PG.PlayerName" : PG.PlayerName = AllData[TheData]
		"PG.Pokemon1" : PG.Pokemon1 = AllData[TheData]
		"PG.Pokemon2" : PG.Pokemon2 = AllData[TheData]
		"PG.Pokemon3" : PG.Pokemon3 = AllData[TheData]
		"PG.Pokemon4" : PG.Pokemon4 = AllData[TheData]
		"PG.Pokemon5" : PG.Pokemon5 = AllData[TheData]
		"PG.Pokemon6" : PG.Pokemon6 = AllData[TheData]
		"PG.GameTime" : PG.GameTime = AllData[TheData]
		"EG.RivaleName" : EG.RivalName = AllData[TheData]
		"PG.Badge" : PG.Badge = AllData[TheData]
		"PG.Argent" : PG.Argent = AllData[TheData]
		"PG.ActualScene" : PG.ActualScene = AllData[TheData]
		"PG.ActualSceneFile" : PG.ActualSceneFile = AllData[TheData]
		"PG.Last_position" : PG.Last_position = AllData[TheData]
		"PG.NodePositionPath" : PG.NodePositionPath = AllData[TheData]
		"PG.ActualPlace" : PG.ActualPlace = AllData[TheData]
		"PSS.PSSList" : PSS.PSSList = AllData[TheData]
		"PG.AllObject" : PG.AllObject = AllData[TheData]
		"PG.PNJActivate" : PG.PNJActivate = AllData[TheData]
	save.close()

#New Game -> To start a new game, replacing all values for default
func restartGame() :
	var dir = Directory.new()
	if dir.dir_exists(dir_save_path) : pass
	else : dir.make_dir(dir_save_path)
	deleteSave()
func deleteSave() :
	AllData = DefaulValue
	saveGame(true)
	loadGame()
