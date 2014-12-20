require 'textcolor'

local renderer
function start() 
		renderer = getRenderer("clock", side.right)	
end

function update(time)
		renderer:clear()
		local icon = ""
		local time = os.date(" %H:%M")

		renderer:render(icon, color.white)
		renderer:render(time, color.white)
end

function stop() end
