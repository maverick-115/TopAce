extends KinematicBody2D
signal throw_item()
var movimiento = 0
var gravedadbase
func _ready():
	gravedadbase = Global_Var.gravity
	$Camera2D/Interfaz/Button.show()



func _physics_process(delta):
	Global_Var.velocity.y += Global_Var.gravity * delta
	var collision = move_and_collide(Global_Var.velocity * delta)
	if collision != null: 
		_on_impact(collision.normal)
	if Global_Var.velocity.y < 1 and Global_Var.velocity.y > -1:
		$SpriteAvion.animation = "Parado"
	elif Global_Var.velocity.y > movimiento:
		Global_Var.Straccion = "bajando"
		Global_Var.subiendo = false
		$SpriteAvion.animation = "Bajando"
		if Global_Var.velocity.y < 10:
			pass
			#Global_Var.velocity.x += Global_Var.velocity.y * 0.05
			Global_Var.gravity = 50
		else:
			pass
			Global_Var.gravity = 50
			#Global_Var.gravity = gravedadbase
	else:
		Global_Var.Straccion = "subiendo"
		Global_Var.subiendo = true
		$SpriteAvion.animation = "Subiendo"
	#Chequear si se detuvo
	if (Global_Var.velocity.x == 0 && Global_Var.velocity.y < 1):
		emit_signal(iniciar_juego)
	

func launch(direction):
	Global_Var.velocity = Global_Var.throw_velocity * Vector2(direction, 1)
	$Camera2D/Interfaz/Button.hide()

func _on_impact(normal : Vector2):#cuando detecta el piso rebota
	Global_Var.velocity = Global_Var.velocity.bounce(normal)
	Global_Var.velocity *= 0.5


func _on_Button_pressed():
	 launch(1)
	

func _on_Button2_pressed():
	#pass
	if Global_Var.velocity.y > 0:
		Global_Var.velocity.x =  (Global_Var.velocity.y * 1.8)
		Global_Var.velocity.y *=  -0.8
		
		#Global_Var.velocity.x *=  1.5




func _on_TouchScreenButton_pressed():
		#pass
	if Global_Var.velocity.y > 0:
		Global_Var.velocity.x =  (Global_Var.velocity.y * 1.8)
		Global_Var.velocity.y *=  -0.8
