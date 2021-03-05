extends CanvasLayer

var coins = 0

var score = 0

func _on_coin_collected():
	coins += 1
	_ready()


func _on_Enemy_A_enemy_A_died():
	PlayerInfo.score += 75
	_ready()

func _on_Enemyy_enemy_died() -> void:
	PlayerInfo.score += 50
	_ready()

func _ready():
	$Coins.text = String(coins)
	PlayerInfo.score = score
	$ScoreBoard/Score.text = String(PlayerInfo.score)
	

func _on_Enemy_witch_died():
	PlayerInfo.score += 150
	_ready()

func _on_lvl2_enemy_1_armored_died():
	PlayerInfo.score += 100
	_ready()

func _on_Enemyy_skeleton_died():
	PlayerInfo.score += 50
	_ready()

func _on_lvl2_enemy_armored_died():
	PlayerInfo.score += 100
	_ready()

func _on_Wave_score() -> void:
	PlayerInfo.score += 1000
	_ready()
