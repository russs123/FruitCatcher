extends Node

@export var fruit_scene: PackedScene

var fruit_x
var score
var health
var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#hide menus
	$PauseMenu.hide()
	$GameOverMenu.hide()
	#pause the game initially to show the new game menu
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#check for escape button to trigger pause menu
	if Input.is_action_just_pressed("toggle_pause") and game_started:
		pause_game()

func _on_fruit_timer_timeout():
	#create a fruit node and add it as a child
	var fruit = fruit_scene.instantiate()
	fruit.fruit_missed.connect(fruit_missed)
	add_child(fruit)

func fruit_caught():
	#update the score
	score += 1
	$HUD.update_score(score)
	#increase difficulty by reducing the timer for the next fruit to spawn
	$FruitTimer.wait_time -= 0.01

func fruit_missed():
	health -= 10
	$HUD.update_health(health)
	#handle game over
	if health <= 0:
		get_tree().paused = true
		$GameOverMenu.update_final_score(score)
		$GameOverMenu.show()
		#show the mouse again
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func new_game():
	#hide the mouse when a game starts
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#begin the timer to generate fruit
	$FruitTimer.wait_time = 1
	$FruitTimer.start()
	#update game state
	game_started = true
	get_tree().paused = false
	#delete any remaining fruit
	get_tree().call_group("fruits", "queue_free")
	#reset game variables
	score = 0
	health = 100
	$HUD.update_score(score)
	$HUD.update_health(health)
	$GameOverMenu.hide()


func _on_hud_start_game():
	#start new game and begin the fruit timer
	new_game()

func pause_game():
	get_tree().paused = true
	#pause game and show pause menu
	$PauseMenu.show()
	#show the mouse when the game is paused
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume_game():
	get_tree().paused = false
	#unpause game and hide pause menu
	$PauseMenu.hide()
	#hide the mouse when the game resumes
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#####################
#Pause & game over menu functions
#####################

#resume button
func _on_pause_menu_resume():
	resume_game()

#restart button
func _on_game_over_menu_restart():
	new_game()


#exit buttons
func _on_pause_menu_exit():
	get_tree().quit()

func _on_game_over_menu_exit():
	get_tree().quit()
