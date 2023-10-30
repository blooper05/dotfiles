local wezterm = require('wezterm')

local mux = wezterm.mux
local config = wezterm.config_builder()

wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.font = wezterm.font('HackGen35 Console NF')
config.font_size = 15.0
config.color_scheme = 'nordfox'

return config
