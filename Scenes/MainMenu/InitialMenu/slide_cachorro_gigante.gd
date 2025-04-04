extends SplashScreenSlide


# Called when the node enters the scene tree for the first time.
func _ready():
	var datetimeDict : Dictionary = Time.get_datetime_dict_from_system()
	var hour = datetimeDict.get("hour")
	print(hour)
	if ((hour >= 19 and hour <= 23) or (hour >= 0 and hour <= 6)):
		$DayTime.visible = false
		$NightTime.visible = true
	else:
		$DayTime.visible = true
		$NightTime.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
