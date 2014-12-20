local id
function start() 
	id = getRenderer("volume", side.right)
end

function update()
		local f = io.popen("amixer -D pulse sget Master", "r")
		local out = f:read("*all")
		local volume, status = out:match("Front Left: Playback %d* %[(%d*)%%%] %[(.-)%]")
		print(volume, status)
		renderTo(id, volume)
end

function stop() end
