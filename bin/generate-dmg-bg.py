from PIL import Image, ImageDraw, ImageFont
import os

# Create a blank image with a gradient background
width, height = 800, 400
background = Image.new('RGB', (width, height), 'white')
draw = ImageDraw.Draw(background)

# Create a gradient background
for i in range(height):
    color = (255 - i // 2, 255 - i // 4, 255 - i // 2) # Light green gradient
    draw.line([(0, i), (width, i)], fill=color)

# Add a fancy arrow design
arrow_color = (64, 64, 64)
arrow_start = (290, 200)
arrow_end = (490, 200)
arrow_width = 10

# Draw arrow shaft
draw.line([arrow_start, arrow_end], fill=arrow_color, width=arrow_width)

# Draw arrow head
draw.polygon([
    (arrow_end[0], arrow_end[1] - 15),
    (arrow_end[0] + 30, arrow_end[1]),
    (arrow_end[0], arrow_end[1] + 15)
], fill=arrow_color)

font_path = "/Library/Fonts/Arial.ttf"

try:
    font = ImageFont.truetype(font_path, 22)
except IOError:
    font = ImageFont.load_default()

text = "Drag to install"
text_position = (325, 240)
text_color = (0, 0, 0)

draw.text(text_position, text, fill=text_color, font=font)

# Save the image
background.save("./assets/dmg-background.png")
