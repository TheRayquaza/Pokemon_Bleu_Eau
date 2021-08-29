extends Node

export (Dictionary) var PokedexList = {
	"AllDiscover" : {
		"Bulbizarre" : false,
		"Herbizarre" : false,
		"Florizarre" : false,
		"Salameche" : true,
		"Reptincel" : false,
		"Dracaufeu" : false,
		"Carapuce" : true,
		"Carabaffe" : false,
		"Tortank" : false,
		"Chenipan" : false,
		"Chrysacier" : false,
		"Papilusion" : false,
		"Aspicot" : false,
		"Coconfort" : false,
		"Dardagnan" : false,
		"Roucool" : false,
		"Roucoups" : false,
		"Roucarnage" : false,
		"Rattata" : false,
		"Rattatac" : false
	}
}

func CheckNewPokemonDiscover(NameOfPokemon) :
	for x in Pokedex.PokedexList["AllDiscover"] :
		if x == NameOfPokemon :
			if Pokedex.PokedexList["AllDiscover"][x] :
				return ""
			else :
				Pokedex.PokedexList["AllDiscover"][x] = true
				return "Les données de " + NameOfPokemon + " ont été ajouté au Pokedex !"
		else :
			pass
