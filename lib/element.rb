# -*- coding: UTF-8 -*-
# In:: element
# Out:: Array of position
# Author:: Fabrice
def get_center(element)
	element_left = element.wd.location[0]
	element_width = element.wd.size.width
	element_top = element.wd.location[1]
	element_height = element.wd.size.height
	# Return center of the element
	{
		'x'	=> element_left + (element_width / 2).round(0),
		'y' => element_top + (element_height / 2).round(0)
	}
end


# In:: element
# Out:: Array of position
# Author:: Fabrice
def get_position(element)
	element_left = element.wd.location[0]
	element_width = element.wd.size.width
	element_right = element_left + element_width
	element_top = element.wd.location[1]
	element_height = element.wd.size.height
	element_bottom = element_top + element_height
	# return
	{
		'left' => element_left,
		'right' => element_right,
		'width' => element_width,
		'top' => element_top,
		'bottom' => element_bottom,
		'height' => element_height
	}
end
