#!/usr/local/bin/lua

local Flow = require "Flow"

--local function stdOnChangeState(st, transitionTable)
--	print("
--end

local initial = {}
function initial.transitionFunction(t)
	if (type(t[1]) == type(0)) then
		return "stateN"
	elseif (type(t[1]) == type("")) then
		return "stateS"
	else
		return "initial"
	end
end

function initial.onLeave(s, t)
	print("Leaving initial state to " .. s)
end

local stateN = {}
function stateN.transitionFunction(t)
	if (type(t[1]) == type("")) then
		return "final"
	else
		return "stateN"
	end
end

local stateS = {}
function stateS.transitionFunction(t)
	if (type(t[1]) == type(0)) then
		return "final"
	else
		return "stateS"
	end
end

local final = {}
function final.transitionFunction(t)
	return "initial"
end

function final.onCome(s, t)
	print("Come to final state from " .. s)
end

local f = Flow:new {
	initial = initial,
	stateN = stateN,
	stateS = stateS,
	final = final	
}

f { "erwer" }{ "fsf" }{0}{}{0}{0}{""}{""}
print(f.current)