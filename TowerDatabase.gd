extends Node

var tower_data := {
	"Aldea": {
		"base_price": 25,
		"price": 100,
		"price_growth": 2.0
	},
	"Cangaceiro": {
		"base_price": 50,
		"price": 50,
		"price_growth": 2.0
	},
	"Firecamp": {
		"base_price": 80,
		"price": 80,
		"price_growth": 3.0
	}
}

func get_tower_info(tower_name: String):
	return tower_data[tower_name]

func get_price(tower_name: String) -> int:
	return tower_data[tower_name]["price"]

func increase_price(tower_name: String):
	var t = tower_data[tower_name]
	t["price"] = int(t["price"] * t["price_growth"])
