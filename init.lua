--- @module 'progress-bar'
local ProgressBar = {}

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
    Invert = invert or false
  }
  self.__index = self
  return setmetatable(obj, self)
end

--- (Re)Start the progress bar ramp from the beginning value.
function ProgressBar:Start()
  self.Control.RampTime = 0
  self.Control.Position = self.invert and 1 or 0
  self.Control.RampTime = self.RampTime
  self.Control.Position = self.invert and 0 or 1
end

--- Quickly ramp the progress bar to the end from it's current position.
function ProgressBar:End()
  self.Control.RampTime = self.SkipRampTime
  self.Control.Position = self.invert and 0 or 1
end

return ProgressBar
