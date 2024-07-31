local M = {}

M.deepMerge = function(t1, t2)
	for k, v in pairs(t2) do
		if k == "keys" then
			t1.keys = t1.keys or {}
			for _, keymap in pairs(t2[k]) do
				table.insert(t1.keys, keymap)
			end
		else
			t1[k] = v
		end
	end
	return t1
end

return M
