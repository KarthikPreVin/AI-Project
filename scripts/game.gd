extends Node2D

@onready var cells: Node2D = $Cells
@onready var tiles: Node2D = $Tiles

const Utils = preload("res://scripts/algorithms.gd")

var SPRITE_SIZE = 50

var PATH_CELLS = "res://assets/cells.png"
var COLUMNS_CELLS = 7
var ROWS_CELLS = 6
var cell_map = load(PATH_CELLS)

var PATH_TILES = "res://assets/tiles.png"
var COLUMNS_TILES = 6
var ROWS_TILES = 6
var tile_map = load(PATH_TILES)


var shapes = [
	"RED_SQUARE","BLUE_SQUARE","GREEN_SQUARE","YELLOW_SQUARE","VIOLET_SQUARE","ORANGE_SQUARE",
	"RED_CIRCLE","BLUE_CIRCLE","GREEN_CIRCLE","YELLOW_CIRCLE","VIOLET_CIRCLE","ORANGE_CIRCLE",
	"RED_DIAMOND","BLUE_DIAMOND","GREEN_DIAMOND","YELLOW_DIAMOND","VIOLET_DIAMOND","ORANGE_DIAMOND",
	"RED_CLOVER","BLUE_CLOVER","GREEN_CLOVER","YELLOW_CLOVER","VIOLET_CLOVER","ORANGE_CLOVER",
	"RED_4_STAR","BLUE_4_STAR","GREEN_4_STAR","YELLOW_4_STAR","VIOLET_4_STAR","ORANGE_4_STAR",
	"RED_8_STAR","BLUE_8_STAR","GREEN_8_STAR","YELLOW_8_STAR","VIOLET_8_STAR","ORANGE_8_STAR"
	]

var BOARD = []
var MOVES = []

var cell_dict = {
	"YELLOW_DIAMOND": 0,
	"RED_DIAMOND": 1,
	"BLUE_DIAMOND": 2,
	"VIOLET_DIAMOND": 3,
	"GREEN_DIAMOND": 4,
	"ORANGE_DIAMOND": 5,
	"BLANK": 6,
	"YELLOW_4_STAR": 7,
	"RED_4_STAR": 8,
	"BLUE_4_STAR": 9,
	"VIOLET_4_STAR": 10,
	"GREEN_4_STAR": 11,
	"ORANGE_4_STAR": 12,
	"MULTIPLIER_2X":13,
	"YELLOW_8_STAR": 14,
	"RED_8_STAR": 15,
	"BLUE_8_STAR": 16,
	"VIOLET_8_STAR": 17,
	"GREEN_8_STAR": 18,
	"ORANGE_8_STAR": 19,
	"MULTIPLIER_3X": 20,
	"YELLOW_SQUARE": 21,
	"RED_SQUARE": 22,
	"BLUE_SQUARE": 23,
	"VIOLET_SQUARE": 24,
	"GREEN_SQUARE": 25,
	"ORANGE_SQUARE": 26,
	"MULTIPLIER_4X": 27,
	"YELLOW_CLOVER": 28,
	"RED_CLOVER": 29,
	"BLUE_CLOVER": 30,
	"VIOLET_CLOVER": 31,
	"GREEN_CLOVER": 32,
	"ORANGE_CLOVER": 33,
	"ANY": 34,
	"YELLOW_CIRCLE": 35,
	"RED_CIRCLE": 36,
	"BLUE_CIRCLE": 37,
	"VIOLET_CIRCLE": 38,
	"GREEN_CIRCLE": 39,
	"ORANGE_CIRCLE": 40,
	"WALL": 41
}

var tile_dict = {
	"TBLUE_SQUARE": 0,
	"TBLUE_DIAMOND": 1,
	"TBLUE_4_STAR": 2,
	"TBLUE_CIRCLE": 3,
	"TBLUE_8_STAR": 4,
	"TBLUE_CLOVER": 5,
	"TRED_SQUARE": 6,
	"TRED_DIAMOND": 7,
	"TRED_4_STAR": 8,
	"TRED_CIRCLE": 9,
	"TRED_8_STAR": 10,
	"TRED_CLOVER": 11,
	"TGREEN_SQUARE": 12,
	"TGREEN_DIAMOND": 13,
	"TGREEN_4_STAR": 14,
	"TGREEN_CIRCLE": 15,
	"TGREEN_8_STAR": 16,
	"TGREEN_CLOVER": 17,
	"TYELLOW_SQUARE": 18,
	"TYELLOW_DIAMOND": 19,
	"TYELLOW_4_STAR": 20,
	"TYELLOW_CIRCLE": 21,
	"TYELLOW_8_STAR": 22,
	"TYELLOW_CLOVER": 23,
	"TVIOLET_SQUARE": 24,
	"TVIOLET_DIAMOND": 25,
	"TVIOLET_4_STAR": 26,
	"TVIOLET_CIRCLE": 27,
	"TVIOLET_8_STAR": 28,
	"TVIOLET_CLOVER": 29,
	"TORANGE_SQUARE": 30,
	"TORANGE_DIAMOND": 31,
	"TORANGE_4_STAR": 32,
	"TORANGE_CIRCLE": 33,
	"TORANGE_8_STAR": 34,
	"TORANGE_CLOVER": 35,
}

var player_tiles = []
var player_tiles_nodes = []
@onready var player_tiles_box = $Camera2D/UI/PlayerTiles
var ai_tiles = []
var ai_tiles_nodes = []
@onready var ai_tiles_box = $Camera2D/UI/AITiles
var ai_toggle = false
var player_toggle = false

func _ready():
	randomize()
	#load_cells()
	#load_tiles()
	generate_board()
	display_board()
	start_game()

func generate_board():
	for i in range(50):
		var new_row = []
		var another_row = []
		for j in range(50):
			another_row.append("")
			if i==25 and j==25:
				new_row.append("BLANK")
			var rand_val = randf()
			if (rand_val<0.5):
				new_row.append("BLANK")
			elif (rand_val<0.7):
				rand_val = randi_range(0,35)
				new_row.append(shapes[rand_val])			
			elif (rand_val<0.8):
				rand_val = randf()
				if (rand_val<0.5):
					new_row.append("MULTIPLIER_2X")
				elif (rand_val<0.5):
					new_row.append("MULTIPLIER_3X")
				else:
					new_row.append("MULTIPLIER_4X")
			elif (rand_val<0.9):
				new_row.append("ANY")
			else:
				new_row.append("WALL")
		BOARD.append(new_row)
		MOVES.append(another_row)
		
func display_board():
	for i in range(50):
		for j in range(50):
			var x_coord = j*50
			var y_coord = i*50
			var cell = Sprite2D.new()
			cell.texture = cell_map
			cell.hframes = COLUMNS_CELLS
			cell.vframes = ROWS_CELLS
			cell.frame = cell_dict[BOARD[i][j]]
			cells.add_child(cell)
			cell.position = Vector2(x_coord,y_coord)
			
func start_game():
	var rand_val = randi_range(0,35)
	place_tile(rand_val,25,25)
	var temp
	
	var loc = [Vector2(25+5,25+34),Vector2(25+63,25+34),Vector2(25+121,25+34),Vector2(25+5,25+93),Vector2(25+63,25+93),Vector2(25+121,25+93)]
	for i in range(6):
		rand_val = randi_range(0,35)
		player_tiles.append(rand_val)
		temp = Sprite2D.new()
		temp.texture = tile_map
		temp.hframes = COLUMNS_TILES
		temp.vframes = ROWS_TILES
		temp.frame = rand_val
		player_tiles_nodes.append(temp)
		player_tiles_box.add_child(temp)
		temp.position=loc[i]
		
		rand_val = randi_range(0,35)
		ai_tiles.append(rand_val)
		temp = Sprite2D.new()
		temp.texture = tile_map
		temp.hframes = COLUMNS_TILES
		temp.vframes = ROWS_TILES
		temp.frame = rand_val
		ai_tiles_nodes.append(temp)
		ai_tiles_box.add_child(temp)
		temp.position=loc[i]

func place_tile(tile_index,pos_x,pos_y):
	var tile_str = tile_dict.find_key(tile_index)
	MOVES[pos_y][pos_x]=tile_str
	var tile = Sprite2D.new()
	tile.texture = tile_map
	tile.hframes = COLUMNS_TILES
	tile.vframes = ROWS_TILES
	tile.frame = tile_index
	tiles.add_child(tile)
	tile.position = Vector2(50*pos_x,50*pos_y)

#tests
func test_board_create():
	var c1=0
	var c2=0
	var c3=0
	var c4=0
	var c5=0
	print(len(BOARD))
	for i in BOARD:
		for j in i:
			if j=="BLANK":
				c1+=1
			elif j=="WALL":
				c2+=1
			elif j=="ANY":
				c3+=1
			elif j.begins_with("MULTIPLIER"):
				c4+=1
			else:
				c5+=1
	if (c1+c2+c3+c4+c5!=2500):
		print("ERROR 1")
	elif (len(BOARD)!=50):
		print("ERROR 2")


func _on_view_ai_button_pressed() -> void:
	if player_toggle:
		player_toggle = not player_toggle
		player_tiles_box.position = Vector2(400,-100)
	ai_toggle = not ai_toggle
	if ai_toggle:
		ai_tiles_box.position = Vector2(-274,-82)
	else:
		ai_tiles_box.position = Vector2(400,-100)

func _on_place_tiles_button_pressed() -> void:
	if ai_toggle:
		ai_toggle = not ai_toggle
		ai_tiles_box.position = Vector2(400,-100)
	player_toggle = not player_toggle
	if player_toggle:
		player_tiles_box.position = Vector2(-274,-82)
	else:
		player_tiles_box.position = Vector2(400,-100)
