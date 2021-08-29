extends Node

#ALL POKEMON PC DICTIONNARY
var Pokemon1 = null
var Pokemon2 = null
var Pokemon3 = null
var Pokemon4 = null
var Pokemon5 = null
var Pokemon6 = null
var Pokemon7 = null
var Pokemon8 = null
var Pokemon9 = null
var Pokemon10 = null
var Pokemon11 = null
var Pokemon12 = null
var Pokemon13 = null
var Pokemon14 = null
var Pokemon15 = null
var Pokemon16 = null
var Pokemon17 = null
var Pokemon18 = null
var Pokemon19 = null
var Pokemon20 = null
var Pokemon21 = null
var Pokemon22 = null
var Pokemon23 = null
var Pokemon24 = null
var Pokemon25 = null
var Pokemon26 = null
var Pokemon27 = null
var Pokemon28 = null
var Pokemon29 = null
var Pokemon30 = null
var Pokemon31 = null
var Pokemon32 = null
var Pokemon33 = null
var Pokemon34 = null
var Pokemon35 = null
var Pokemon36 = null
var Pokemon37 = null
var Pokemon38 = null
var Pokemon39 = null
var Pokemon40 = null
var Pokemon41 = null
var Pokemon42 = null
var Pokemon43 = null
var Pokemon44 = null
var Pokemon45 = null
var Pokemon46 = null
var Pokemon47 = null
var Pokemon48 = null
var Pokemon49 = null
var Pokemon50 = null
var Pokemon51 = null
var Pokemon52 = null
var Pokemon53 = null
var Pokemon54 = null
var Pokemon55 = null
var Pokemon56 = null
var Pokemon57 = null
var Pokemon58 = null
var Pokemon59 = null
var Pokemon60 = null

var PSSList = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6,Pokemon7,Pokemon8,Pokemon9,Pokemon10,Pokemon11,Pokemon12,Pokemon13,Pokemon14,Pokemon15,Pokemon16,Pokemon17,Pokemon18,Pokemon19,Pokemon20,Pokemon21,Pokemon22,Pokemon23,Pokemon24,Pokemon25,Pokemon26,Pokemon27,Pokemon28,Pokemon29,Pokemon30,Pokemon31,Pokemon32,Pokemon33,Pokemon34,Pokemon35,Pokemon36,Pokemon37,Pokemon38,Pokemon39,Pokemon40,Pokemon41,Pokemon42,Pokemon43,Pokemon44,Pokemon45,Pokemon46,Pokemon47,Pokemon48,Pokemon49,Pokemon50,Pokemon51,Pokemon52,Pokemon53,Pokemon54,Pokemon55,Pokemon56,Pokemon57,Pokemon58,Pokemon59,Pokemon60]

func PssList() : 
	PSSList = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6,Pokemon7,Pokemon8,Pokemon9,Pokemon10,Pokemon11,Pokemon12,Pokemon13,Pokemon14,Pokemon15,Pokemon16,Pokemon17,Pokemon18,Pokemon19,Pokemon20,Pokemon21,Pokemon22,Pokemon23,Pokemon24,Pokemon25,Pokemon26,Pokemon27,Pokemon28,Pokemon29,Pokemon30,Pokemon31,Pokemon32,Pokemon33,Pokemon34,Pokemon35,Pokemon36,Pokemon37,Pokemon38,Pokemon39,Pokemon40,Pokemon41,Pokemon42,Pokemon43,Pokemon44,Pokemon45,Pokemon46,Pokemon47,Pokemon48,Pokemon49,Pokemon50,Pokemon51,Pokemon52,Pokemon53,Pokemon54,Pokemon55,Pokemon56,Pokemon57,Pokemon58,Pokemon59,Pokemon60]
	return PSSList

func CheckFreeDico() :
	var c = 0
	PG.UnUsed = PssList()
	for x in PSSList :
		c = c + 1
		if x == null :
			return c
