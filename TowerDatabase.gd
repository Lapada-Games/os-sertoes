extends Node

var tower_data := {
	"Aldea": {
		"price": 25,
		"price_growth": 1.1
	},
	"Cangaceiro": {
		"price": 60,
		"price_growth": 1.15
	},
	"Firecamp": {
		"price": 80,
		"price_growth": 1.1
	},
	"Father": {
		"price": 120,
		"price_growth": 1.15
	}
}

func get_tower_info(tower_name: String):
	return tower_data[tower_name]

func get_price(tower_name: String) -> int:
	return tower_data[tower_name]["price"]

func increase_all_prices():
	for tower in tower_data:
		var t = tower_data[tower]
		t["price"] = int(t["price"] * t["price_growth"])

func increase_price(tower_name: String):
	var t = tower_data[tower_name]
	t["price"] = int(t["price"] * t["price_growth"])
