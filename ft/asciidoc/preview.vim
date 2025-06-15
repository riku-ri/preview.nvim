let s:cmd             = "asciidoctor -s -S secure -|cat ~/.lulix/dvl/css/github.css /dev/stdin"
let s:port_filename       = getpid().'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
let s:send_output_to_port = 'socketsend '.s:port

execute 'w !'.s:cmd.'|'.s:send_output_to_port
