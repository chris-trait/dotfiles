local M = {}

---@return 'win'|'darwin'|'linux'
function M.get_os()
   if package.config:sub(1, 1) == "\\" then
      return "win"
   elseif (io.popen("uname -s"):read "*a"):match "Darwin" then
      return "darwin"
   else
      return "linux"
   end
end

return M
