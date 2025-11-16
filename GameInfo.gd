extends Node

var level = 1
var HP = 20
# There will be multiple waves per level
# Depending on the global level variable, the waves will be different each time
var waves = [
	[5, 10, 20],
	[3, 5, 10],
	[2, 3, 4]
]
var cash = [100, 500, 1000]
