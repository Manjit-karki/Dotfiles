hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 6,

    border_size = 1,

    col = {
      active_border = { colors = {"rgba(33ccffee)" , "rgba(00ff99ee)"}, angle = 45},
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.90,

    shadow = {
        enabled = true,
        range = 15,
        render_power = 5,
        color = "rgba(0,0,0,.5)",

  },

    blur = {
        enabled = true,
        size = 2,
        passes = 3,
	ignore_opacity = true,
	popups = true,
	xray = false,
        vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

})


hl.config({
  dwindle = {
    preserve_split = true,
  },
})

hl.config({
  master = {
    new_status = "master",
  },
})

hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})
