class_name BallDispenser
extends Node2D

# the limit is 16
const MAX_BALLS = 4

@export var spawn_points: Array[Marker2D]
@export var ball_scene: PackedScene
@export var ball_pit: Area2D

var free_layers := 0b1111_1111_1111_1111
var colors := [Color.RED, Color.GREEN, Color.BLUE, Color.TAN, Color.CYAN, Color.MAGENTA, Color.GOLD]

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	assert(!spawn_points.is_empty(), "should have at least one spawn point")
	assert(ball_scene, "should have a ball scene")
	assert(ball_pit, "should have a ball pit")

	test_get_free_layer()
	test_set_bit()

	ball_pit.body_entered.connect(ball_fell)
	spawn_timer.timeout.connect(spawn_ball)
	spawn_timer.start()
	spawn_ball()

func ball_fell(ball: Node2D) -> void:
	if not ball.is_in_group(&"ball"):
		return

	var layer := get_ball_collision_layer(ball)
	free_layers = set_bit(free_layers, layer - 1, true)
	ball.queue_free()

func spawn_ball() -> void:
	var layer := get_free_layer(free_layers)

	if layer == -1:
		return

	var point: Marker2D = spawn_points.pick_random()
	var ball: Ball = ball_scene.instantiate()

	ball.position = point.position
	ball.set_collision_layer_value(layer + 8, true)
	free_layers = set_bit(free_layers, layer - 1, false)
	add_child(ball)
	ball.set_color(colors.pick_random())

func get_free_layer(layers: int) -> int:
	var layer: int = 0
	var is_free: int = 0

	for i in range(MAX_BALLS):
		layer = i
		is_free = layers & 1 == 1
		if is_free:
			break
		layers >>= 1

	return layer + 1 if is_free else -1

func get_ball_collision_layer(ball: CollisionObject2D) -> int:
	for i in range(9, 17):
		if ball.get_collision_layer_value(i):
			return i - 8
	return -1

func set_bit(data: int, pos: int, value: bool) -> int:
	return data | (1 << pos) if value else data & ~(1 << pos)

func test_get_free_layer() -> void:
	Test.are_eq(get_free_layer(0b1111_1111_1111_1111), 1)
	Test.are_eq(get_free_layer(0b1111_1111_1111_1000), 4)
	Test.are_eq(get_free_layer(0b0000_0010_0000_0000), 10)
	Test.are_eq(get_free_layer(0b0000_0000_0000_0000), -1)

func test_set_bit() -> void:
	Test.are_eq(set_bit(0b1111, 2, false), 0b1011)
	Test.are_eq(set_bit(0b1011, 0, false), 0b1010)
	Test.are_eq(set_bit(0b1010, 3, false), 0b0010)
	Test.are_eq(set_bit(0b0010, 1, false), 0b0000)

	Test.are_eq(set_bit(0b0000, 2, true), 0b0100)
	Test.are_eq(set_bit(0b0100, 0, true), 0b0101)
	Test.are_eq(set_bit(0b0101, 3, true), 0b1101)
	Test.are_eq(set_bit(0b1101, 1, true), 0b1111)
