# Themelume.nvim

**Themelume** is a Neovim plugin that allows users to manage their colorschemes with ease. It integrates with Telescope for selecting themes and provides an option to toggle transparency for the background.

---

## Features
- Select colorschemes using Telescope.
- Enable or disable transparency for the background.
- Customize the sorting order of colorschemes.
- Lazy-load and organize themes effortlessly.

---

## Installation

Using `lazy.nvim`:

```lua
return {
    {
        "gabref/themelume.nvim",
        config = function()
            require('themelume').setup({
                colorschemes = {
                    { name = "tokyonight" },
                    { name = "gruvbox" },
                    { name = "catppuccin" },
                },
                default_colorscheme = "tokyonight",
                transparency_enabled = true,
                keymap = "<leader>t",
            })
        end
    }
}
```

---

## Usage

To open the colorscheme picker, run:

```vim
:ThemelumePicker
```

### Keybindings
- `<CR>`: Apply the selected colorscheme and choose whether to enable transparency.
- `<C-j>` / `j`: Preview the next colorscheme.
- `<C-k>` / `k`: Preview the previous colorscheme.

---

## Configuration

Configure Themelume in your Neovim setup:

```lua
require('themelume').setup({
    colorschemes = {
        { name = "tokyonight" },
        { name = "gruvbox" },
        { name = "catppuccin" },
    },
    default_colorscheme = "tokyonight",
    transparency_enabled = true,
    push_to_bottom = { "rose-pine", "kanagawa-lotus" },
    keymap = "<leader>t",
    theme = "dropdown",
})
```

### Options

| Option                 | Type                  | Default       | Description                                                                 |
|------------------------|-----------------------|---------------|-----------------------------------------------------------------------------|
| `colorschemes`         | `table`              | `{}`          | List of colorschemes with `name` fields. Lazy-loads themes if specified.   |
| `default_colorscheme`  | `string`             | `'rose-pine'` | The colorscheme to load by default.                                        |
| `transparency_enabled` | `boolean`            | `false`       | Whether transparency is enabled by default and during theme selection.     |
| `push_to_bottom`       | `table`              | `{}`          | Colorschemes to prioritize at the end of the list.                         |
| `keymap`               | `string`             | `"<leader>t"` | Keybinding to open the picker.                                             |
| `theme`                | `'ivy' | 'dropdown' | 'cursor'` | `'dropdown'` | Telescope theme for the picker.                                            |

---

## Dependencies

- [`Telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim)
- [`nvim-transparent`](https://github.com/xiyaowong/nvim-transparent) (optional for transparency management)

---

## Example Configuration

```lua
local colorschemes = {
	{ "folke/tokyonight.nvim",            lazy = true, name = "tokyonight" },
	{ "ellisonleao/gruvbox.nvim",         lazy = true, name = "gruvbox" },
	{ "craftzdog/solarized-osaka.nvim",   lazy = true, name = "solarized-osaka" },
	{ "rebelot/kanagawa.nvim",            lazy = true, name = "kanagawa" },
	{ "rose-pine/neovim",                 lazy = true, name = "rose-pine" },
	{ "catppuccin/nvim",                  lazy = true, name = "catppuccin" },
}

return {
    {
        "gabref/themelume.nvim",
        config = function()
            require('themelume').setup({
                colorschemes = colorschemes, -- this is for passing your colorschemes to Themelume to load them, if you already load them before, no need for this.
                default_colorscheme = "tokyonight",
                transparency_enabled = true, -- default transparency config for opening and for preview themes
                push_to_bottom = { "rose-pine", "kanagawa-lotus" }, -- least likes themes to be put at the bottom of the list
                keymap = "<leader>t",
                theme = "dropdown",
            })
        end
    },
    colorschemes, -- this is your normal installation for your colorschemes
}
```

---

## Credits

**Themelume.nvim** was created by [gabref](https://github.com/gabref).

Inspired by Neovim's vibrant plugin ecosystem and the desire for better colorscheme management.
