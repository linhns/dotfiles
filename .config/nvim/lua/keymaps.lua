local utils = require("utils")
local keymapper = utils.map
local map = utils.map
local nmap = function(...)
    utils.nmap(keymapper, ...)
end
local nxmap = function(...)
    utils.nxmap(keymapper, ...)
end
local nximap = function(...)
    utils.nximap(keymapper, ...)
end
local cmd = utils.cmd

-- Paste from clipboard
nxmap(",p", [["+p]])

-- Delete without changing registers
nxmap(",d", [["_d]])
nxmap("x", [["_x]])

-- Terminal mode mappings
map("t", "<C-n>", "<C-\\><C-n>")

-- Do not use arrow keys
nximap("<Up>", "<NOP>")
nximap("<Down>", "<NOP>")
nximap("<Left>", "<NOP>")
nximap("<Right>", "<NOP>")

-- Centered search
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- Centered page movements
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")

-- Leader mappings
nmap("<leader>go", cmd("lua MiniDiff.toggle_overlay()"), "Toggle diff overlay")
nxmap("<leader>gs", cmd("lua MiniGit.show_at_cursor()"), "Show Git status at cursor")

-- Mappings for mini.sessions
nmap("<leader>ssd", cmd("lua MiniSessions.select('delete')"), "Delete session")
nmap("<leader>ssl", cmd("lua MiniSessions.select()"), "Load session")
nmap("<leader>sss", cmd("lua require('plugins.mini.sessions').save()"), "Save session")
nmap("<leader>sso", cmd("lua MiniSessions.select('write')"), "Overwrite session")

-- File explorer
nmap("<leader>ee", cmd("lua require('mini.files').open(vim.uv.cwd())"), "Open file explorer (cwd)")
nmap("<leader>ef", cmd("lua MiniFiles.open(vim.api.nvim_buf_get_name(0))"), "Open file explorer (buffer)")

-- Buffer
nmap("<leader>bl", cmd("b#"), "Last buffer")
nmap("<leader>bd", cmd("lua require('snacks').bufdelete()"), "Delete buffer")
nmap("<leader>bD", cmd("lua require('snacks').bufdelete.all()"), "Delete all buffers")
nmap("<leader>bO", cmd("lua require('snacks').bufdelete.other()"), "Delete other buffers")
nmap("<leader>bp", cmd("bprevious"), "Previous buffer")
nmap("<leader>bn", cmd("bnext"), "Next buffer")
nmap("<leader>bb", cmd("lua require('snacks').picker.buffers()"), "Switch buffer")
nmap("<leader>,", cmd("lua require('snacks').picker.buffers()"), "Switch buffer")

-- Debug
nmap("<leader>dc", cmd("lua require('dap').continue()"), "Continue (Start)")
nmap("<leader>db", cmd("lua require('dap').toggle_breakpoint()"), "Toggle Breakpoint")
nmap("<leader>dB", cmd("lua require('dap').clear_breakpoints()"), "Clear Breakpoints")
nmap("<leader>dn", cmd("lua require('dap').step_over()"), "Step Over")
nmap("<leader>di", cmd("lua require('dap').step_into()"), "Step Into")
nmap("<leader>do", cmd("lua require('dap').step_out()"), "Step Out")
nmap("<leader>dt", cmd("lua require('dap').terminate()"), "Stop/Kill")
nmap("<leader>dr", cmd("lua require('dap').run_last()"), "Rerun Last Config")
nmap("<leader>dR", cmd("lua require('dap').restart()"), "Restart")
nmap("<leader>dh", cmd("lua require('dap.ui.widgets').hover()"), "Evaluate (Floating Window)")
nmap("<leader>dp", cmd("lua require('dap.ui.widgets').preview()"), "Evaluate (Preview)")
nmap(
    "<leader>ds",
    cmd("lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)"),
    "View Scope (Floating Window)"
)
nmap(
    "<leader>df",
    cmd("lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)"),
    "View Frames (Floating Window)"
)

-- Test
nmap("<leader>tr", cmd("lua require('neotest').run.run(vim.fn.expand('%'))"), "Run File")
nmap("<leader>tn", cmd("lua require('neotest').run.run()"), "Run Nearest")
nmap("<leader>td", cmd("lua require('neotest').run.run({strategy = 'dap'})"), "Debug Nearest")
nmap(
    "<leader>to",
    cmd("lua require('neotest').output.open({ enter = true, last_run = true, auto_close = true})"),
    "Open Output (Last Run)"
)
nmap("<leader>ts", cmd("lua require('neotest').summary.toggle()"), "Toggle Summary")

-- File
nmap("<leader>ff", cmd("lua require('snacks').picker.files()"), "Find files")
nmap(
    "<leader>fp",
    cmd("lua require('snacks').picker.files({ cwd = vim.fn.stdpath('config') })"),
    "Find file in private config"
)
nmap("<leader>fr", cmd("lua require('snacks').picker.recent()"), "Recent files")
nmap("<leader><space>", cmd("lua require('snacks').picker.smart()"), "Smart Find files")
nmap("<leader>fy", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", vim.fn.fnamemodify(path, ":p"))
end, "Yank file path")

-- Grep
nmap("<leader>sg", cmd("lua require('snacks').picker.grep()"), "Grep")
nmap("<leader>sw", cmd("lua require('snacks').picker.grep_word()"), "Grep whole words")

-- Search
nmap("<leader>sa", cmd("lua require('snacks').picker.autocmds()"), "Autocmds")
nmap("<leader>sc", cmd("lua require('snacks').picker.command_history()"), "Command history")
nmap("<leader>sC", cmd("lua require('snacks').picker.commands()"), "Commands")
nmap('<leader>s"', cmd("lua require('snacks').picker.registers()"), "Registers")
nmap("<leader>sd", cmd("lua require('snacks').picker.diagnostics_buffer()"), "Diagnostics (buffer)")
nmap("<leader>sD", cmd("lua require('snacks').picker.diagnostics()"), "Diagnostics")
nmap("<leader>sh", cmd("lua require('snacks').picker.help()"), "Help")
nmap("<leader>sH", cmd("lua require('snacks').picker.highlights()"), "Highlights")
nmap("<leader>sj", cmd("lua require('snacks').picker.jumps()"), "Jumps")
nmap("<leader>sk", cmd("lua require('snacks').picker.keymaps()"), "Keymaps")
nmap("<leader>sm", cmd("lua require('snacks').picker.marks()"), "Marks")
nmap("<leader>sR", cmd("lua require('snacks').picker.resume()"), "Resume")
nmap("<leader>sp", cmd("lua require('snacks').picker()"), "Pickers")
nmap("z=", cmd("lua require('snacks').picker.spelling()"), "Show spelling suggestions")

-- nmap("<leader>fv", cmd("Pick visit_paths"), "Find visited paths")
-- nmap("<leader>fV", cmd("Pick visit_labels"), "Find visited labels")

-- Git
nmap("<leader>gff", cmd("lua require('snacks').picker.git_files()"), "Find files")
nmap("<leader>gfc", cmd("lua require('snacks').picker.git_log()"), "Find commits")
nmap("<leader>gb", cmd("lua require('snacks').picker.git_branches()"), "Switch branch")
nmap("<leader>gS", cmd("lua require('snacks').picker.git_stash()"), "Apply stash")

-- Mappings for mini.visits
-- nmap("<leader>vl", cmd("lua MiniVisits.add_label()"), "Add label")
-- nmap("<leader>vL", cmd("lua MiniVisits.remove_label()"), "Remove label")

-- Projects
nmap("<leader>pp", cmd("lua require('snacks').picker.projects()"), "Switch project")
