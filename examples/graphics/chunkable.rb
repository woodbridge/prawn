$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/../../lib"
require "rubygems"
require "prawn"

def paint(canvas, filename)
  doc = Prawn::Document.new
  doc.add_content(canvas.to_pdf)
  doc.render_file(filename)
end

canvas = Prawn::Canvas.new
canvas.line(:point1 => [100,100], :point2 => [150,175])

canvas.curve(:point1 => [100,100],
             :point2 => [50,50], 
             :bound1 => [60,90],
             :bound2 => [60,90])

canvas.rectangle(:point => [200,200], :width => 50, :height => 75)

canvas.stroke

canvas.ellipse(:point => [200,200], :x_radius => 10, :y_radius => 20)

canvas.fill

circle = canvas.circle!(:point => [250,200], :radius => 20)
puts circle.to_pdf
circle[:radius] = 50
canvas.chunks << circle

canvas.stroke

canvas.polygon(:points => [[300,300], [300,400], [400,400]])
canvas.stroke

canvas.rounded_polygon(:radius => 10, :points => [[100, 250], [200, 300], [300, 250],
                                                  [300, 150], [200, 100], [100, 150]])
canvas.stroke

canvas.rounded_rectangle(:point => [300,300], :width => 100, :height => 200, :radius => 10)
canvas.stroke

paint(canvas, "x.pdf")

canvas.find_chunks(:command => :line).first[:point2] = [150, 300]
paint(canvas, "y.pdf")

