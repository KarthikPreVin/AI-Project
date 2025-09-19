extends Node2D

@onready var cells: Node2D = $Cells
@onready var tiles: Node2D = $Tiles

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
	"T_BLUE_SQUARE": 0,
	"T_BLUE_DIAMOND": 1,
	"T_BLUE_4_STAR": 2,
	"T_BLUE_CIRCLE": 3,
	"T_BLUE_8_STAR": 4,
	"T_BLUE_CLOVER": 5,
	"T_RED_SQUARE": 6,
	"T_RED_DIAMOND": 7,
	"T_RED_4_STAR": 8,
	"T_RED_CIRCLE": 9,
	"T_RED_8_STAR": 10,
	"T_RED_CLOVER": 11,
	"T_GREEN_SQUARE": 12,
	"T_GREEN_DIAMOND": 13,
	"T_GREEN_4_STAR": 14,
	"T_GREEN_CIRCLE": 15,
	"T_GREEN_8_STAR": 16,
	"T_GREEN_CLOVER": 17,
	"T_YELLOW_SQUARE": 18,
	"T_YELLOW_DIAMOND": 19,
	"T_YELLOW_4_STAR": 20,
	"T_YELLOW_CIRCLE": 21,
	"T_YELLOW_8_STAR": 22,
	"T_YELLOW_CLOVER": 23,
	"T_VIOLET_SQUARE": 24,
	"T_VIOLET_DIAMOND": 25,
	"T_VIOLET_4_STAR": 26,
	"T_VIOLET_CIRCLE": 27,
	"T_VIOLET_8_STAR": 28,
	"T_VIOLET_CLOVER": 29,
	"T_ORANGE_SQUARE": 30,
	"T_ORANGE_DIAMOND": 31,
	"T_ORANGE_4_STAR": 32,
	"T_ORANGE_CIRCLE": 33,
	"T_ORANGE_8_STAR": 34,
	"T_ORANGE_CLOVER": 35,
}

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
	var tile_str = tile_dict.find_key(rand_val)
	MOVES[25][25]=tile_str
	
	var tile = Sprite2D.new()
	tile.texture = tile_map
	tile.hframes = COLUMNS_TILES
	tile.vframes = ROWS_TILES
	tile.frame = rand_val
	tiles.add_child(tile)
	tile.position = Vector2(1250,1250)


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
