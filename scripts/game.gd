extends Node2D

@onready var cells: Node2D = $Cells
@onready var tiles: Node2D = $Tiles

var PATH_CELLS = "res://assets/cells.png"
var COLUMNS_CELLS = 7
var ROWS_CELLS = 6

var PATH_TILES = "res://assets/tiles.png"
var COLUMNS_TILES = 6
var ROWS_TILES = 6

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
	"BLUE_SQUARE": 0,
	"BLUE_DIAMOND": 1,
	"BLUE_4_STAR": 2,
	"BLUE_CIRCLE": 3,
	"BLUE_8_STAR": 4,
	"BLUE_CLOVER": 5,
	"RED_SQUARE": 6,
	"RED_DIAMOND": 7,
	"RED_4_STAR": 8,
	"RED_CIRCLE": 9,
	"RED_8_STAR": 10,
	"RED_CLOVER": 11,
	"GREEN_SQUARE": 12,
	"GREEN_DIAMOND": 13,
	"GREEN_4_STAR": 14,
	"GREEN_CIRCLE": 15,
	"GREEN_8_STAR": 16,
	"GREEN_CLOVER": 17,
	"YELLOW_SQUARE": 18,
	"YELLOW_DIAMOND": 19,
	"YELLOW_4_STAR": 20,
	"YELLOW_CIRCLE": 21,
	"YELLOW_8_STAR": 22,
	"YELLOW_CLOVER": 23,
	"VIOLET_SQUARE": 24,
	"VIOLET_DIAMOND": 25,
	"VIOLET_4_STAR": 26,
	"VIOLET_CIRCLE": 27,
	"VIOLET_8_STAR": 28,
	"VIOLET_CLOVER": 29,
	"ORANGE_SQUARE": 30,
	"ORANGE_DIAMOND": 31,
	"ORANGE_4_STAR": 32,
	"ORANGE_CIRCLE": 33,
	"ORANGE_8_STAR": 34,
	"ORANGE_CLOVER": 35,
}

func _ready():
	load_cells()
	load_tiles()
	print(cells.get_children())
	print(tiles.get_children())
	

func load_cells():
	var cell_map = load(PATH_CELLS)
	var total_cells = 42
	for i in range(total_cells):
		var cell = Sprite2D.new()
		cell.texture = cell_map
		cell.hframes = COLUMNS_CELLS
		cell.vframes = ROWS_CELLS
		cell.frame = i
		cells.add_child(cell)
		
func load_tiles():
	var tile_map = load(PATH_TILES)
	var total_tiles = 36
	for i in range(total_tiles):
		var tile = Sprite2D.new()
		tile.texture = tile_map
		tile.hframes = COLUMNS_TILES
		tile.vframes = ROWS_TILES
		tile.frame = i
		tiles.add_child(tile)
