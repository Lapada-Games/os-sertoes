extends Node

var tower_data := {
	"Cachorro": {
		"price": 20,
		"base_price": 20,
		"price_growth": 5
	},
	"Aldeã": {
		"price": 25,
		"base_price": 25,
		"price_growth": 10
	},
	"Cangaceiro": {
		"price": 60,
		"base_price": 60,
		"price_growth": 20
	},
	"Fogueira": {
		"price": 90,
		"base_price": 90,
		"price_growth": 15
	},
	"Padre": {
		"price": 120,
		"base_price": 120,
		"price_growth": 5
	},
	"Cangaceiro Sniper": {
		"price": 130,
		"base_price": 130,
		"price_growth": 5
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

func reset_all_prices():
	for tower in tower_data:
		var t = tower_data[tower]
		t["price"] = t["base_price"]

func increase_price(tower_name: String):
	var t = tower_data[tower_name]
	t["price"] = int(t["price"] * t["price_growth"])

func set_price(tower_name: String, new_price: int):
	var t = tower_data[tower_name]
	t["price"] = new_price
