#!/bin/bash

--xrdb color provider
--Colorproviders have to expose a single function, getcolor(color)


color = {
	black = 1,
	red = 2,
	green = 3,
	yellow = 4,
	blue = 5,
	magenta = 6,
	cyan = 7,
	white = 8,
	grey = 9,
	brightred = 10,
	brightgreen = 11,
	brightyellow = 12,
	brightblue = 13,
	brightmagenta = 14,
	brightcyan = 15,
	brightwhite = 16,
	reverse = {},
	fromVal = function(i) return color.reverse[i] end
}
for k,v in pairs(color) do
		if type(v) == "number" then
				color.reverse[v] = k
				print("Setting " .. v .. " to " .. k)
		end
end

local f = io.popen("xrdb -query", "r")
local output = f:read("*all")
f:close()
local xColor = {}
for colorId, colorCode in output:gmatch("%*color(%d*):.-#(.-)\n") do
		print("Set color " .. tonumber(colorId)+1 .. " to " .. colorCode)
		xColor[tonumber(colorId)+1] = "#FF" .. colorCode
end

function getColor(color)
		return xColor[color]
end
