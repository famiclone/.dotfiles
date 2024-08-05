local wezterm = require 'wezterm';
local mux = wezterm.mux;
local config = wezterm.config_builder();

config.enable_tab_bar = false;
config.enable_scroll_bar = false;
config.color_scheme = "MaterialDark";
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 0,
}
config.font = wezterm.font 'FantasqueSansM Nerd Font'
config.font_size = 13.2
config.window_decorations = "RESIZE"

return config;
