local Flow = {}

local function reset(self) 
	self.current = "initial"
end

local function addState(self, state, stateTable)
	
end

local function hasState(self, state)
	for s, _ in pairs(self.states) do
		if s == state then
			return true
		end
	end
	return false
end 

local FlowMT = {
	__call = function(self, transitionTable)
		assert(type(transitionTable) == type({}), "You must pass table") 
		local currentStateParams = self.states[self.current]
		assert(currentStateParams, "Unknown state " .. self.current)
		local transitionFunction = currentStateParams.transitionFunction
		local onLeave = currentStateParams.onLeave
		local oldState = self.current
		local newState = transitionFunction(transitionTable)
--		print("Call : old state " .. oldState .. "\tnew state " .. newState)
		assert(self:hasState(newState), "Unknown state " .. newState) 
		if onLeave then onLeave(newState, transitionTable) end
		self.current = newState
		local newStateParams = self.states[self.current]
		local onCome = newStateParams.onCome
		if onCome then onCome(oldState, transitionTable) end
		return self
	end
}

function Flow:new(t)
	local flow = {}
	flow.states = t
	flow.hasState = hasState
	flow.reset = reset
	assert(flow:hasState("initial"), "Flow must have state 'initial'")
	flow.current = "initial"
	return setmetatable(flow, FlowMT)
end

return Flow