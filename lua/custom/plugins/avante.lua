return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = 'openai',
    providers = {
      openai = {
        endpoint = 'http://localhost:11211/api/openai/v1',
        model = 'aws:anthropic.claude-sonnet-4-20250514-v1:0', -- your desired model (or use gpt-4o, etc.)
        extra_request_body = {
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0.75,
          max_completion_tokens = 16000, -- Increase this to include reasoning tokens (for reasoning models)
          reasoning_effort = 'high', -- low|medium|high, only used for reasoning models
          max_tokens = 20480,
        },
      },
    },
    -- web_search_engine = {
    --   provider = 'searxng',
    --   proxy = nil,
    -- },
    rag_service = { -- RAG Service configuration
      enabled = false, -- Enables the RAG service
      host_mount = os.getenv 'HOME', -- Host mount path for the rag service (Docker will mount this path)
      runner = 'docker', -- Runner for the RAG service (can use docker or nix)
      llm = { -- Language Model (LLM) configuration for RAG service
        provider = 'ollama', -- LLM provider
        endpoint = 'http://host.docker.internal:11434', -- The LLM API endpoint for Ollama
        api_key = '', -- Environment variable name for the LLM API key
        model = 'llama3.2', -- LLM model name
        extra = nil, -- Additional configuration options for LLM
      },
      embed = { -- Embedding model configuration for RAG service
        provider = 'ollama', -- embedding provider
        endpoint = 'http://host.docker.internal:11434', -- The Embedding API endpoint for Ollama
        api_key = '', -- Environment variable name for the embedding API key
        model = 'nomic-embed-text', -- Embedding model name
        extra = {
          embed_batch_size = 10,
        }, -- Additional configuration options for the embedding model
      },
      docker_extra_args = '', -- Extra arguments to pass to the docker command
    }, -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  },
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'stevearc/dressing.nvim', -- for input provider dressing
    'folke/snacks.nvim', -- for input provider snacks
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
