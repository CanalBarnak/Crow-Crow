extends Node

#Calendar global
var calendar:Dictionary = Time.get_date_dict_from_system()
var unix_time:float = Time.get_unix_time_from_system()
var datetime_dict:Dictionary = Time.get_datetime_dict_from_unix_time(int(unix_time))

var year:int = datetime_dict["year"]
var month:int = datetime_dict["month"]
var day:int = datetime_dict["day"]
var hour:float  = datetime_dict["hour"]
var minute:float = datetime_dict["minute"]
var second:float = datetime_dict["second"]

var day_percent_return:float 
var offset_time:int

var capture_mouse:bool = true
var timer : int = 0
var score: int = 0
var high_score :int =0 
var score_power:int = 1
var energie:int = 600
#pour le rpg system, ajouter un peu de danger level quand le joueur bouge et quand le danger level atteint 100%, trigger battle
var danger_level:int=0
#disable encounter
var toggle_encounter:bool=false
var match_three_count:int =0
#original spawn point , buggé, dans le fond, ça break nul si je met vide.
#var saved_location:Vector3 = Vector3(-89,-4.94,73.0)


var send_ui:bool
var send_text:String
#var location:String
#pour les dialogues
var send_speech:bool
var speech_content:String

var location_scene: String = "in_world_first_spawn"

var beam_on:bool = true
func _ready()->void:
	print("Encounter: ",toggle_encounter)
	
	
func _process(_delta: float) -> void:
	if Input.is_action_pressed("quit"):
		if Global.score >= Global.high_score:
			Global.high_score = Global.score
		SaveLoad.save()
		get_tree().quit()
		
