let s:r_interpret         = 'Rscript /dev/stdin 2>&1'
let s:r_wrap              = "sed '1i<pre>' | sed '$a</pre>'"
let s:r_cmd               = s:r_interpret.'|'.s:r_wrap
let s:port_filename       = getpid().'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
let s:send_output_to_port = 'nc -tc 127.0.0.1 '.s:port

silent execute 'w !'.s:r_cmd.'|'.s:send_output_to_port
