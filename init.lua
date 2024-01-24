--- @module 'progress-bar'
local ProgressBar = {}

local function raiseEvent(self)
  if self.EventHandler ~= nil then
    self.EventHandler()
  end
end

local function timerEventHandler(self)
  self._timer:Stop()
  if self.EventHandlerDelayTime == 0 then
    raiseEvent(self)
  end
  -- If the EventHandler is used to hide the progress bar, a small delay allows it to remain visible just long enough
  -- to be seen
  Timer.CallAfter(function()
    raiseEvent(self)
  end, self.EventHandlerDelayTime)
end

--- Create a new progress bar object.
--- @param control table The control to use as a progress bar, usually a knob or fader.
--- @param rampTime number? The time (s) to ramp the progress bar from 0% to 100%, default is 10s.
--- @param invert boolean? True to ramp from 100% to 0%, else false (default) to ramp from 0% to 100%.
--- @return table # The progress bar object, or nil when passed a nil reference.
function ProgressBar:New(control, rampTime, invert)
  local obj = {
    Control = control,
    RampTime = rampTime or 10,
    SkipRampTime = 0.2,
    Invert = invert or false,
    _timer = Timer.New(),
    EventHandler = nil,
    EventHandlerDelayTime = 0.2
  }

  obj._timer.EventHandler = function()
    timerEventHandler(obj)
  end

  self.__index = self
  return setmetatable(obj, self)
end

--- (Re)Start the progress bar ramp from the beginning value.
function ProgressBar:Start()
  self._timer:Stop()
  self.Control.RampTime = 0
  self.Control.Position = self.invert and 1 or 0
  self.Control.RampTime = self.RampTime
  self.Control.Position = self.invert and 0 or 1
  -- Assume EventHandler will not change during the ramp time
  if self.EventHandler ~= nil then
    self._timer:Start(self.RampTime)
  end
end

--- Quickly ramp the progress bar to the end from it's current position.
function ProgressBar:Skip()
  self._timer:Stop()
  self.Control.RampTime = self.SkipRampTime
  self.Control.Position = self.invert and 0 or 1
  if self.EventHandler ~= nil then
    self._timer:Start(self.SkipRampTime)
  end
end

return ProgressBar
