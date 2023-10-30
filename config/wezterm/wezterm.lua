local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.font = wezterm.font('HackGen35 Console NF')
config.font_size = 15.0
config.color_scheme = 'nordfox'

return config
