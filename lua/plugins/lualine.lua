--------------------------------------------------------------------------------
--- Lualine setup.
--------------------------------------------------------------------------------

-- setup a Mason setup check.
local mason_status = {
	current_text = "",
	timer = nil,
}

local function update_mason_status()
	local status, registry = pcall(require, "mason-registry")
	if not status then
		mason_status.current_text = ""
		return
	end

	local installed = registry.get_installed_packages()
	local updating = {}

	for _, pkg in ipairs(installed) do
		if pkg:is_installing() then
			table.insert(updating, pkg.name)
		end
	end
	if #updating > 0 then
		mason_status.current_text = "⚙️ Updating: " .. table.concat(updating, ", ")
	else
		mason_status.current_text = ""
	end
end

-- Initialize a timer to update the Mason status every 1 second. This keeps
-- the status line refresh with updated info.
vim.loop.new_timer():start(0, 1000, vim.schedule_wrap(update_mason_status))

local function get_mason_progress()
	return mason_status.current_text
end

require("lualine").setup({
	options = {
		theme = "tokyonight",
	},
	sections = {
		lualine_x = {
			{
				get_mason_progress,
				color = { fg = '#ff9e64', gui = 'bold' },

				-- Only show the component if it actually has text.
				conditional = function()
					return mason_status.current_text ~= ""
				end,
			},
		},
	},
})
