# === Homebrew (macOS /opt/homebrew or Linuxbrew) ===
# Must run early so brew-installed tools (starship, atuin, eza, ...) resolve below.
for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew
    if test -x $brew_bin
        $brew_bin shellenv | source
        break
    end
end

# On Linux, grep is already GNU grep; ggrep only exists via brew on macOS.
if type -q ggrep
    alias grep='ggrep'
end

# === Environment Variables ===
set -gx GOPATH $HOME/Documents/git/go
set fish_greeting

# Append directories to PATH (fish’s PATH is an array)
#set -gx PATH $PATH $GOPATH/bin
#set -gx PATH $PATH $GOROOT/bin
#set -gx PATH $JAVA_HOME/bin $PATH

# Some GUI launchers (e.g. cmux) inject a stale SHELL=zsh even though fish is the
# login shell. Assert SHELL so installers (pnpm, etc.) target fish, not ~/.zshrc.
set -gx SHELL (command -v fish)

set -gx EDITOR nvim
set -gx CLAUDE_CODE_NO_FLICKER 1

# === Darwin‐Specific Settings ===
if test (uname) = Darwin
    alias htop 'sudo htop'
    set -gx RUST_SRC_PATH ~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
    set -gx ANDROID_HOME $HOME/Library/Android/sdk
    # === Homeshick Settings ===
    set -gx HOMESHICK_DIR /usr/local/opt/homeshick
    # source /usr/local/opt/homeshick/homeshick.fish  # if a fish version exists
end

# === ag Alias (if command exists) ===
if type -q ag
    alias ag 'ag --pager="less -XFR"'
end

if type -q eza
    alias xa 'eza -abghl --icons --git --color=automatic'
    alias za 'eza -ghl --icons --git'
end

# === VirtualEnvWrapper ===
#set -gx WORKON_HOME $HOME/.virtualenvs
# In fish, consider using “virtualfish” instead of sourcing virtualenvwrapper.sh

# === History Settings ===
# Fish manages history differently—no need to set HISTSIZE/HISTFILESIZE here.

# === Plugin System ===
# oh‑my‑zsh plugins and fpath adjustments don’t apply.
# Use fisher or similar package managers for fish.

# === nvm / RVM / Cargo ===
# macOS uses nvm.fish (fisher); Linux/WSL uses fnm below.
set -gx PATH $PATH $HOME/.rvm/bin
set -gx PATH $PATH $HOME/.cargo/bin

# === fnm (Linux/WSL Node version manager) ===
if test -d $HOME/.local/share/fnm
    fish_add_path $HOME/.local/share/fnm
    fnm env --shell fish | source
end

# === bun ===
if test -d $HOME/.bun
    set -gx BUN_INSTALL $HOME/.bun
    fish_add_path $BUN_INSTALL/bin
end

# === kiex (Elixir) ===
if test -d $HOME/.kiex/bin
    fish_add_path --append $HOME/.kiex/bin
end

# === asdf (>= 0.16, shims-based) ===
if test -d $HOME/.asdf/shims
    fish_add_path $HOME/.asdf/shims
end

# === Linux‐Specific Clipboard Functions ===
if test (uname) = Linux
    function cb
        # NOTE: Handling of color escape codes and stdin may seem unusual.
        set -l _scs_col "\e[0;32m"
        set -l _wrn_col "\e[1;31m"
        set -l _trn_col "\e[0;33m"

        if not type -q xclip
            echo -e "$_wrn_col You must have the 'xclip' program installed.\e[0m"
        else if test $USER = root
            echo -e "$_wrn_col Must be regular user (not root) to copy to clipboard.\e[0m"
        else
            # If no interactive input, grab from stdin; otherwise use arguments.
            if not test -t 0
                set input (cat)
            else
                set input $argv
            end
            if test -z "$input"
                echo "Copies a string to the clipboard."
                echo "Usage: cb <string>"
                echo "       echo <string> | cb"
            else
                echo -n $input | xclip -selection c
                if test (string length -- $input) -gt 80
                    set input (string sub -l 1 -L 80 $input)"$_trn_col... \e[0m"
                end
                echo -e "$_scs_col Copied to clipboard:\e[0m $input"
            end
        end
    end

    function cbf
        cat $argv[1] | cb
    end

    alias cbssh 'cbf ~/.ssh/id_rsa.pub'
    alias cbwd 'pwd | cb'
    # NOTE: Fish history is stored differently; adjust cbhs as needed.
    alias cbhs 'cat ~/.local/share/fish/fish_history | tail -n 1 | cb'
end

# === fzf Setup ===
if test -f $HOME/.fzf.fish
    source $HOME/.fzf.fish
end
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

set -gx PATH $PATH $HOME/.foundry/bin

# === Nargo Settings ===
set -gx NARGO_HOME $HOME/.nargo
set -gx PATH $PATH $NARGO_HOME/bin

# === LM Studio CLI and local bin ===
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $PATH $HOME/.cache/lm-studio/bin

if type -q starship
    starship init fish | source
end
if type -q atuin
    atuin init fish | source
end

# opencode
fish_add_path $HOME/.opencode/bin

# Added by Antigravity
if test -d $HOME/.antigravity/antigravity/bin
    fish_add_path $HOME/.antigravity/antigravity/bin
end

# Brew updater
alias brewup 'brew update && brew outdated --greedy && brew upgrade --greedy && brew cleanup'

# pnpm
if test (uname) = Darwin
    set -gx PNPM_HOME "$HOME/Library/pnpm"
else
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end
if not contains -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

# OpenClaw Completion
if test -f "$HOME/.openclaw/completions/openclaw.fish"
    source "$HOME/.openclaw/completions/openclaw.fish"
end

# Entire CLI shell completion
if type -q entire
    entire completion fish | source
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
