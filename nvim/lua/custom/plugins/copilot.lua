--vim.g.copilot_assume_mapped = true;

return {
    {
        "zbirenbaum/copilot.lua",
        event = "BufEnter",
        config= {
            suggestion = {
                auto_trigger = true
            }
        }
    },
}

