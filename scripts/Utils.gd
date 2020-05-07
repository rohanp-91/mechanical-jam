extends Node

# Global constants
const STRING_EMPTY = ""

# Game 
const LEVEL_NAME = "Level"
const LEVEL_PATH = "res://scenes/levels/Level_%d.tscn"

# Entity
enum EntityFacing { LEFT = -1, RIGHT = 1}

# Player 
const PLAYER_NODE_PATH = "Level/Player"

# Enemy
const ENEMY_NODE_PATH = "Level/Enemies/%s"

# Attack and damage
enum BoxType { Enemy, Player, Weapon }

# Interactable 
const PORTAL_PATH_PREFIX = "Level/Portals/Portal_%d"
