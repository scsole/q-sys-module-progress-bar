# Q-Sys Progress Bar Module

Q-Sys module to create a progress bar using a meter control.

[![Luacheck](https://github.com/scsole/q-sys-module-progress-bar/actions/workflows/luacheck.yml/badge.svg)](https://github.com/scsole/q-sys-module-progress-bar/actions/workflows/luacheck.yml)

## Quick start

1. Clone or download this repository to the Modules directory, the folder should be named `progress-bar`
2. Add the module to the project using Design Resources
3. Use the module

## Basic Usage

Add a meter or knob control and style it as desired. If using a knob, the `Units`, `Min`, and `Max` properties do not
matter.

```lua
local ProgressBar = require('progress-bar')
local myBar = ProgressBar:New(Controls.ProgressMeter, 10)
myBar.EventHandler = someFunction
myBar:Start()
myBar:Skip()
```
