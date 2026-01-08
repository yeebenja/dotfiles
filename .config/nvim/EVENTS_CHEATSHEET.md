# Neovim Lazy.nvim Events Cheat Sheet

## Startup Events (in order)

### `VimEnter`
- **When**: After all initialization is done, including reading vimrc files
- **Use for**: Plugins that need Neovim to be fully initialized
- **Examples**: telescope.nvim, todo-comments.nvim, which-key.nvim

### `start`
- **When**: Plugin loaded at startup (lazy=false equivalent)
- **Use for**: Essential plugins needed immediately
- **Examples**: lualine.nvim, oil.nvim, leap.nvim, snacks.nvim

### `VeryLazy`
- **When**: After startup, during idle time (less aggressive than VimEnter)
- **Use for**: Non-critical UI enhancements that can wait
- **Examples**: image.nvim, tiny-inline-diagnostic.nvim, visimatch.nvim

## Buffer/File Events

### `BufReadPre`
- **When**: Before reading a buffer into memory
- **Use for**: Plugins that need to prepare before file content loads
- **Examples**: mini.nvim, git-conflict.nvim, gitsigns.nvim, nvim-ts-autotag

### `BufReadPost`
- **When**: After reading a buffer into memory
- **Use for**: Plugins that process file content
- **Examples**: Comment.nvim

## Insert Mode Events

### `InsertEnter`
- **When**: When entering insert mode
- **Use for**: Completion engines, snippet plugins, autopairs
- **Examples**: LuaSnip, nvim-autopairs

## Filetype Events

### `lua`
- **When**: When opening Lua files
- **Use for**: Lua-specific tooling
- **Examples**: lazydev.nvim

### Custom colorscheme event
- **Example**: `colorscheme eldritch` - triggers when that colorscheme loads

## Plugin Dependencies

These aren't events but lazy-load triggers based on other plugins:

- `nvim-lspconfig` - loads when LSP config is needed
- `blink.cmp` - loads when completion is needed
- `neogit` - loads when Git interface is opened
- `telescope.nvim` - loads when fuzzy finder is triggered

## Event Selection Guide

**Load immediately** → `start` or `lazy=false`
- Core UI (statusline, file explorer)
- Navigation plugins

**Load at vim start** → `VimEnter`
- UI that can wait slightly
- Global keybinding managers

**Load when editing** → `BufReadPre` or `BufReadPost`
- Syntax, LSP, linting, formatting
- Git integration

**Load when typing** → `InsertEnter`
- Completion, snippets, autopairs

**Load lazily** → `VeryLazy`
- Nice-to-have features
- Visual enhancements

**Load on demand** → Plugin dependencies or commands
- Heavy plugins like DAP, Git clients
- Specialized tools
