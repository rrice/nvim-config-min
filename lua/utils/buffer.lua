local M = {}

-- Returns true if the supplied buffer has unsaved changes.
local function is_modified(bufnr)
	return vim.api.nvim_get_option_value("modified", { buf = bufnr })
end

local function notify(msg, level)
	-- 'level' can be 'info' (default) , 'warn', 'error'.
	vim.notify(msg, level or "info")
end

--- Get a readable identifier for a buffer:
---   * file name (basename) if the buffer has a file
---   * otherwise “buffer <nr> (unnamed)”.
local function get_buffer_label(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr) -- full path
	if name ~= "" and name ~= nil then
		-- Show only the file name, not the whole path
		return vim.fn.fnamemodify(name, ":t")
	else
		return string.format("buffer %d (unnamed)", bufnr)
	end
end

--- Delete the current buffer.
--- @param force boolean If true, skip the confirmation even when modified.
function M.delete(force)
	local bufnr = vim.api.nvim_get_current_buf()
	local buflabel = get_buffer_label(bufnr)

	if not force and is_modified(bufnr) then
		local answer = vim.fn.confirm("Buffer has unsaved changes. Close anyway?", "&Yes\n&No", 2)
		if answer ~= 1 then
			return
		end
		force = true
	end
	local ok, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = force })
	if ok then
		notify(string.format("Deleted buffer %s", buflabel))
	else
		notify("Failed to delete buffer: " .. buflabel .. ": " .. err, "error")
	end
end

--- Delete all buffers except the current one and post a summary notification.
--- @param force boolean  Skip confirmation for modified buffers.
function M.delete_others(force)
	local cur = vim.api.nvim_get_current_buf()
	local deleted = 0
	local skipped = 0

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if bufnr ~= cur then
			local do_force = force
			local buflabel = get_buffer_label(bufnr)
			if not force and is_modified(bufnr) then
				local answer = vim.fn.confirm(
					string.format("Buffer %s has unsaved changes. Close anyway?", buflabel),
					"&Yes\n&No",
					2
				)
				if answer ~= 1 then
					skipped = skipped + 1
					goto continue
				end
				do_force = true
			end

			local ok, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = do_force })
			if ok then
				deleted = deleted + 1
			else
				notify("Failed to delete buffer: " .. buflabel .. ": " .. err, "error")
			end
		end
		::continue::
	end

	notify(string.format("Deleted %d buffer(s), skipped %d", deleted, skipped))
end

return M
