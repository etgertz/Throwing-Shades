extends Node2D

var innerWidth = 3
var outerWidth = 20
var c1 = Color(.6,.6,.522)
var c2 = Color(.812,.808,.719)
#var thickness = 13

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _draw():
	draw_arch(600,450,0,get_viewport_rect().size/2,outerWidth,c1)
	draw_circle(get_viewport_rect().size/2,300,c1,false,outerWidth)#circle window
	draw_circle(get_viewport_rect().size/2,54.5,c1,false,outerWidth)#center circle
	draw_line(Vector2(get_viewport_rect().size.x/2-300,get_viewport_rect().size.y/2),Vector2(get_viewport_rect().size.x/2-300,get_viewport_rect().size.y/2+600),c1,outerWidth)
	draw_line(Vector2(get_viewport_rect().size.x/2+300,get_viewport_rect().size.y/2),Vector2(get_viewport_rect().size.x/2+300,get_viewport_rect().size.y/2+600),c1,outerWidth)
	
	for i in range(Global.values):
		draw_spire(i*TAU/Global.values,c1,outerWidth) #i*TAU/Global.values
	
	draw_arch(600,450,0,get_viewport_rect().size/2,innerWidth,c2)
	#draw_arch(150,118,0,Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2-180),innerWidth,c2)
	#draw_circle(Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2-230),54.5,c2,false,innerWidth)
	draw_circle(get_viewport_rect().size/2,54.5,c2,false,innerWidth)
	draw_circle(get_viewport_rect().size/2,300,c2,false,innerWidth)
	draw_line(Vector2(get_viewport_rect().size.x/2-300,get_viewport_rect().size.y/2),Vector2(get_viewport_rect().size.x/2-300,get_viewport_rect().size.y/2+600),c2,innerWidth)
	draw_line(Vector2(get_viewport_rect().size.x/2+300,get_viewport_rect().size.y/2),Vector2(get_viewport_rect().size.x/2+300,get_viewport_rect().size.y/2+600),c2,innerWidth)
	for i in range(Global.values):
		draw_spire(i*TAU/Global.values,c2,innerWidth)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func draw_arch(W: float, H: float, rot: float, center: Vector2, thickness: float, color: Color):
	var half_w = W * 0.5
	var c = (half_w * half_w - H * H) / W
	var radius = abs(c - half_w)

	# Rotate base endpoints and peak
	var B_r = Vector2(half_w, 0).rotated(rot) + center
	var B_l = Vector2(-half_w, 0).rotated(rot) + center
	var P   = Vector2(0, -H).rotated(rot) + center

	# Circle centers
	var C_r = Vector2(c, 0).rotated(rot) + center
	var C_l = Vector2(-c, 0).rotated(rot) + center

	# Compute angles from circle centers to points, 0 → 2π
	var angle_r_start = fposmod(atan2(P.y - C_r.y, P.x - C_r.x) + PI*2, PI*2)
	var angle_r_end   = fposmod(atan2(B_r.y - C_r.y, B_r.x - C_r.x) + PI*2, PI*2)
	
	if(rot<PI || rot>=3*PI/2):
		angle_r_start = atan2(P.y - C_r.y, P.x - C_r.x)
		angle_r_end   = atan2(B_r.y - C_r.y, B_r.x - C_r.x)
	
	var angle_l_start = fposmod(atan2(P.y - C_l.y, P.x - C_l.x) + PI*2, PI*2)
	var angle_l_end   = fposmod(atan2(B_l.y - C_l.y, B_l.x - C_l.x) + PI*2, PI*2)
	
	if(rot>PI/2 && rot<PI):
		angle_l_start = atan2(P.y - C_l.y, P.x - C_l.x)
		angle_l_end   = atan2(B_l.y - C_l.y, B_l.x - C_l.x)
	
	# Draw arcs
	draw_arc(C_r, radius, angle_r_start-thickness/2/radius/(W/H), angle_r_end, 64, color, thickness, false)
	draw_arc(C_l, radius, angle_l_start+thickness/2/radius/(W/H), angle_l_end, 64, color, thickness, false)


func draw_spire(angle: float, color: Color, w: float):
	var dist = 180
	var center = get_viewport_rect().size/2
	var p1 = Vector2(cos(angle-PI/2), sin(angle-PI/2))
	draw_arch(150,118,angle,center+p1*180,w,color)
	draw_circle(center+p1*230,54.5,color,false,w)
	draw_spire_defined(center,angle,54.5,30,180,150,color,w)


func draw_spire_defined(
	center: Vector2,
	angle: float,
	r1: float,
	w1: float,
	r2: float,
	w2: float,
	color: Color,
	line_width: float
):
	angle-=PI/2
	
	# ---- STEP 1: inner circle arc points ----
	var half_a1 = (w1 / r1) * 0.5
	
	var A1 = center + Vector2.RIGHT.rotated(angle - half_a1) * r1
	var A2 = center + Vector2.RIGHT.rotated(angle + half_a1) * r1
	
	# ---- STEP 2: outer circle arc points ----
	var half_a2 = (w2 / r2) * 0.5
	
	var B1 = center + Vector2.RIGHT.rotated(angle - half_a2) * r2
	var B2 = center + Vector2.RIGHT.rotated(angle + half_a2) * r2
	
	# ---- STEP 3: draw connecting lines ----
	draw_line(A1, B1, color, line_width)
	draw_line(A2, B2, color, line_width)
	
	# ---- STEP 4: build tangent cap arc at r2 ----
	
	# Midpoint direction (pure angle direction)
	var forward = Vector2.RIGHT.rotated(angle)
	var circle_point = center + forward * r2
	
	# Tangent direction (perpendicular)
	var tangent = forward.rotated(PI/2)
	
	# Points along tangent line
	var T1 = circle_point + tangent * (w2 * 0.5)
	var T2 = circle_point - tangent * (w2 * 0.5)
	
	# LEFT SIDE
	draw_side_arc(center, angle, B1, T2, color, line_width, w2)

# RIGHT SIDE
	draw_side_arc(center, angle, B2, T1, color, line_width, w2)


func circumcenter(A: Vector2, B: Vector2, C: Vector2):
	var d = 2.0 * (A.x*(B.y-C.y) + B.x*(C.y-A.y) + C.x*(A.y-B.y))
	
	if abs(d) < 0.001:
		return null
	
	var ux = (
		(A.length_squared())*(B.y-C.y) +
		(B.length_squared())*(C.y-A.y) +
		(C.length_squared())*(A.y-B.y)
	) / d
	
	var uy = (
		(A.length_squared())*(C.x-B.x) +
		(B.length_squared())*(A.x-C.x) +
		(C.length_squared())*(B.x-A.x)
	) / d
	
	return Vector2(ux, uy)

func draw_side_arc(center: Vector2, angle: float, line_point: Vector2, tangent_point: Vector2, color: Color, l_width: float, width: float):
	# 1. Midpoint between the two points
	var midpoint = (line_point + tangent_point) * 0.5
	
	# 2. Direction of the line connecting the points
	var vec = tangent_point - line_point
	var perp_dir = Vector2(-vec.y, vec.x).normalized()  # perpendicular to the connecting line
	
	# 3. Line along main angle from center
	var angle_dir = Vector2.RIGHT.rotated(angle)
	
	# 4. Solve intersection: line from midpoint along perp_dir vs line from center along angle_dir
	var denom = perp_dir.cross(angle_dir)
	var arc_center: Vector2
	if abs(denom) < 0.0001:
		# lines nearly parallel, fallback to midpoint
		arc_center = midpoint
	else:
		var t = (center - midpoint).cross(angle_dir) / denom
		arc_center = midpoint + perp_dir * t
	
	
	# 5. Compute angles to line_point and tangent_point
	var angle_to_line = atan2(line_point.y - arc_center.y, line_point.x - arc_center.x)
	var angle_to_tangent = atan2(tangent_point.y - arc_center.y, tangent_point.x - arc_center.x)
	# 6. Arc radius = width / 2
	var arc_radius = width * 0.5
	
	# 7. Ensure arc goes the shorter way around
	var a_start = angle_to_tangent
	var a_end = angle_to_line
	
	var extend = 0.025  # half of total extension

	# Extend in correct direction along the arc
	if a_end > a_start:
		a_start -= extend
		a_end   += extend
	else:
		a_start += extend
		a_end   -= extend
	
	if abs(a_end - a_start) > PI:
		if a_start < a_end:
			a_start += TAU
		else:
			a_end += TAU
	
	# 8. Draw the arc
	draw_arc(arc_center, arc_radius, a_start, a_end, 32, color, l_width)
