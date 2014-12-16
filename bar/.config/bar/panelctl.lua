#!/bin/lua

function enable(unitname)
		print(unitname)
end

modes = {
		["enable"] = {handler = enable, args = {
				{2} 
		}},
		["disable"] = {handler = disable, args = {}},
		["modules"] = {handler = modules, args = {}},
}

print(arg[1])
handler = modes[arg[1]]
args = {}
for k,v in pairs(handler.args) do
		curArg = arg[v[1]]
		if v[2] then
				curArg = v[2](curArg)
		end
		table.insert(args, curArg) 
end

handler.handler(table.unpack(args))
