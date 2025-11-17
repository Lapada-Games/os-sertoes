extends Node

var level = 1
var HP = 3 # TODO: make this variable local to levelmanager
# There will be multiple waves per level
# Depending on the global level variable, the waves will be different each time
var waves = [
	[10, 20, 30],
	[3, 5, 10],
	[2, 3, 4]
]
var cash = [150, 500, 1000]


func next_level():
	self.level += 1

func get_cash():
	return self.cash[self.level - 1]

func subtract_cash(amount: int):
	self.cash[self.level - 1] -= amount

func add_cash(amount: int):
	self.cash[self.level - 1] += amount
