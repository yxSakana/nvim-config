
return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local colorscheme = require("helpers.colorscheme")
            local lunline_theme = colorscheme == "default" and "auto" or colorscheme
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = lualine_theme,
                    component_separators = "|",
                    section_separators = "",
                }
            })
        end,
        -- enabled = false
    }, 
}
