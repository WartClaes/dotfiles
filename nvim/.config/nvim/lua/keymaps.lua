local utils = require('utils')

utils.map('n', '<C-s>', ':w<CR>', { desc = 'Save', silent = true })
utils.map('t', '<Esc>', '<C-\\><C-N>', { desc = "Exit Terminal mode", silent = true })

utils.map('n', '<leader>|', ':vsplit<CR>', { desc = 'Vertical split', silent = true })
utils.map('n', '<leader>-', ':split<CR>', { desc = 'Horizontal split', silent = true })

-- better scrolling
utils.map('n', "<C-u>", "<C-u>zz")
utils.map('n', "<C-d>", "<C-d>zz")
utils.map('n', "<C-f>", "<C-f>zz")
utils.map('n', "<C-b>", "<C-b>zz")
utils.map("n", "n", "nzzzv")
utils.map("n", "N", "Nzzzv")

-- Move lines up/down
utils.map('v', 'K', ":m '<-2<CR>gv=gv")
utils.map('v', 'J', ":m '>+1<CR>gv=gv")

-- Visual select last pasted value
utils.map('n', 'gp', '`[v`]', { desc = 'Select last paste' })

-- Black hole register
utils.map('x', '<leader>p', [["_dP]])
utils.map({ 'n', 'v' }, '<leader>d', [["_d]])

-- setup mapping to call :LazyGit
utils.map('n', '<leader>gg', ':LazyGit<CR>');

-- Eslint
utils.map('n', 'E', ':EslintFixAll<CR>')

-- Float term
-- utils.map('n', '<leader><Esc>', ':FTermOpen<CR>');
-- utils.map('t', '<leader><Esc>', '<C-\\><C-n>:FTermClose<CR>');
-- utils.map('n', '<leader>fte', ':FTermExit<CR>');
-- utils.map('n', '<leader><Esc>', ':FTermToggle<CR>');
-- utils.map('n', '<leader>ftc', ':FTermClose<CR>');
-- utils.map('t', '<C-q>', '<C-\\><C-n>:FTermExit<CR>');

-- Keys -- disable
utils.map('n', '<Left>', ':echo "No left for you!"<CR>');
utils.map('n', '<Right>', ':echo "No right for you!"<CR>');
utils.map('n', '<Down>', ':echo "No down for you!"<CR>');
utils.map('n', '<Up>', ':echo "No up for you!"<CR>');

utils.map('i', '<Left>', ':echo "No left for you!"<CR>');
utils.map('i', '<Right>', ':echo "No right for you!"<CR>');
utils.map('i', '<Down>', ':echo "No down for you!"<CR>');
utils.map('i', '<Up>', ':echo "No up for you!"<CR>');

utils.map('v', '<Left>', ':echo "No left for you!"<CR>');
utils.map('v', '<Right>', ':echo "No right for you!"<CR>');
utils.map('v', '<Down>', ':echo "No down for you!"<CR>');
utils.map('v', '<Up>', ':echo "No up for you!"<CR>');
