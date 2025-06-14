return {
    {
        'milanglacier/minuet-ai.nvim',
        config = function()
            require('minuet').setup {
                -- Your configuration options here
                provider = "openai"
            }
        end,
    },
    { 'nvim-lua/plenary.nvim' },
    -- optional, if you are using virtual-text frontend, nvim-cmp is not
    -- required.
    { 'hrsh7th/nvim-cmp' },
    -- optional, if you are using virtual-text frontend, blink is not required.
    { 'Saghen/blink.cmp' },
    config = function()
        require('blink-cmp').setup {
            keymap = {
                -- Manually invoke minuet completion.
                ['<A-y>'] = require('minuet').make_blink_map(),
            },
            sources = {
                -- Enable minuet for autocomplete
                default = { 'lsp', 'path', 'buffer', 'snippets', 'minuet' },
                -- For manual completion only, remove 'minuet' from default
                providers = {
                    minuet = {
                        name = 'minuet',
                        module = 'minuet.blink',
                        async = true,
                        -- Should match minuet.config.request_timeout * 1000,
                        -- since minuet.config.request_timeout is in seconds
                        timeout_ms = 3000,
                        score_offset = 50, -- Gives minuet higher priority among suggestions
                    },
                },
            },
            -- Recommended to avoid unnecessary request
            completion = { trigger = { prefetch_on_insert = false } },
        }
        require('lualine').setup {
            sections = {
                lualine_x = {
                    {
                        require 'minuet.lualine',
                        -- the follwing is the default configuration
                        -- the name displayed in the lualine. Set to "provider", "model" or "both"
                        -- display_name = 'both',
                        -- separator between provider and model name for option "both"
                        -- provider_model_separator = ':',
                        -- whether show display_name when no completion requests are active
                        -- display_on_idle = false,
                    },
                    'encoding',
                    'fileformat',
                    'filetype',
                },
            },
        }
    end
}
