{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.development.editor.nvf;

  dag = inputs.nvf.lib.nvim.dag;
  mkLua = lib.generators.mkLuaInline;

  mkKey = mode: key: action: desc: {
    inherit mode key action desc;
    silent = true;
    noremap = true;
  };

  mkExprKey = mode: key: action: desc:
    (mkKey mode key action desc) // {expr = true;};

  mkLuaKey = mode: key: action: desc:
    (mkKey mode key action desc) // {lua = true;};

  mkExprLuaKey = mode: key: action: desc:
    (mkLuaKey mode key action desc) // {expr = true;};

  mapKeys = mode: prefix: mappings:
    mapAttrsToList (
      key: val: let
        func =
          if val.lua or false
          then mkLuaKey
          else mkKey;
      in
        func mode "${prefix}${key}" val.action val.desc
    )
    mappings;

  smartCloseLua = ''
    function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      local non_floating_wins = 0
      for _, win in ipairs(wins) do
        local cfg = vim.api.nvim_win_get_config(win)
        if not cfg.relative or cfg.relative == "" then
          non_floating_wins = non_floating_wins + 1
        end
      end

      if non_floating_wins > 1 then
        vim.cmd "close"
      else
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        if #bufs > 1 then
          vim.cmd "bdelete"
        else
          vim.cmd "quit"
        end
      end
    end
  '';
in {
  imports = [inputs.nvf.nixosModules.default];

  options.modules.development.editor.nvf = {
    enable = mkEnableOption "Whether to enable NVF";
  };

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings.vim = {
        extraPackages = [pkgs.ripgrep];

        # --- Core Options ---
        lineNumberMode = "relNumber";
        enableLuaLoader = true;
        syntaxHighlighting = true;
        viAlias = true;
        vimAlias = true;
        preventJunkFiles = true;

        clipboard = {
          enable = true;
          providers.wl-copy.enable = config.modules.desktop.type == "wayland";
          registers = "unnamedplus";
        };

        undoFile = {
          enable = true;
          path = "${config.home.fakeDir}/nvf/undo";
        };

        options = {
          autoindent = true;
          cmdheight = 1;
          shiftwidth = 4;
          signcolumn = "yes";
          splitbelow = true;
          splitright = true;
          tabstop = 4;
          tm = 300;
          updatetime = 200;
          wrap = false;
        };

        luaConfigRC.load_options = dag.entryAfter ["optionScript"] ''
          local opts = {
            autoread = true,
            autowrite = true,
            backspace = "indent,eol,start",
            backup = false,
            breakat = [[\ \	;:,!?]],
            breakindentopt = "shift:2,min:20",
            cmdwinheight = 5,
            complete = ".,w,b,k",
            completeopt = "menuone,noselect",
            concealcursor = "niv",
            conceallevel = 0,
            diffopt = "filler,iwhite,internal,linematch:60,algorithm:patience",
            display = "lastline",
            encoding = "utf-8",
            equalalways = false,
            fileformats = "unix,mac,dos",
            foldenable = true,
            foldmethod = "expr",
            foldexpr = "v:lua.vim.treesitter.foldexpr()",
            foldlevelstart = 99,
            formatoptions = "1jcroql",
            guicursor = "n-v-c-sm:block-blinkon500,i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250,r-cr-o:hor20-blinkon500",
            helpheight = 12,
            ignorecase = true,
            inccommand = "nosplit",
            incsearch = true,
            infercase = true,
            jumpoptions = "stack",
            laststatus = 3,
            linebreak = true,
            list = true,
            listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
            magic = true,
            mousescroll = "ver:3,hor:6",
            previewheight = 12,
            pumblend = 0,
            pumheight = 15,
            redrawtime = 1500,
            ruler = true,
            scrolloff = 10,
            sessionoptions = "buffers,curdir,folds,help,tabpages,winpos,winsize",
            shiftround = true,
            shortmess = "aoOTIcF",
            showbreak = "↳  ",
            showcmd = false,
            showmode = false,
            sidescrolloff = 5,
            smartcase = true,
            smarttab = true,
            splitkeep = "screen",
            startofline = false,
            swapfile = false,
            switchbuf = "usetab,uselast",
            synmaxcol = 2500,
            timeout = true,
            ttimeout = true,
            ttimeoutlen = 0,
            viewoptions = "folds,cursor,curdir,slash,unix",
            virtualedit = "block",
            whichwrap = "h,l,<,>,[,],~",
            wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
            wildignorecase = true,
            winminwidth = 10,
            winwidth = 30,
            wrapscan = true,
            writebackup = false,
          }
          for name, value in pairs(opts) do
            vim.opt[name] = value
          end
        '';

        # --- LSP & Languages ---
        lsp = {
          enable = true;
          inlayHints.enable = true;
          trouble.enable = true;

          harper-ls = {
            enable = true;
            settings = {
              diagnosticSeverity = "hint";
              dialect = "American";
              userDictPath = "${config.home.fakeDir}/nvf/dict.utf-8.add";
              linters = {
                SpellCheck = true;
                SentenceCapitalization = false;
                unclosed_quotes = true;
                PossessiveNoun = true;
                wrong_quotes = false;
                an_a = true;
              };
              markdown.IgnoreLinkTitle = false;
              maxFileLength = 100000;
            };
          };
          otter-nvim.enable = true;

          mappings = {
            addWorkspaceFolder = "<leader>lwa";
            codeAction = "<leader>ca";
            format = "<leader>lf";
            goToDeclaration = "gD";
            goToType = "gt";
            hover = "gh";
            nextDiagnostic = ",]";
            previousDiagnostic = ",[";
          };

          servers.basedpyright = {
            enable = true;
            filetypes = ["python"];
            root_markers = [".envrc" "src/" "pyproject.toml" "setup.py" ".git" ".venv"];
            setupOpts.basedpyright.settings.basedpyright.analysis = {
              autoSearchPaths = true;
              useLibraryCodeForTypes = true;
              diagnosticMode = "openFilesOnly";
            };
          };
        };

        languages = {
          enableDAP = true;
          enableFormat = true;
          enableTreesitter = true;

          assembly.enable = true;
          bash.enable = true;
          clang.enable = true;
          dart.enable = true;
          java.enable = true;
          json.enable = true;
          lua.enable = true;
          markdown.enable = true;
          markdown.extensions.render-markdown-nvim.enable = true;
          nix.enable = true;
          nu.enable = config.modules.desktop.terminal.shell == "nushell";
          sql.enable = true;
          toml.enable = true;
          typst.enable = true;
          typst.extensions.typst-preview-nvim.enable = true;
          yaml.enable = true;
          python = {
            enable = true;
            format.type = ["ruff"];
            lsp.servers = ["basedpyright" "ruff"];
          };
        };
        withPython3 = true;

        # --- UI & Visuals ---
        theme = {
          enable = true;
          name = "rose-pine";
          style = "moon";
        };

        ui = {
          borders.enable = true;
          modes-nvim.enable = true;
          nvim-ufo.enable = true;
          smartcolumn.enable = true;
          noice = {
            enable = true;
            setupOpts = {
              notify.enable = false; # Handled by snacks
              preset = {
                bottom_search = false;
                inc_rename = true;
                lsp_doc_border = true;
              };
            };
          };
        };

        visuals = {
          hlargs-nvim.enable = true;

          # Fidget strictly for LSP progress
          fidget-nvim = {
            enable = true;
            setupOpts = {
              progress = {
                suppress_on_insert = true;
                display = {
                  done_icon = "󰄬";
                  done_ttl = 1;
                  progress_icon = {
                    pattern = "moon";
                    period = 1;
                  };
                  progress_style = "WarningMsg";
                  done_style = "Constant";
                };
              };
              notification = {
                override_vim_notify = false; # Prevents conflict with Snacks
                window = {
                  border = "rounded";
                  winblend = 0;
                  relative = "editor";
                  align = "bottom";
                };
              };
            };
          };
        };

        # --- Utilities & Tools ---
        debugger.nvim-dap.enable = true;
        binds.whichKey.enable = true;
        git.enable = true;
        git.gitlinker-nvim.enable = false;
        notes.obsidian.enable = true;
        notes.todo-comments.enable = true;
        tabline.nvimBufferline = {
          enable = true;
          setupOpts.options = {
            style_preset = "minimal";
            always_show_bufferline = true;
            show_buffer_close_icons = false;
            show_close_icon = false;

            # Те самые отступы и закругления
            separator_style = "thin"; # Или "slant"
            offsets = [
              {
                filetype = "NvimTree";
                text = "File Explorer";
                text_align = "left";
                separator = true;
              }
            ];
          };
        };

        filetree.nvimTree = {
          enable = true;
          openOnSetup = true;
          setupOpts.view.side = "left";
        };

        telescope = {
          enable = true;
          mappings = {
            findFiles = "<leader>ff";
            buffers = "<leader>fb";
            liveGrep = "<leader>fg";
            gitFiles = "<leader>fG";
            gitCommits = "<leader>gc";
            gitStatus = "<leader>gs";
            helpTags = "<leader>sh";
          };
        };

        utility.snacks-nvim = {
          enable = true;
          setupOpts = {
            dashboard = {
              enabled = true;
              sections = [
                {section = "header";}
                {
                  section = "keys";
                  gap = 1;
                  padding = 1;
                }
                {section = "startup";}
              ];
            };
            notifier = {
              enabled = true;
              style = "fancy";
              top_down = false;
            };
            winbar.enabled = true;
            scroll.enabled = true;
            input.enabled = true;
          };
        };

        # Blink Autocomplete
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          sourcePlugins.ripgrep.enable = true;
          sourcePlugins.emoji.enable = true;
          setupOpts = {
            keymap.preset = "super-tab";
            cmdline.keymap.preset = "cmdline";
            completion = {
              list.selection.preselect = false;
              menu = {
                border = "rounded";
                winblend = 0;
                draw.columns = [
                  ["label" "label_description"]
                  ["kind_icon" "kind"]
                ];
              };
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 250;
                window.border = "rounded";
              };
            };
            fuzzy.implementation = "rust";
            sources.default = ["lsp" "path" "snippets" "buffer" "ripgrep" "emoji"];
          };
        };

        # Mini plugins
        mini = {
          icons.enable = true;
          ai.enable = true;
          comment = {
            enable = true;
            setupOpts.mappings = {
              comment = "";
              comment_line = "";
              comment_visual = "";
            };
          };
          move.enable = true;
          pairs.enable = true;
          operators.enable = true;
          splitjoin.enable = true;
          surround.enable = true;
        };

        utility = {
          smart-splits = let
            directions = {
              left = "h";
              down = "j";
              up = "k";
              right = "l";
            };
            mapSplits = key: action:
              mapAttrs' (k: v: {
                name = "${action}_${k}";
                value = "<${key}-${v}>";
              })
              directions;
          in {
            enable = true;
            keymaps = attrsets.mergeAttrsList [(mapSplits "C" "move_cursor") (mapSplits "A" "resize")];
          };
          yanky-nvim = {
            enable = true;
            setupOpts = {
              highlight.on_put = true;
              highlight.on_yank = true;
              ring.storage = "sqlite";
            };
          };
          undotree.enable = true;
          new-file-template.enable = false;
          motion.flash-nvim = {
            enable = false;
            mappings = {};
          };
        };

        lazy.plugins = {
          "nvim-spider" = {
            package = pkgs.vimPlugins.nvim-spider;
            keys = let
              mkSpiderKey = key:
                mkKey ["n" "o" "x"] key "<cmd>lua require('spider').motion('${key}')<CR>" "Spider-${key}";
            in [(mkSpiderKey "w") (mkSpiderKey "e") (mkSpiderKey "b") (mkSpiderKey "ge")];
          };
          "hlchunk.nvim" = {
            package = pkgs.vimPlugins.hlchunk-nvim;
            event = ["BufReadPre"];
            setupModule = "hlchunk";
            setupOpts = {
              chunk = {
                enable = true;
                use_treesitter = true;
                error_sign = false;
                style = ["#f1f1f1"];
                duration = 150;
                delay = 200;
              };
              indent.enable = true;
            };
          };
          # "vimplugin-undo-glow.nvim" = {
          #   package = pkgs.vimUtils.buildVimPlugin {
          #     name = "undo-glow.nvim";
          #     src = pkgs.fetchFromGitHub {
          #       owner = "y3owk1n";
          #       repo = "undo-glow.nvim";
          #       rev = "25314a94cdfd84a3ca62bada1f88ed00982659ac";
          #       hash = "sha256-Uoa9zXHYbynep0pouFyHxjv38LyDuO5GnCJSHowO8yA=";
          #     };
          #   };
          #   keys = let
          #     mkYanky = key: action: mkLuaKey ["n" "o" "x"] key ''lua require('undo-glow').yanky_put("${action}")'' action;
          #   in [
          #     (mkYanky "p" "YankyPutIndentAfter")
          #     (mkYanky "P" "YankyPutIndentBefore")
          #     (mkYanky "gp" "YankyGPutAfter")
          #     (mkYanky "gP" "YankyGPutBefore")
          #     (mkYanky "<localleader>p" "YankyPutAfter")
          #     (mkYanky "<localleader>P" "YankyPutBefore")
          #     (mkExprLuaKey ["n" "x"] "gc" ''<cmd>lua
          #       require("undo-glow").comment({
          #         command = "require('mini.comment').operator()",
          #         expr = true,
          #       })<cr>'' "Toggle comment with glow")
          #     (mkExprLuaKey "n" "gc" ''<cmd>lua
          #       require("undo-glow").comment({
          #         command = "require('mini.comment').operator() . '_'",
          #         expr = true,
          #       })<cr>'' "Comment line with glow")
          #     (mkLuaKey "n" "u" ''<cmd>lua require("undo-glow").undo()<cr>'' "Undo with highlight")
          #     (mkLuaKey "n" "U" ''<cmd>lua require("undo-glow").redo()<cr>'' "Redo with highlight")
          #   ];
          #   setupModule = "undo-glow";
          #   setupOpts = {
          #     animation = {
          #       enabled = true;
          #       duration = 300;
          #       animtion_type = "zoom";
          #       window_scoped = true;
          #     };
          #
          #     performance.color_cache_size = 2000;
          #   };
          #   after = ''
          #     vim.api.nvim_create_autocmd("TextYankPost", {
          #       desc = "Highlight when yanking (copying) text",
          #       callback = function()
          #         require("undo-glow").yank {
          #           animation = {
          #             duration = 400,
          #             animation_type = "slide",
          #           },
          #         }
          #       end,
          #     })
          #
          #     -- Highlight on cursor move
          #     vim.api.nvim_create_autocmd("CursorMoved", {
          #       desc = "Highlight when cursor moved significantly",
          #       callback = function()
          #         require("undo-glow").cursor_moved {
          #           animation = {
          #             animation_type = "slide",
          #           },
          #         }
          #       end,
          #     })
          #
          #     -- Highlight on focus gain (e.g. switching tmux panes)
          #     vim.api.nvim_create_autocmd("FocusGained", {
          #       desc = "Highlight when focus gained",
          #       callback = function()
          #         local opts = {
          #           animation = {
          #             animation_type = "slide",
          #           },
          #         }
          #         opts = require("undo-glow.utils").merge_command_opts("UgCursor", opts)
          #         local current_row = vim.api.nvim_win_get_cursor(0)[1]
          #         local cur_line = vim.api.nvim_get_current_line()
          #         require("undo-glow").highlight_region(vim.tbl_extend("force", opts, {
          #           s_row = current_row - 1,
          #           s_col = 0,
          #           e_row = current_row - 1,
          #           e_col = #cur_line,
          #           force_edge = opts.force_edge == nil and true or opts.force_edge,
          #         }))
          #       end,
          #     })
          #
          #     vim.api.nvim_create_autocmd("CmdLineLeave", {
          #       pattern = { "/", "?" },
          #       desc = "Highlight when search cmdline leave",
          #       callback = function()
          #         require("undo-glow").search_cmd {
          #           animation = {
          #             animation_type = "fade",
          #           },
          #         }
          #       end,
          #     })
          #   '';
          # };
          #
          # FIXME:
          # Failed to run 'after' hook for vimplugin-direnv.nvim: /nix/store/k7pg404hpqjszyiabs4gp9hamqf1s28r-init.lua:1058: attempt to index a function value
          # "vimplugin-direnv.nvim" = {
          #   package = pkgs.vimUtils.buildVimPlugin {
          #     name = "direnv.nvim";
          #     src = pkgs.fetchFromGitHub {
          #       owner = "NotAShelf";
          #       repo = "direnv.nvim";
          #       rev = "564146278b3d5fe4ffa389cd103bab20f9b515d6";
          #       hash = "sha256-JbnGoZMApLtq4lSdGolcpKdsneolSOrzIi+O5yR2NDQ=";
          #     };
          #   };
          #   event = ["BufReadPost" "BufNewFile"];
          #   setupModule = "direnv";
          #   setupOpts = {};
          # };
        };

        diagnostics = {
          enable = true;
          config = {
            virtual_text.format = mkLua ''
              function(diagnostic)
                local source = diagnostic.source or "LSP"
                return string.format("%s (%s)", diagnostic.message, source)
              end
            '';
            underline = true;
            update_in_insert = false;
            signs.text = mkLua ''
              {
                [vim.diagnostic.severity.ERROR] = "󰅚 ",
                [vim.diagnostic.severity.WARN] = "󰀪 ",
                [vim.diagnostic.severity.HINT] = "󰌶 ",
                [vim.diagnostic.severity.INFO] = "󰋽 ",
              }
            '';
          };
        };

        statusline.lualine = {
          enable = true;
          theme = "auto";
          globalStatus = true;
          icons.enable = true;

          sectionSeparator.left = "";
          sectionSeparator.right = "";

          componentSeparator.left = "";
          componentSeparator.right = "";

          activeSection = {
            b = [
              ''{ function() return " " end, color = { bg = "none" }, padding = { left = 0, right = 0 } }''
              ''
                {
                  function()
                    local icon = "󰈚"
                    local name = vim.fn.expand("%:t")
                    if name == "" then name = "Empty" end
                    local devicons_present, devicons = pcall(require, "nvim-web-devicons")
                    if devicons_present then
                      local ft_icon = devicons.get_icon(name)
                      icon = ft_icon or icon
                    end
                    return " " .. icon .. " " .. name .. " "
                  end,
                  color = function()
                    local hl = vim.api.nvim_get_hl(0, { name = "Special" })
                    local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
                    return {
                      fg = string.format("#%06x", norm.bg or 0x232136),
                      bg = string.format("#%06x", hl.fg or 0xebbcba),
                      gui = "bold"
                    }
                  end,
                  separator = { left = "", right = "" },
                  padding = { left = 0, right = 0 },
                }
              ''
            ];
            c = [
              ''{ "branch", icon = " ", color = { fg = "#908caa" }, padding = { left = 1, right = 1 } }''
            ];
            x = [
              ''{ "diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", hint = "󰛩 ", info = "󰋼 " }, padding = { left = 1, right = 1 } }''
            ];
            y = [
              ''
                {
                  function()
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    if #clients == 0 then return "" end
                    return (vim.o.columns > 100 and "  LSP ~ " .. clients[1].name) or "  LSP"
                  end,
                  color = { fg = "#9ccfd8", gui = "bold" },
                  padding = { left = 1, right = 2 },
                }
              ''
              ''
                {
                  function() return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " " end,
                  color = function()
                    local hl = vim.api.nvim_get_hl(0, { name = "DiagnosticWarn" })
                    local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
                    return {
                      fg = string.format("#%06x", norm.bg or 0x232136),
                      bg = string.format("#%06x", hl.fg or 0xf6c177),
                      gui = "bold"
                    }
                  end,
                  separator = { left = "", right = "" },
                  padding = { left = 0, right = 0 },
                }
              ''
            ];
            z = [
              ''{ function() return " " end, color = { bg = "none" }, padding = { left = 0, right = 0 } }''
              ''
                {
                  function() return "  %l/%v " end,
                  color = function()
                    local hl = vim.api.nvim_get_hl(0, { name = "Function" })
                    local norm = vim.api.nvim_get_hl(0, { name = "Normal" })
                    return {
                      fg = string.format("#%06x", norm.bg or 0x232136),
                      bg = string.format("#%06x", hl.fg or 0xc4a7e7),
                      gui = "bold"
                    }
                  end,
                  separator = { left = "", right = "" },
                  padding = { left = 0, right = 0 },
                }
              ''
            ];
          };
        };

        # --- Keymaps ---
        keymaps =
          [
            # Insert Mode
            (mkKey "i" "<C-b>" "<ESC>^i" "move beginning of line")
            (mkKey "i" "<C-e>" "<End>" "move end of line")
            (mkKey "i" "<C-h>" "<Left>" "move left")
            (mkKey "i" "<C-l>" "<Right>" "move right")
            (mkKey "i" "<C-j>" "<Down>" "move down")
            (mkKey "i" "<C-k>" "<Up>" "move up")

            # Normal Mode
            (mkKey "n" "<leader>|" "<cmd>vsplit<cr>" "window: split vertically")
            (mkKey "n" "<leader>\\" "<cmd>split<cr>" "window: split horizontally")
            (mkKey "n" "<leader>w" "<cmd>w<cr>" "editor: write changes")
            (mkKey "n" "<leader>j" "J" "editor: join strings")
            (mkKey "n" "<Esc>" "<cmd>noh<cr>" "clear highlights")
            (mkKey "n" "<leader>e" "<cmd>NvimTreeToggle<cr>" "toggle nvim-tree")
          ]
          ++ (mapKeys "n" "" {
            "<S-J>" = {
              action = "<cmd>BufferLineCycleNext<cr>";
              desc = "buffer: next";
            };
            "<S-K>" = {
              action = "<cmd>BufferLineCyclePrev<cr>";
              desc = "buffer: prev";
            };
            "gJ" = {
              action = "<cmd>BufferLineMoveNext<cr>";
              desc = "buffer: move right";
            };
            "gK" = {
              action = "<cmd>BufferLineMovePrev<cr>";
              desc = "buffer: move left";
            };
            "<A-e>" = {
              action = "<cmd>enew<cr>";
              desc = "buffer: new";
            };
            "<A-q>" = {
              action = smartCloseLua;
              desc = "buffer: smart close";
              lua = true;
            };
            "<C-p>" = {
              action = "<Plug>(YankyPreviousEntry)";
              desc = "Yanky previous";
            };
            "<C-n>" = {
              action = "<Plug>(YankyNextEntry)";
              desc = "Yanky next";
            };
          });
      };
    };
  };
}
