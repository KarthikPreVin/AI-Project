extends Node

const UTILITY_NAME = "ALGORITHMS"

static func check_valid(pos_x,pos_y,MOVES,tile: String):
	# check is MOVES[pos_y][pos_x] can be placed with tile
	if MOVES[pos_y][pos_x]!="":
		return false
	var packed = tile.split("_", false, 1)
	var color = packed[0]
	var shape = packed[1]
	var neighbour
	if pos_x!=0:
		neighbour = MOVES[pos_y][pos_x-1]
		if neighbour!="":
			neighbour = neighbour.split("_", false, 1)
			if neighbour[0]!=color and neighbour[1]!=shape:
				return false
	if pos_x!=49:
		neighbour = MOVES[pos_y][pos_x+1]
		if neighbour!="":
			neighbour = neighbour.split("_", false, 1)
			if neighbour[0]!=color and neighbour[1]!=shape:
				return false
	if pos_y!=0:
		neighbour = MOVES[pos_y-1][pos_x]
		if neighbour!="":
			neighbour = neighbour.split("_", false, 1)
			if neighbour[0]!=color and neighbour[1]!=shape:
				return false
	if pos_y!=49:
		neighbour = MOVES[pos_y+1][pos_x]
		if neighbour!="":
			neighbour = neighbour.split("_", false, 1)
			if neighbour[0]!=color and neighbour[1]!=shape:
				return false
	return true
		
	
static func calc_score(BOARD,pos_x,pos_y,tile):
	var tile_split = tile.split("-",false,1)
	
	var cell = BOARD[pos_y][pos_x]
	
	
static func AI_move_search(MOVES,BOARD,tiles_in_hand):
	pass
