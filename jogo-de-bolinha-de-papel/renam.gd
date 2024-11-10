extends Node2D

@onready var raycast = $RayCast2D  # Adiciona um RayCast2D na cena

var vel = 100

@onready var anim = $AnimatedSprite2D

func _ready():
	raycast.enabled = false  # Desabilita o RayCast inicialmente

func _process(delta: float) -> void:
	var dirtX = 0
	var velocity = Input.get_vector("move_direita", "move_esquerda", "ui_accept", "ui_down")

	# Movimentação do jogador com as teclas
	if velocity.x != 0:
		anim.play("move")
	else:
		anim.play("default")

	if Input.is_action_pressed("move_esquerda"):
		dirtX += -1
	if Input.is_action_pressed("move_direita"):
		dirtX += 1

	# Movimenta o jogador horizontalmente
	translate(Vector2(dirtX, 0) * vel * delta)

	# Restringe a posição do jogador dentro dos limites horizontais
	global_position.x = clamp(global_position.x, 100, 761)

	# Dispara o raio quando a tecla de espaço é pressionada
	if Input.is_action_just_pressed("ui_accept"):
		raycast.enabled = true  # Ativa o RayCast para simular o disparo do laser

	# Atualiza o RayCast
	if raycast.enabled:
		raycast.cast_to = Vector2(500, 0)  # Define a direção do disparo (aqui, para a direita)
