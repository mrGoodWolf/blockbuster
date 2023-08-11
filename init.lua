local dropdown_table = {
   'first', 'second', 'Third Option', 'fourth', 'fifth', 'Cool Story Bro!!!'
}

local function formspec_dropdown(index)
   local formspec =
   'size[6,3]'..
   'textarea[1,1;4,1;;;this is the text above the dropdown]'..
   'dropdown[1,2;4,2;Dropdown;'..table.concat(dropdown_table, ',')..';'..index..']'..
   'button_exit[3,2.5;2,1;save;Submit]'
   return formspec
end

minetest.register_node('new_mod:dropdown', {
   description = 'Dropdown Example',
   tiles = {'smear.png'},
   groups = {oddly_breakable_by_hand=2},
   on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      local timer = minetest.get_node_timer(pos)
      meta:set_int('index', 4)
      timer:start(4)
   end,
   on_rightclick = function(pos, node, clicker)
      local meta = minetest.get_meta(pos)
      local index = meta:get_int('index')
      meta:set_string('formspec', formspec_dropdown(index))
   end,
   on_receive_fields = function(pos, forname, fields, sender)
      if fields ['save'] then
         local meta = minetest.get_meta(pos)
         for i, pencil in ipairs(dropdown_table) do
            if pencil == fields.Dropdown then
               meta:set_int('index', i)
            end
         end
      end
   end,
   on_timer = function(pos)
      local meta = minetest.get_meta(pos)
      local index = meta:get_int('index')
      local timer = minetest.get_node_timer(pos)
      minetest.chat_send_all('timer ran')
      timer:start(index*4)
   end,
})
