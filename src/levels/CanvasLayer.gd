extends CanvasLayer

var coins = 0

#function for collecting the coins
func _on_coin_collected():
	coins += 1
	_ready()

#function for updaing score when eneny_A is killed.
func _on_Enemy_A_enemy_A_died():
	PlayerInfo.score += 75
	_ready()


#function for updating score when Enemyy is killed.
func _on_Enemyy_enemy_died() -> void:
	PlayerInfo.score += 50
	_ready()

func _ready():
	$Coins.text = String(coins # writing the no.of coins collected in Coins node.
	$ScoreBoard/Score.text = String(PlayerInfo.score) # Writting the score in Score node.
	
	
 
#function for updating score when witch is killed.
func _on_Enemy_witch_died():
	PlayerInfo.score += 150
	_ready()



#function for updating score when lvl2 enemy_1 is killed.
func _on_lvl2_enemy_1_enemy_1_died() -> void:
	PlayerInfo.score += 100
	_ready()



