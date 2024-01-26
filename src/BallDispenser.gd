class_name BallDispenser
extends Node2D

@export var spawn_points: Array[Marker2D]
@export var ball_scene: PackedScene

var free_layers := 0b1111_1111_1111_1111
var colors := [Color.RED, Color.GREEN, Color.BLUE, Color.TAN, Color.CYAN, Color.MAGENTA, Color.GOLD]

@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	assert(!spawn_points.is_empty(), "should have at least one spawn point")
	assert(ball_scene, "should have a ball scene")

	test_get_layer()
	test_set_bit()

	spawn_timer.timeout.connect(spawn_ball)
	spawn_timer.start()
	spawn_ball()

func spawn_ball() -> void:
	var layer := get_layer(free_layers)

	if layer == -1:
		return

	var point: Marker2D = spawn_points.pick_random()
	var ball: Ball = ball_scene.instantiate()

	ball.position = point.position
	ball.set_collision_layer_value(layer + 8, true)
	free_layers = set_bit(free_layers, layer - 1, false)
	add_child(ball)
	ball.set_color(colors.pick_random())

func get_layer(layers: int) -> int:
	var layer: int = 0
	var is_free: int = 0

	for i in range(16):
		layer = i
		is_free = layers & 1 == 1
		if is_free:
			break
		layers >>= 1

	return layer + 1 if is_free else -1

func set_bit(data: int, pos: int, value: bool) -> int:
	return data | (1 << pos) if value else data & ~(1 << pos)

func test_get_layer() -> void:
	Test.are_eq(get_layer(0b1111_1111_1111_1111), 1)
	Test.are_eq(get_layer(0b1111_1111_1111_1000), 4)
	Test.are_eq(get_layer(0b0000_0010_0000_0000), 10)
	Test.are_eq(get_layer(0b0000_0000_0000_0000), -1)

func test_set_bit() -> void:
	Test.are_eq(set_bit(0b1111, 2, false), 0b1011)
	Test.are_eq(set_bit(0b1011, 0, false), 0b1010)
	Test.are_eq(set_bit(0b1010, 3, false), 0b0010)
	Test.are_eq(set_bit(0b0010, 1, false), 0b0000)

	Test.are_eq(set_bit(0b0000, 2, true), 0b0100)
	Test.are_eq(set_bit(0b0100, 0, true), 0b0101)
	Test.are_eq(set_bit(0b0101, 3, true), 0b1101)
	Test.are_eq(set_bit(0b1101, 1, true), 0b1111)
