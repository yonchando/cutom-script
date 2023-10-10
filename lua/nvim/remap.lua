-- Save
vim.keymap.set("n", "<c-s>", vim.cmd.wa, { desc = "Save all" })
vim.keymap.set("n", "<leader>q", vim.cmd.wqa, { desc = "Save all" })

-- BufferDelete
vim.keymap.set("n", "<M-w>", vim.cmd.Bdelete, { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>cb", vim.cmd.Bdelete, { desc = "Close Current Buffer" })
vim.keymap.set("n", "<leader>cl", vim.cmd.BufferLineCloseLeft, { desc = "Close all left buffer" })
vim.keymap.set("n", "<leader>cr", vim.cmd.BufferLineCloseRight, { desc = "Close all right buffer" })
vim.keymap.set("n", "<leader>co", vim.cmd.BufferLineCloseOthers, { desc = "Close others" })

-- Bufferline
local goTo = {}
goTo.tab = function(tabIndex)
    return function()
        vim.cmd("BufferLineGoToBuffer " .. tabIndex)
    end
end
vim.keymap.set("n", '<leader>1', goTo.tab(1), { desc = "Go to tab 1" })
vim.keymap.set("n", '<leader>2', goTo.tab(2), { desc = "Go to tab 2" })
vim.keymap.set("n", '<leader>3', goTo.tab(3), { desc = "Go to tab 3" })
vim.keymap.set("n", '<leader>4', goTo.tab(4), { desc = "Go to tab 4" })
vim.keymap.set("n", '<leader>5', goTo.tab(5), { desc = "Go to tab 5" })
vim.keymap.set("n", "<leader>`", vim.cmd.BufferLinePick, { desc = "Buffer pick tab" })

-- Nvim Tree
local nvimtree = function()
    local api = require("nvim-tree.api")
    local tree = api.tree

    if tree.is_tree_buf() then
        tree.close()
    else
        tree.open()
    end
end
vim.keymap.set("n", "<M-1>", nvimtree, { desc = "NvimTreeToggle" })
vim.keymap.set("n", "<leader><tab>", nvimtree, { desc = "NvimTreeToggle" })

-- Split Screen
vim.keymap.set("n", "<leader>sp", vim.cmd.sp, { desc = "[Sp]lit Screen" })
vim.keymap.set("n", "<leader>vsp", vim.cmd.vs, { desc = "[Sp]lit Screen" })
vim.keymap.set("n", "<tab>", vim.cmd.w, { desc = "[Sp]lit Screen" })

-- General Config
vim.keymap.set("n", "<leader>/", vim.cmd.nohlsearch, { desc = "No search highlight" })
vim.keymap.set({ "n", "v" }, "L", "e", { desc = "Next word at end of word" })
vim.keymap.set({ "n", "v" }, "H", "b", { desc = "Back word at start of word" })
vim.keymap.set({ "n", "v" }, "J", "3j", { desc = "Move coursor down 3 line" })
vim.keymap.set({ "n", "v" }, "K", "3k", { desc = "Move coursor up 3 line" })

-- Yank and Paste with key store
vim.keymap.set("n", "<leader>pa", '"ap', { desc = "Paste text store in char a" })
vim.keymap.set("n", "<leader>ps", '"sp', { desc = "Paste text store in char s" })
vim.keymap.set("n", "<leader>pd", '"dp', { desc = "Paste text store in char d" })

vim.keymap.set("v", "<leader>ya", '"ay', { desc = "Yank text in char a" })
vim.keymap.set("v", "<leader>ys", '"sy', { desc = "Yank text in char s" })
vim.keymap.set("v", "<leader>yd", '"dy', { desc = "Yank text in char d" })

-- vim dianostic
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Diagnostic open float" })
vim.keymap.set('n', '<leader>din', vim.diagnostic.goto_prev, { desc = "Go to prev Diagnostic" })
vim.keymap.set('n', '<leader>dip', vim.diagnostic.goto_next, { desc = "Go to next Diagnostic" })

-- Easy motion
vim.keymap.set('n', "<leader>jj", "<Plug>(easymotion-sn)", { desc = "Easy motion search n word" })

-- prettier
vim.keymap.set("n","<leader>pt", vim.cmd.Prettier, {desc = "Prettier format"})
