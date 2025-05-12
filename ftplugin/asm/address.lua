local ns_id = vim.api.nvim_create_namespace("asm_address")

local base_address = 0x0000
local instruction_size = 2

local comment_regex = "^%s*;"
local lable_regex = "^%s*%$"
local empty_regex = "^%s*$"
local orig_regex = "^%s*ORIG"
local empty_virt = "        "

local function show_text(buf, line_number, str)
	vim.api.nvim_buf_set_extmark(buf, ns_id, line_number, 0, {
		virt_text = {{ str, "VirtText" }},
		virt_text_pos = "inline",
		hl_group = "AsmAddress",
		id = line_number + 1,
		right_gravity = false,
	})
end

local function update_addresses(buf)
	local lines = vim.api.nvim_buf_line_count(buf)
	local orig_found = false
	local base_offset = 0

	for i = 0, lines - 1 do
		-- Clear old virtual text
		-- vim.api.nvim_buf_del_extmark(buf, ns_id, i+1)
		local line = vim.api.nvim_buf_get_lines(buf, i, i+ 1, false)[1]

		if string.match(line, comment_regex) or string.match(line, empty_regex) then
			show_text(buf, i, empty_virt)
		elseif string.match(line, orig_regex) then
			if not orig_found then
				local prompt = string.upper(line)
				local hex_string = string.match(prompt, "X(%x+)")
				if hex_string then
					base_address = tonumber(hex_string, 16)
				else
					local bin_string = string.match(prompt, "B(%d+)")
					if bin_string then
						base_address = tonumber(bin_string, 2)
					else
						local dec_string = string.match(prompt, " (%d+)")
						if dec_string then
							base_address = tonumber(dec_string, 10)
						else
							base_address = 0
						end
					end
				end
				orig_found = true
			end
			show_text(buf, i, empty_virt)
		elseif string.match(line, lable_regex) then
			if not orig_found then
				orig_found = true
				base_address = 0
			end
			show_text(buf, i, empty_virt)
		else
			if not orig_found then
				orig_found = true
				base_address = 0
			end
			local addr = base_address + base_offset
			base_offset = base_offset + instruction_size
			local addr_str = string.format("0x%04X  ", addr)
			show_text(buf, i, addr_str)
		end
	end
end

local buf = vim.api.nvim_get_current_buf()

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
	callback = function() update_addresses(buf) end,
})
