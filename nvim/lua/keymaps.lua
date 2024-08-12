-- Copy to clipboard
vim.keymap.set({ "n", "v" }, ",y", [["+y]])

-- Paste from clipboard
vim.keymap.set({ "n", "v" }, ",p", [["+p]])

-- Delete without changing registers
vim.keymap.set({ "n", "v" }, ",d", [["_d]])
vim.keymap.set({ "n", "v" }, "x", [["_x]])

-- No arrow keys
vim.keymap.set({ "n", "v", "i" }, "<up>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<down>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<left>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<right>", "<nop>")

-- Centered search movements
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Centered page movements
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Terminal mode mappings
vim.keymap.set("t", "<C-n>", "<C-\\><C-n>")

local keyutils = require("utils.functions.keymaps")

-- Leader mappings
keyutils.nmap(
    "<leader>go",
    keyutils.cmd("lua MiniDiff.toggle_overlay()"),
    "Toggle diff overlay"
)
keyutils.nxmap(
    "<leader>gs",
    keyutils.cmd("lua MiniGit.show_at_cursor()"),
    "Show Git status at cursor"
)
keyutils.nmap(
    "<leader>sd",
    keyutils.cmd("lua MiniSessions.select('delete')"),
    "Delete session"
)
keyutils.nmap(
    "<leader>sl",
    keyutils.cmd("lua MiniSessions.select()"),
    "Load session"
)
keyutils.nmap(
    "<leader>ss",
    keyutils.cmd("lua require('plugins.mini.sessions').save()"),
    "Save session"
)
keyutils.nmap(
    "<leader>so",
    keyutils.cmd("lua MiniSessions.select('write')"),
    "Overwrite session"
)

keyutils.nmap(
    "<leader>ee",
    keyutils.cmd("lua require('mini.files').open(vim.uv.cwd())"),
    "Open file explorer (cwd)"
)

keyutils.nmap(
    "<leader>ef",
    keyutils.cmd("lua MiniFiles.open(vim.api.nvim_buf_get_name(0))"),
    "Open file explorer (buffer)"
)

keyutils.nmap(
    "<leader>bd",
    keyutils.cmd("lua require('mini.bufremove').delete()"),
    "Delete current buffer"
)

keyutils.nmap(
    "<leader>bD",
    keyutils.cmd('%bdelete|edit #|normal`"'),
    "Delete other buffers"
)

keyutils.nmap(
    "<leader>dc",
    keyutils.cmd("lua require('dap').continue()"),
    "Continue (Start)"
)

keyutils.nmap(
    "<leader>db",
    keyutils.cmd("lua require('dap').toggle_breakpoint()"),
    "Toggle Breakpoint"
)

keyutils.nmap(
    "<leader>dB",
    keyutils.cmd("lua require('dap').clear_breakpoints()"),
    "Clear Breakpoints"
)

keyutils.nmap(
    "<leader>dn",
    keyutils.cmd("lua require('dap').step_over()"),
    "Step Over"
)

keyutils.nmap(
    "<leader>di",
    keyutils.cmd("lua require('dap').step_into()"),
    "Step Into"
)

keyutils.nmap(
    "<leader>do",
    keyutils.cmd("lua require('dap').step_out()"),
    "Step Out"
)

keyutils.nmap(
    "<leader>dt",
    keyutils.cmd("lua require('dap').terminate()"),
    "Stop/Kill"
)

keyutils.nmap(
    "<leader>dr",
    keyutils.cmd("lua require('dap').run_last()"),
    "Rerun Last Config"
)

keyutils.nmap(
    "<leader>dR",
    keyutils.cmd("lua require('dap').restart()"),
    "Restart"
)

keyutils.nmap(
    "<leader>dh",
    keyutils.cmd("lua require('dap.ui.widgets').hover()"),
    "Evaluate (Floating Window)"
)

keyutils.nmap(
    "<leader>dp",
    keyutils.cmd("lua require('dap.ui.widgets').preview()"),
    "Evaluate (Preview)"
)

keyutils.nmap(
    "<leader>ds",
    keyutils.cmd(
        "lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)"
    ),
    "View Scope (Floating Window)"
)

keyutils.nmap(
    "<leader>df",
    keyutils.cmd(
        "lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)"
    ),
    "View Frames (Floating Window)"
)

keyutils.nmap(
    "<leader>tr",
    keyutils.cmd("lua require('neotest').run.run(vim.fn.expand('%'))"),
    "Run File"
)

keyutils.nmap(
    "<leader>tn",
    keyutils.cmd("lua require('neotest').run.run()"),
    "Run Nearest"
)

keyutils.nmap(
    "<leader>td",
    keyutils.cmd("lua require('neotest').run.run({strategy = 'dap'})"),
    "Debug Nearest"
)

keyutils.nmap(
    "<leader>to",
    keyutils.cmd(
        "lua require('neotest').output.open({ enter = true, last_run = true, auto_close = true})"
    ),
    "Open Output (Last Run)"
)

keyutils.nmap(
    "<leader>ts",
    keyutils.cmd("lua require('neotest').summary.toggle()"),
    "Toggle Summary"
)

-- Find mappings
keyutils.nmap("<leader>ff", keyutils.cmd("Pick files"), "Find files")

keyutils.nmap("<leader>fb", keyutils.cmd("Pick buffers"), "Find buffers")

keyutils.nmap("<leader>fh", keyutils.cmd("Pick help"), "Find help")

keyutils.nmap("<leader>fH", keyutils.cmd("Pick history"), "Find history")

keyutils.nmap("<leader>ff", keyutils.cmd("Pick files"), "Find files")

keyutils.nmap('<leader>f"', keyutils.cmd("Pick registers"), "Find registers")

keyutils.nmap("<leader>fc", keyutils.cmd("Pick commands"), "Find commands")

keyutils.nmap(
    "<leader>fg",
    keyutils.cmd("Pick grep_live"),
    "Find pattern (live)"
)

keyutils.nmap(
    "<leader>fd",
    keyutils.cmd("Pick diagnostic scope='current'"),
    "Find diagnostic (buffer)"
)

keyutils.nmap(
    "<leader>fD",
    keyutils.cmd("Pick diagnostic"),
    "Find diagnostic (all)"
)

keyutils.nmap(
    "<leader>fl",
    keyutils.cmd("Pick buf_lines"),
    "Find line (buffer)"
)

keyutils.nmap("<leader>fR", keyutils.cmd("Pick resume"), "Resume Find")
keyutils.nmap(
    "<leader>ft",
    keyutils.cmd("Pick treesitter"),
    "Find Treesitter objects"
)
keyutils.nmap("<leader>fr", keyutils.cmd("Pick oldfiles"), "Find recent files")

keyutils.nmap("<leader>fo", keyutils.cmd("Pick options"), "Find options")

keyutils.nmap(
    "z=",
    keyutils.cmd("Pick spellsuggest"),
    "Show spelling suggestions"
)

keyutils.nmap("<leader>fm", keyutils.cmd("Pick marks"), "Find marks")
keyutils.nmap("<leader>fk", keyutils.cmd("Pick keymaps"), "Find keymaps")
keyutils.nmap("<leader>gff", keyutils.cmd("Pick git_files"), "Find git files")
keyutils.nmap(
    "<leader>gfd",
    keyutils.cmd("Pick git_files scope='deleted'"),
    "Find deleted files"
)
keyutils.nmap(
    "<leader>gfi",
    keyutils.cmd("Pick git_files scope='ignored'"),
    "Find ignored files"
)
keyutils.nmap(
    "<leader>gfu",
    keyutils.cmd("Pick git_files scope='untracked'"),
    "Find untracked files"
)
keyutils.nmap(
    "<leader>gfm",
    keyutils.cmd("Pick git_files scope='modified'"),
    "Find modified files"
)
