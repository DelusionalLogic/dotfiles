require 'textcolor'

local id
function start() 
		id = registerRenderSpot("clock", side.right)	
end

function update(time)
		local time = os.date("%H:%M")
		print(time)
		renderTo(id, time)
end

function stop() end
