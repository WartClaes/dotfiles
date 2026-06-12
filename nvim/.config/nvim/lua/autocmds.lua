-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Disable native autocomplete in special buffers (telescope prompts, quickfix, etc.)
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.buftype ~= '' then
      vim.opt_local.autocomplete = false
    end
  end,
})

-- Set filetype to jsonc for some files
local jsonFileTypeDetect = vim.api.nvim_create_augroup('jsonFtDetect', { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "tsconfig*.json", ".eslintrc.json" },
    group = jsonFileTypeDetect,
    callback = function(ev)
        vim.api.nvim_buf_call(ev.buf, function()
            vim.api.nvim_cmd({ cmd = 'setf', args = { 'jsonc' } }, {})
        end)
    end,
})
