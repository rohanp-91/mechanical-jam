extends Node

# Game 
const LEVEL_NAME = "Level"
const LEVEL_PATH = "res://scenes/levels/Level_%d.tscn"

# Player 
const PLAYER_NODE_PATH = "Level/Player"

# Enemy
const ENEMY_NODE_PATH = "Level/Enemies/%s"
enum EnemyFacing { LEFT = -1, RIGHT = 1}

# Interactable 
const PORTAL_PATH_PREFIX = "Level/Portals/Portal_%d"
