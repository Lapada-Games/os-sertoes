extends Node

var tower_data := {
	"Cachorro": {
		"price": 20,
		"price_growth": 1.3
	},
	"Aldeã": {
		"price": 25,
		"price_growth": 1.3
	},
	"Cangaceiro": {
		"price": 60,
		"price_growth": 1.15
	},
	"Fogueira": {
		"price": 90,
		"price_growth": 1.1
	},
	"Padre": {
		"price": 120,
		"price_growth": 1.05
	},
	"Cangaceiro Sniper": {
		"price": 200,
		"price_growth": 1.01
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

