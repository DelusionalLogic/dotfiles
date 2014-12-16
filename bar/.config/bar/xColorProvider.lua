#!/bin/bash

--xrdb color provider
--Colorproviders have to expose a single function, getcolor(color)


local colornames = {
	"black",
	"red",
	"green",
	"yellow",
	"blue",
	"magenta",
	"cyan",
	"white",
	"grey",
	"brightred",
	"brightgreen",
	"brightyellow",
	"brightblue",
	"brightmagenta",
	"brightcyan",
	"brightwhite",
}

local f = io.popen("xrdb -query", "r")
local output = f:read("*all")
f:close()
local xColor = {}
for col, color in output:gmatch("%*color(%d*):.-#(.-)\n") do
		print("Set color " .. colornames[tonumber(col)+1] .. " to " .. color)
		xColor[colornames[tonumber(col)+1]] = "#FF" .. color
end

function getColor(name)
		return xColor[name]
end
