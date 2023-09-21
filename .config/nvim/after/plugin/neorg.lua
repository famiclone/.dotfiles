require("neorg").setup {
  load = {
    ["core.keybinds"] = {
      config = {

        hook = function(keybinds)
          keybinds.remap_key("norg", "n", "<C-Space>", "ntd")
          keybinds.map("norg", "n", "ni", "<cmd>'Neorg index'<CR>")
        end
      }
    },
    ["core.defaults"] = {}, -- Loads default behaviour
    ["core.concealer"] = {
      config = {
        icons = {
          todo = {
            uncertain = {
              icon = "?"
            },
            done = {
              icon = "x"
            },
            undone = {
              icon = " "
            }
          }
        }
      }
    },
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          notes = "~/Library/Mobile Documents/com~apple~CloudDocs/notes",
        },
        default_workspace = "notes",
        index = "index.norg",
      },
    },
  },
}
