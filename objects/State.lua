State = Object:extend()

function State:new(initialState)
  local instance = initialState()
  self.state = { instance }
end

function State:push(state)
  table.insert(self.state, state)
end

function State:current()
  return self.state[#self.state]
end

function State:pop() 
  if self:current().destroy then self:current():destroy() end
  table.remove(self.state)
end

function State:replace(state)
  self:pop()
  self:push(state)
end
