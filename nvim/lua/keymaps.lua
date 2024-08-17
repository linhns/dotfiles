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
nxmap(
    "<leader>gs",
    cmd("lua MiniGit.show_at_cursor()"),
    "Show Git status at cursor"
)
nmap("<leader>sd", cmd("lua MiniSessions.select('delete')"), "Delete session")
nmap("<leader>sl", cmd("lua MiniSessions.select()"), "Load session")
nmap(
    "<leader>ss",
    cmd("lua require('plugins.mini.sessions').save()"),
    "Save session"
)
nmap("<leader>so", cmd("lua MiniSessions.select('write')"), "Overwrite session")

nmap(
    "<leader>ee",
    cmd("lua require('mini.files').open(vim.uv.cwd())"),
    "Open file explorer (cwd)"
)

nmap(
    "<leader>ef",
    cmd("lua MiniFiles.open(vim.api.nvim_buf_get_name(0))"),
    "Open file explorer (buffer)"
)

nmap("<leader>ba", cmd("b#"), "Alternate buffer")

nmap(
    "<leader>bd",
    cmd("lua require('mini.bufremove').delete()"),
    "Delete current buffer"
)

nmap("<leader>bD", cmd('%bdelete|edit #|normal`"'), "Delete other buffers")

nmap("<leader>dc", cmd("lua require('dap').continue()"), "Continue (Start)")

nmap(
    "<leader>db",
    cmd("lua require('dap').toggle_breakpoint()"),
    "Toggle Breakpoint"
)

nmap(
    "<leader>dB",
    cmd("lua require('dap').clear_breakpoints()"),
    "Clear Breakpoints"
)

nmap("<leader>dn", cmd("lua require('dap').step_over()"), "Step Over")

nmap("<leader>di", cmd("lua require('dap').step_into()"), "Step Into")

nmap("<leader>do", cmd("lua require('dap').step_out()"), "Step Out")

nmap("<leader>dt", cmd("lua require('dap').terminate()"), "Stop/Kill")

nmap("<leader>dr", cmd("lua require('dap').run_last()"), "Rerun Last Config")

nmap("<leader>dR", cmd("lua require('dap').restart()"), "Restart")

nmap(
    "<leader>dh",
    cmd("lua require('dap.ui.widgets').hover()"),
    "Evaluate (Floating Window)"
)

nmap(
    "<leader>dp",
    cmd("lua require('dap.ui.widgets').preview()"),
    "Evaluate (Preview)"
)

nmap(
    "<leader>ds",
    cmd(
        "lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)"
    ),
    "View Scope (Floating Window)"
)

nmap(
    "<leader>df",
    cmd(
        "lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)"
    ),
    "View Frames (Floating Window)"
)

nmap(
    "<leader>tr",
    cmd("lua require('neotest').run.run(vim.fn.expand('%'))"),
    "Run File"
)

nmap("<leader>tn", cmd("lua require('neotest').run.run()"), "Run Nearest")

nmap(
    "<leader>td",
    cmd("lua require('neotest').run.run({strategy = 'dap'})"),
    "Debug Nearest"
)

nmap(
    "<leader>to",
    cmd(
        "lua require('neotest').output.open({ enter = true, last_run = true, auto_close = true})"
    ),
    "Open Output (Last Run)"
)

nmap(
    "<leader>ts",
    cmd("lua require('neotest').summary.toggle()"),
    "Toggle Summary"
)

-- Find mappings
nmap("<leader>ff", cmd("Pick files"), "Find files")

nmap("<leader>fb", cmd("Pick buffers"), "Find buffers")

nmap("<leader>fh", cmd("Pick help"), "Find help")

nmap("<leader>fH", cmd("Pick history"), "Find history")

nmap("<leader>ff", cmd("Pick files"), "Find files")

nmap('<leader>f"', cmd("Pick registers"), "Find registers")

nmap("<leader>fc", cmd("Pick commands"), "Find commands")

nmap("<leader>fg", cmd("Pick grep_live"), "Find pattern (live)")

nmap(
    "<leader>fd",
    cmd("Pick diagnostic scope='current'"),
    "Find diagnostic (buffer)"
)

nmap("<leader>fD", cmd("Pick diagnostic"), "Find diagnostic (all)")

nmap("<leader>fl", cmd("Pick buf_lines"), "Find line (buffer)")

nmap("<leader>fR", cmd("Pick resume"), "Resume Find")
nmap("<leader>ft", cmd("Pick treesitter"), "Find Treesitter objects")
nmap("<leader>fr", cmd("Pick oldfiles"), "Find recent files")

nmap("<leader>fo", cmd("Pick options"), "Find options")

nmap("z=", cmd("Pick spellsuggest"), "Show spelling suggestions")

nmap("<leader>fm", cmd("Pick marks"), "Find marks")
nmap("<leader>fk", cmd("Pick keymaps"), "Find keymaps")
nmap("<leader>gff", cmd("Pick git_files"), "Find git files")
nmap("<leader>gfd", cmd("Pick git_files scope='deleted'"), "Find deleted files")
nmap("<leader>gfi", cmd("Pick git_files scope='ignored'"), "Find ignored files")
nmap(
    "<leader>gfu",
    cmd("Pick git_files scope='untracked'"),
    "Find untracked files"
)
nmap(
    "<leader>gfm",
    cmd("Pick git_files scope='modified'"),
    "Find modified files"
)
