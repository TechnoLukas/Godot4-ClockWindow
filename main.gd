extends Window

var mousepos 
var mouseposold
var dragging=false

var acidcolors = [Color("ffff01"), Color("ffb401"), Color("ee0000"), Color("da0074"), Color("5f009c")] 
var weekdays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]

@onready var panel_bg = $panel_bg
@onready var panel_ov = $panel_ov

@onready var label_hm = $time_hm
@onready var label_s = $time_s
@onready var label_wd = $time_wd
@onready var label_d = $time_d
 
@onready var panellist = [panel_bg,panel_ov]
@onready var labellist = [label_hm,label_s,label_wd,label_d]

# Called when the node enters the scene tree for the first time.
func _ready():
	color_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mousepos=get_mouse_position()
	if dragging:
		position=Vector2(position)+mousepos-mouseposold
	
	var time = Time.get_datetime_dict_from_system()
	var time2 = Time.get_datetime_string_from_system(false,true)
	print(time2)
	label_hm.text=str("%s:%s" % [time2.split(" ")[1].split(":")[0], time2.split(" ")[1].split(":")[1]])
	label_s.text=str("%s" % [time2.split(" ")[1].split(":")[2]])
	label_wd.text=str("%s" % [weekdays[time.weekday]])
	label_d.text=str("%s" % [time.day])
	#print(time.week)

func _on_window_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index()==MOUSE_BUTTON_LEFT:
			mouseposold=mousepos
			dragging=!dragging
			
func color_ui():
	var uic = acidcolors.pick_random()
	var bgc = acidcolors.pick_random()
	while bgc==uic:
		uic = acidcolors.pick_random()
		bgc = acidcolors.pick_random()
		
	
	for l in labellist:
		l.set("theme_override_colors/font_color", uic)
	

	
	
	var stbx = panel_bg.get_theme_stylebox("StyleBoxFlat").duplicate()
	stbx.draw_center=true
	stbx.bg_color=bgc
	stbx.border_color=uic
	stbx.border_width_bottom = 3
	stbx.border_width_left = 3
	stbx.border_width_right = 3
	stbx.border_width_top = 3
	panel_bg.add_theme_stylebox_override("panel",stbx)
	
	var stbx2 = panel_ov.get_theme_stylebox("StyleBoxFlat").duplicate()
	stbx2.draw_center=true
	stbx2.bg_color=bgc
	stbx2.border_color=uic
	stbx2.border_width_bottom = 3
	stbx2.border_width_left = 3
	stbx2.border_width_right = 3
	stbx2.border_width_top = 3
	stbx2.set_corner_radius_all(20)
	panel_ov.add_theme_stylebox_override("panel",stbx2)
	
	
	
	
	



	


func _on_button_pressed():
	color_ui()
