local git_branch = "no git"

local function exec_cmd(cmd)
    local h = io.popen(cmd)
    local res = h:read("*a")
    h:close()

    return res
end

local function get_git_branch()
    local is_git_dir = exec_cmd("git rev-parse --is-inside-work-tree 2>/dev/null")

    -- Обрізаємо новий рядок з кінця виводу команди
    is_git_dir = is_git_dir:gsub("\n", "")

    if is_git_dir == "true" then
        git_branch = exec_cmd("git branch --show-current")
        git_branch = git_branch:gsub("\n", "") -- Видаляємо символ нового рядка з кінця рядка
        return git_branch
    else
        return "no git"
    end
end

function RenderStatusline()
    vim.opt.laststatus = 3                -- Show single statusline for all windows
    vim.cmd([[
        set noshowmode
    ]])
    local current_mode = vim.fn.mode()
    local current_filetype = vim.bo.filetype
    local current_file = vim.fn.expand("%:t")

    local function get_statusline_mode()
        local mode = {
            n = "%#StatusLineMode1#" .. " N ",
            i = "%#StatusLineMode2#" .. " I ",
            c = "%#StatusLineMode3#" .. " C ",
            v = "%#StatusLineMode4#" .. " V ",
            V = "%#StatusLineMode4#" .. " V ",
            [""] = "%#StatusLineMode4#" .. " V ",
        }

        return mode[current_mode]
    end

    local function get_statusline_branch()
        return "%#StatusLineGitBranch#" .. string.format("  %s ", get_git_branch()) .. "%#StatusLineArrow#" .. ""
    end

    local function get_statusline_filetype()
        local icons = {
            lua = "",
            typescript = "󰛦",
            typescriptreact = "󰜈",
            javascript = "",
            javascriptreact = "󰜈",
            python = "",
            sh = "",
            rust = "",
            html = "",
            css = "",
            c = "",
            txt = "",
            markdown = "",
            vim = "",
        }

        local icon = icons[current_filetype] or "%#StatusLineFileType# "

        return string.format("%s  %s ",icon, current_filetype)
    end

    local function separator(len)
        return string.rep(" ", len)
    end
    
    return table.concat({
        get_statusline_mode(),
        --get_statusline_branch(),
        "%#StatusLineFileName#",
        separator(1),
        current_file,
        "%=",
        get_statusline_filetype(),
    })
end

vim.o.statusline = "%!v:lua.RenderStatusline()"
