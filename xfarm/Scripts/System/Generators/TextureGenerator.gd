class_name TextureGenerator extends Node2D

const TEXTURE_SIZE: int = 64
const BRICK_DEFAULT_COLOR = Color(0.17, 0.17, 0.17, 1)
const BRICK_LINE_DEFAULT_COLOR = Color(0.11, 0.11, 0.11, 1)

func _ready() -> void:
	pass

func GenerateTexture(r: int, b: int, g: int, a: int) -> Texture2D:
	var texture: Texture2D = Texture2D.new()
	var image: Image = Image.create(TEXTURE_SIZE, TEXTURE_SIZE, false, Image.FORMAT_RGBA8)
	image.fill(Color(r, g, b, a))
	texture = ImageTexture.create_from_image(image)
	return texture

func GenerateBrickTexture(BrickColor: Color = BRICK_DEFAULT_COLOR, LineColor: Color = BRICK_LINE_DEFAULT_COLOR) -> Texture2D:
	var pathTexture: Texture2D = Texture2D.new()
	var image: Image = Image.create(TEXTURE_SIZE, TEXTURE_SIZE, false, Image.FORMAT_RGBA8)
	for u in range(0, TEXTURE_SIZE):
		for v in range(0, TEXTURE_SIZE):
			# image.set_pixel(u, v, BrickColor)
			if v != 0:
				image.set_pixel(u, v, LineColor)
			# if v == 0:
			# 	image.set_pixel(u, v, LineColor)
			# if v == TEXTURE_SIZE - 2:
			# 	image.set_pixel(u, v, LineColor)

			# create background path color
			if v % 16 != 0 and v != 0:
				image.set_pixel(u, v, BrickColor)

			# first vertical line
			if u == TEXTURE_SIZE/2 and v <= TEXTURE_SIZE/4:
				image.set_pixel(u, v, LineColor)
				image.set_pixel(u, v - 1, LineColor)

			# second vertical line
			if u == TEXTURE_SIZE/4 and not v >= TEXTURE_SIZE/2 and not v <= TEXTURE_SIZE/4:
				image.set_pixel(u, v, LineColor)
			# third vertical line
			if u == TEXTURE_SIZE * 3/4 and v >= TEXTURE_SIZE/4 and not v >= TEXTURE_SIZE/2:
				image.set_pixel(u, v, LineColor)
			# fourth vertical line
			if u == TEXTURE_SIZE/2 and not v <= TEXTURE_SIZE/2 and v <= TEXTURE_SIZE - TEXTURE_SIZE / 4:
				image.set_pixel(u, v, LineColor)
			# fifth vertical line
			if u == TEXTURE_SIZE/4 and not v <= TEXTURE_SIZE/2 and not v <= TEXTURE_SIZE - TEXTURE_SIZE / 4:
				image.set_pixel(u, v, LineColor)
			# sixth vertical line
			if u == TEXTURE_SIZE - TEXTURE_SIZE/4 and v >= TEXTURE_SIZE - TEXTURE_SIZE / 4:
				image.set_pixel(u, v, LineColor)
			
			# image.set_pixel(u, TEXTURE_SIZE - 1, LineColor)

			if v == 0 and u <= TEXTURE_SIZE:
				image.set_pixel(u, v, LineColor)
			
	pathTexture = ImageTexture.create_from_image(image)
	return pathTexture

func GenerateGroundTexture(
			base_color_r: float, base_color_g: float, base_color_b: float,
			roughness: float = 0.3,
			detail_scale: float = 40.0,
			octaves: int = 5
		) -> Texture2D:

	var texture_size = 64
	var image = Image.create(texture_size, texture_size, false, Image.FORMAT_RGBA8)
	
	for y in range(texture_size):
		for x in range(texture_size):
			# Normalized UV coordinates
			var uv_x = float(x) / texture_size
			var uv_y = float(y) / texture_size
			
			# Main FBM for large variations
			var main_noise = fbm(uv_x * detail_scale, uv_y * detail_scale, octaves, 2.0, 0.5)
			
			# Secondary noise for finer details
			var detail_noise = fbm(uv_x * detail_scale * 3.0, uv_y * detail_scale * 3.0, 3, 2.0, 0.3)
			
			# Combine noises
			var combined = main_noise * 0.7 + detail_noise * 0.3
			combined = (combined + 1.0) * 0.5  # Normalize to 0-1
			
			# Apply roughness to sharpen edges
			combined = pow(combined, roughness)
			
			# Color variation based on height/noise
			var r = base_color_r + combined * 0.2
			var g = base_color_g + combined * 0.2
			var b = base_color_b + combined * 0.1
			
			# Add darker crevices
			r -= combined * 0.3
			g -= combined * 0.3
			b -= combined * 0.3
			
			# Clamp values
			r = clamp(r, 0.0, 1.0)
			g = clamp(g, 0.0, 1.0)
			b = clamp(b, 0.0, 1.0)
			
			image.set_pixel(x, y, Color(r, g, b, 1.0))
	
	return ImageTexture.create_from_image(image)

func fbm(x: float, y: float, octaves: int = 6, lacunarity: float = 2.0, persistence: float = 0.5) -> float:
	var total = 0.0
	var amplitude = 1.0
	var frequency = 1.0
	var max_value = 0.0
	
	for i in range(octaves):
		total += smooth_noise(x, y, frequency) * amplitude
		max_value += amplitude
		
		amplitude *= persistence
		frequency *= lacunarity
	
	return total / max_value

func smooth_noise(x: float, y: float, frequency: float) -> float:
	var nx = x * frequency
	var ny = y * frequency
	
	var x0 = floor(nx)
	var y0 = floor(ny)
	var x1 = x0 + 1.0
	var y1 = y0 + 1.0
	
	var fx = frac(nx)
	var fy = frac(ny)
	
	# Smooth interpolation curves
	var sx = fade(fx)
	var sy = fade(fy)
	
	var n00 = hash_2d(x0, y0)
	var n01 = hash_2d(x0, y1)
	var n10 = hash_2d(x1, y0)
	var n11 = hash_2d(x1, y1)
	
	var ix0 = lerp(n00, n10, sx)
	var ix1 = lerp(n01, n11, sx)
	
	return lerp(ix0, ix1, sy)

func fade(t: float) -> float:
	# Smoothstep for smooth transitions
	return t * t * t * (t * (t * 6.0 - 15.0) + 10.0)

func hash_2d(x: int, y: int) -> float:
	var n = sin(float(x) * 12.9898 + float(y) * 78.233) * 43758.5453
	return frac(n) * 2.0 - 1.0

func lerp(a: float, b: float, t: float) -> float:
	return a + t * (b - a)
	
func noise_2d(x: float, y: float) -> float:
	# Simplex-like noise approximation
	var n = sin(x * 12.9898 + y * 78.233) * 43758.5453
	return frac(n) - 0.5

func frac(f: float) -> float:
	return f - floor(f)

func distance(ax: float, ay: float, bx: float, by: float) -> float:
	return sqrt(pow(bx - ax, 2) + pow(by - ay, 2))

func worley_noise(x: float, y: float, scale: float = 1.0) -> float:
	var min_dist = 1.0
	var cell_x = floor(x / scale)
	var cell_y = floor(y / scale)
	
	for i in range(-1, 2):
		for j in range(-1, 2):
			var px = rand_seed(cell_x + i, cell_y + j, 0) * scale
			var py = rand_seed(cell_x + i, cell_y + j, 1) * scale
			
			var cell_fx = (cell_x + i) * scale + px
			var cell_fy = (cell_y + j) * scale + py
			
			var dist = distance(x, y, cell_fx, cell_fy)
			if dist < min_dist:
				min_dist = dist
	
	return min_dist / scale

func rand_seed(x: int, y: int, seed_idx: int) -> float:
	var n = sin(float(x) * 12.9898 + float(y) * 78.233 + float(seed_idx) * 23.5432) * 43758.5453
	return frac(n)

func domain_warp(x: float, y: float, strength: float = 0.5) -> Vector2:
	var wx = fbm(x, y, 4, 2.0, 0.5) * strength
	var wy = fbm(x + 100.0, y + 100.0, 4, 2.0, 0.5) * strength
	return Vector2(x + wx, y + wy)
