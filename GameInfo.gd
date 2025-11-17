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

var cashInfo = [150, 500, 1000]

var cash = cashInfo[level - 1]


func next_level():
	self.level += 1

func get_cash():
	return self.cash

func set_cash(value: int):
	self.cash = value

func reset_cash():
	self.cash = self.cashInfo[self.level - 1]

func subtract_cash(amount: int):
	self.cash -= amount

func add_cash(amount: int):
	self.cash += amount
