let s:m4_cmd             = "m4 -D__root__=\"`git rev-parse --show-toplevel`\" -D__git__=\"`git rev-parse --show-toplevel|xargs basename`\" -D__relative_root__=\"`realpath -m --relative-to=$PWD $(git rev-parse --show-toplevel)`\" -D__path__=\"`echo $(realpath .)|grep -oP \"(?<=$(git rev-parse --show-toplevel)/).*\"`\"|pandoc -f markdown+ignore_line_breaks -s --toc --preserve-tabs --standalone -H $HOME/.lulix/dvl/css/github.css"
let s:port_filename       = getpid().'.'.bufnr('%').'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
let s:send_output_to_port = 'socketsend '.s:port

"silent execute 'w !dot -Tsvg|socketsend `cat '.getpid().'.'.bufnr('%').'.'.'data.port'.'|tr -d ":"`'
execute 'w !'.s:m4_cmd.'|'.s:send_output_to_port
