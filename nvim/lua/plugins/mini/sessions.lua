local H = {}
local M = {}

local minisessions = require("mini.sessions")
minisessions.setup({})

M.save_prompt = "Save session as: "

M.save = function()
	H.get_session_from_user(M.save_prompt, function(res)
		if res == nil then
			return
		end
		minisessions.write(res)
	end)
end

-- For autocompletion of session name
Config._session_complete = function(arg_lead)
	return vim.tbl_filter(function(x)
		return x:find(arg_lead, 1, true) ~= nil
	end, vim.tbl_keys(minisessions.detected))
end

H.get_session_from_user = function(prompt, on_confirm)
	local completion = "customlist,v:lua.Config._session_complete"
	vim.ui.input({
		prompt = prompt,
		cancelreturn = nil,
		completion = completion,
	}, on_confirm)
end

return M
