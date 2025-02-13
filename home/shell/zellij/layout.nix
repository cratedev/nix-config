let
  fg = "#5DE4C7";
  active = "#E4F0FB";
in
  /*
  kdl
  */
  ''
    layout {
      pane split_direction="horizontal" {
        pane size=1 borderless=true {
          plugin location="file:$HOME/.config/zellij/plugins/zjstatus.wasm" {

            // Nord theme
            color_fg "#616e88" //= Brightest + 10% - "#4C566A" = Brightest - "#434C5E" = Bright
            color_bg "#2E3440"
            color_black "#3B4252"
            color_red "#BF616A"
            color_green "#A3BE8C"
            color_yellow "#EBCB8B"
            color_blue "#81A1C1"
            color_magenta "#B48EAD"
            color_cyan "#88C0D0"
            color_white "#E5E9F0"
            color_orange "#D08770"

            format_left   "#[fg=#E2E0DF,bold]{session}"
            format_center "{tabs}"
            format_right  "{command_git_branch} {datetime}"
            format_space  ""

            border_enabled  "false"
            border_char     "─"
            border_format   "#[fg=#$cyan]{char}"
            border_position "top"

            hide_frame_for_single_pane "true"

            mode_normal        "#[bg=$cyan,fg=$bg,bold] NORMAL#[bg=$bg,fg=$cyan]"
            mode_locked        "#[bg=$red,fg=$bg,bold] LOCKED #[bg=$bg,fg=$red]"
            mode_resize        "#[bg=$blue,fg=$bg,bold] RESIZE#[bg=$bg,fg=$blue]"
            mode_pane          "#[bg=$blue,fg=$bg,bold] PANE#[bg=$bg,fg=$blue]"
            mode_tab           "#[bg=$yellow,fg=$bg,bold] TAB#[bg=$bg,fg=$yellow]"
            mode_scroll        "#[bg=$blue,fg=$bg,bold] SCROLL#[bg=$bg,fg=$blue]"
            mode_enter_search  "#[bg=$orange,fg=$bg,bold] ENT-SEARCH#[bg=$bg,fg=$orange]"
            mode_search        "#[bg=$orange,fg=$bg,bold] SEARCHARCH#[bg=$bg,fg=$orange]"
            mode_rename_tab    "#[bg=$yellow,fg=$bg,bold] RENAME-TAB#[bg=$bg,fg=$yellow]"
            mode_rename_pane   "#[bg=$blue,fg=$bg,bold] RENAME-PANE#[bg=$bg,fg=$blue]"
            mode_session       "#[bg=$blue,fg=$bg,bold] SESSION#[bg=$bg,fg=$blue]"
            mode_move          "#[bg=$blue,fg=$bg,bold] MOVE#[bg=$bg,fg=$blue]"
            mode_prompt        "#[bg=$blue,fg=$bg,bold] PROMPT#[bg=$bg,fg=$blue]"
            mode_tmux          "#[bg=$magenta,fg=$bg,bold] TMUX#[bg=$bg,fg=$magenta]"

            // formatting for inactive tabs
            tab_active              "#[bg=$bg,fg=$cyan]#[bg=$cyan,fg=$bg,bold][{index}]#[bg=$bg,fg=$cyan,bold] {name}{floating_indicator}#[bg=$bg,fg=$bg,bold]"
            tab_active_fullscreen   "#[bg=$bg,fg=$cyan]#[bg=$cyan,fg=$bg,bold][{index}]#[bg=$bg,fg=$cyan,bold] {name}{fullscreen_indicator}#[bg=$bg,fg=$bg,bold]"
            tab_active_sync         "#[bg=$bg,fg=$cyan]#[bg=$cyan,fg=$bg,bold][{index}]#[bg=$bg,fg=$cyan,bold] {name}{sync_indicator}#[bg=$bg,fg=$bg,bold]"

            // formatting for the current active tab
            tab_normal              "#[bg=$bg,fg=$yellow]#[bg=$yellow,fg=$bg,bold] {index} #[bg=$bg,fg=$yellow,bold] {name}{floating_indicator}#[bg=$bg,fg=$bg,bold]"
            tab_normal_fullscreen   "#[bg=$bg,fg=$yellow]#[bg=$yellow,fg=$bg,bold] {index} #[bg=$bg,fg=$yellow,bold] {name}{fullscreen_indicator}#[bg=$bg,fg=$bg,bold]"
            tab_normal_sync         "#[bg=$bg,fg=$yellow]#[bg=$yellow,fg=$bg,bold] {index} #[bg=$bg,fg=$yellow,bold] {name}{sync_indicator}#[bg=$bg,fg=$bg,bold]"

            // separator between the tabs
            tab_separator           "#[bg=$bg] "

            // indicators
            tab_sync_indicator       " "
            tab_fullscreen_indicator " 󰊓"
            tab_floating_indicator   " 󰹙"

            command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
            command_git_branch_format      "#[fg=blue] {stdout} "
            command_git_branch_interval    "10"
            command_git_branch_rendermode  "static"

            datetime        "#[fg=#6C7086,bold] {format} "
            datetime_format "%A, %d %b %Y %H:%M"
            datetime_timezone "America/Toronto"
          }
        }
       pane
       pane {
          borderless false
          size 12
          //command "spotify_player"
        }
      }
    }''
