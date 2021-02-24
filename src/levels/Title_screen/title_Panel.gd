extends Panel

var coins = 100

func _ready():
	$Coinscollected.text = String(coins)


func _on_Coin_panel_collected():
	coins += 1
	_ready()
