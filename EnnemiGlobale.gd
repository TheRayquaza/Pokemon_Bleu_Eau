extends Node

var TextureFight
var EnnemiName

#Pokemon Of the ennemi
var Pokemon1 = null
var Pokemon2 = null
var Pokemon3 = null
var Pokemon4 = null
var Pokemon5 = null
var Pokemon6 = null
var ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]

func CheckNumberOfPokemon() :
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
func loadTexture(TextureToLoad) :
	TextureToLoad.texture = TextureFight

#Others
export (String) var RivalName
