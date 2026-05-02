configure_root_bash_profile:
  file.managed:
    - name: /root/.bash_profile
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        # .bash_profile
        
        # Get the aliases and functions
        if [ -f ~/.bashrc ]; then
                . ~/.bashrc
        fi
        
        # User specific environment and startup programs
        alias grep='grep --color=auto'
        alias l.='ls -CFd .* --color=auto'
        alias ll='ls -CFl --color=auto'
        alias ls='ls -CF --color=auto'
        alias la='ls -CFa --color=auto'
        alias vi=vim
        alias yum=dnf4
        
        umask 002
        
        export PATH

configure_root_vimrc:
  file.managed:
    - name: /root/.vimrc
    - user: root
    - group: root
    - mode: '0644'
    - contents: |
        " Basic UI and Interaction
        se number
        se sm
        se ai
        se ts=2
        set expandtab
        set laststatus=2
        set wildmenu
        
        " Status Line Configuration
        set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
        
        " Enable File Type Detection and Plugins
        filetype plugin indent on
        syntax on
        
        " Filetype specific overrides
        if has("autocmd")
          augroup config
            autocmd!
            " Ensure Shell, C, and PHP files adhere to your tab settings
            autocmd FileType sh,c,cpp,php setlocal ts=2 sw=2 expandtab
            " Highlight trailing whitespace in red for security/config files
            autocmd FileType sh,python,yaml match ErrorMsg /\s\+$/
          augroup END
        endif

