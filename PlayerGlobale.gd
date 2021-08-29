extends Node

var UnUsed

#Pokemon Of the player
export (Dictionary) var PokemonTypical = {
	#First Information
	Name = null,
	Lvl = null,
	Hp = null,
	MaxHp = null,
	#Experience
	Experience = null,
	ExperienceNeededToLvlUp = null,
	LvlNeededToEvolve = null,
	#Stats
	Puissance = null,
	AttaqueSpecial = null,
	Defense = null,
	DefenseSpecial = null,
	Vitesse = null,
	#Attaque Information
	Attaque1 = null,
	Attaque2 = null,
	Attaque3 = null,
	Attaque4 = null,
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null,
	#Type of the Pokemon
	Type1 = null,
	Type2 = null,
	#Others
	Statut = null}
export (Dictionary) var Pokemon1 = {
	Name = "Carapuce",
	Lvl = 3,
	Hp = 19,
	MaxHp = 19,
	
	Experience = 20,
	ExperienceNeededToLvlUp = 30,
	LvlNeededToEvolve = 16,
	
	Puissance = 48,
	Defense = 65,
	AttaqueSpecial = 50,
	DefenseSpecial = 64,
	Vitesse = 1000,
	
	Attaque1 = "Lance-Soleil",
	Attaque2 = "Feu d'Enfer",
	Attaque3 = "Ouragan",
	Attaque4 = "Choc Mental",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20,
	
	Type1 = "Eau",
	Type2 = null,
	
	Statut = ""}
export (Dictionary) var Pokemon2 = {
	Name = "Salameche",
	Lvl = 5,
	Hp = 20,
	MaxHp = 25,
	Puissance = 48,
	Defense = 65,
	AttaqueSpecial = 50,
	DefenseSpecial = 64,
	Vitesse = 60,
	Experience = 0,
	LvlNeededToEvolve = 16,
	ExperienceNeededToLvlUp = 30,
	Attaque1 = "Griffe",
	Attaque2 = "Rugissement",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20,
	Type1 = "Feu",
	Type2 = null,
	Statut = ""}
export (Dictionary) var Pokemon3 = {
	Name = "Bulbizarre",
	Lvl = 5,
	Hp = 20,
	MaxHp = 25,
	Puissance = 48,
	Defense = 65,
	AttaqueSpecial = 50,
	DefenseSpecial = 64,
	Vitesse = 60,
	Experience = 20,
	LvlNeededToEvolve = 16,
	ExperienceNeededToLvlUp = 30,
	Attaque1 = "Griffe",
	Attaque2 = "Rugissement",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20,
	Type1 = "Plante",
	Type2 = "Poison",
	Statut = ""}
export (Dictionary) var Pokemon4 = null
export (Dictionary) var Pokemon5 = null
export (Dictionary) var Pokemon6 = null
export (Dictionary) var ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]
#Object of the Player
export (Dictionary) var AllObject = {
	"NumberObject" : {
	#	Number Medicaments
		Potion = 0,
		SuperPotion = 0,
		HyperPotion = 0,
		MaxPotion = 0,
		Guerison = 0,
		Rappel = 0,
		RappelMax = 0,
		Antidote = 0,
		AntiPara = 0,
		AntiBrule = 0,
		Reveil = 0,
		TotalSoin = 0,
		Eau = 0,
		Soda = 0,
		Limonade = 0,
		Lait = 0,
	#	Number Pokeball
		Pokeball = 0,
		SuperBall = 0,
		HyperBall = 0,
		FiletBall = 0,
		FaibloBall = 0,
		MasterBall = 0,
	#	Number Others objects
		Repousse = 0,
		SuperRepousse = 0},
	"Unlock" : {
		ChaussuresDeCourse = false,
		OrbeMysterieuse = false}
}
export (Dictionary) var Badge = {
	BadgeRoche = false,
	BadgeCascade = false,
	BadgeFoudre = false,
	BadgePrisme = false,
	BadgeAme = false,
	BadgeMarais = false,
	BadgeVolcan = false,
	BadgeTerre = false}
#Others
export (int) var Argent = 0
export (String) var PlayerName = "1"
export (Dictionary) var GameTime = {
	Minutes = 0,
	Hours = 0,
	Days = 0}
#Function : Count Pokemon
func CheckNumberOfPokemon() :
	ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]
	var NumberOfPokemon = 0
	for x in ListPokemon :
		if (x == null or x.Hp <= 0) :
			break
		else :
			NumberOfPokemon = NumberOfPokemon + 1
	return NumberOfPokemon
func GetAPokemonInLife() :
	var PokemonNumber = 0
	for x in ListPokemon :
		if (x != null and x.Hp != 0) :
			return PokemonNumber
		else :
			PokemonNumber = PokemonNumber + 1
	return null
func CheckDictionnaryPokemonFree() :
	var c = 0
	for x in ListPokemon :
		c = c + 1
		if x == null :
			return c
#Function : reload ditionnary
func ReloadDictionnary() :
	ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]
	return ListPokemon
#IDLE AND ANIMATION
var CantMoveCauseChangingScene
var CantMoveCauseJumping
#POSITION AND SCENE
export (String) var NodePositionPath
export (Vector2) var Last_position
export (String) var ActualScene
export (String) var ActualPlace
export (String) var ActualSceneFile
#PNJ
export (Dictionary) var PNJActivate = {"Scout Omar" : true,"Scout Alfred" : true,"Scout Anthony" : true,"Scout Charles" : true,"Scout Sammy" : true}
#Evolve
var SomeoneEvolve = false
var NumberPokemonEvolve = 5
#GLOBAL VAR FOR SPEED PLAYER
export (bool) var IsShoesEquip = false
#MENU USER VAR
export (bool) var CantdisplayMenu = false
