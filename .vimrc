
syntax enable

se expandtab
se nu
se nocompatible
se ruler
se showmatch
se mouse=a
se ts=2
se sw=2
se showtabline=2
se autoindent
se smartindent
se background=dark

filetype indent plugin on

"go code linter
""set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
"autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
"
execute pathogen#infect()
execute pathogen#helptags()
