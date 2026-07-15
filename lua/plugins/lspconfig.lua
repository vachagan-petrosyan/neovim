-- lua/plugins/lspconfig.lua
-- LSP setup: nvim-lspconfig provides per-server configs; core Neovim
-- (vim.lsp) is the actual client. Server binaries come from Mason
-- (lua_ls, pyright), apt (clangd), and npm (devicetree-language-server).

-- ========================================================================
-- Step 1: per-server settings overrides — must come BEFORE enable.
-- vim.lsp.config(name, {...}) merges with nvim-lspconfig's defaults.
-- ========================================================================

-- lua_ls: understand the Neovim runtime and the `vim` global
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- ------------------------------------------------------------------------
-- dts_lsp: devicetree-language-server with Zephyr defaults
-- (adapted from the server author's LazyVim example to native vim.lsp.config)
-- ------------------------------------------------------------------------

-- Zephyr location: prefer $ZEPHYR_BASE if exported, fall back to the
-- known workspace layout. Derive the modules dir from it.
local zephyr_base = vim.env.ZEPHYR_BASE
    or vim.fs.normalize("~/projects/turing/workspace/toolchain/zephyr-rtos/zephyr")
local zephyr_modules = vim.fs.normalize(zephyr_base .. "/../modules")

local dts_capabilities = vim.lsp.protocol.make_client_capabilities()
dts_capabilities.textDocument.semanticTokens = {
  dynamicRegistration = false,
  requests = { range = false, full = true },
  tokenTypes = {
    "namespace", "class", "enum", "interface", "struct", "typeParameter", "type",
    "parameter", "variable", "property", "enumMember", "decorator", "event", "function",
    "method", "macro", "label", "comment", "string", "keyword", "number", "regexp", "operator",
  },
  tokenModifiers = {
    "declaration", "definition", "readonly", "static", "deprecated", "abstract",
    "async", "modification", "documentation", "defaultLibrary",
  },
  formats = { "relative" },
}
dts_capabilities.textDocument.formatting = { dynamicRegistration = false }
dts_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

vim.lsp.config("dts_lsp", {
  cmd = { "devicetree-language-server", "--stdio" },
  filetypes = { "dts" },
  root_markers = { "west.yml", ".west", ".git" },
  capabilities = dts_capabilities,
  settings = {
    devicetree = {
      cwd = "${workspaceFolder}",
      defaultIncludePaths = {
        zephyr_base .. "/dts",
        zephyr_base .. "/dts/riscv",     -- PolarFire u54 arch
        zephyr_base .. "/dts/common",
        zephyr_base .. "/dts/vendor",
        zephyr_base .. "/include",
        -- Microchip HAL (paths from build_info.yml):
        zephyr_modules .. "/hal/microchip/include",
        zephyr_modules .. "/hal/microchip/dts",
      },
      defaultBindingType = "Zephyr",
      defaultZephyrBindings = { zephyr_base .. "/dts/bindings" },
      autoChangeContext = true,
      allowAdhocContexts = true,
      contexts = {},
    },
  },
})

-- ========================================================================
-- Step 2: enable servers — AFTER configs.
-- Only servers whose binary is installed will start.
-- ========================================================================
vim.lsp.enable({
  "lua_ls",     -- lua-language-server  (for this config itself)
  "pyright",    -- python
  "clangd",     -- c/c++
  "dts_lsp",    -- devicetree (zephyr dts, dtsi, overlay)
})

-- ========================================================================
-- Step 3: keymaps — buffer-local, created only when a server attaches.
-- Also: one-time debug notification when dts_lsp attaches, showing the
-- root dir and whether settings reached the client. Remove when stable.
-- ========================================================================
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(args)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")

    -- debug aid for dts_lsp (safe to delete once everything works)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "dts_lsp" then
      local has_settings = client.config.settings
        and client.config.settings.devicetree ~= nil
      vim.notify(("dts_lsp attached | root: %s | settings: %s"):format(
        client.root_dir or "?", has_settings and "yes" or "MISSING"))
    end
  end,
})

-- ========================================================================
-- Step 4: diagnostics appearance & navigation
-- ========================================================================
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.INFO]  = "I",
      [vim.diagnostic.severity.HINT]  = "H",
    },
  },
})
