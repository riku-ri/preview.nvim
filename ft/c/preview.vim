let s:c_compile           = '(clang -xc - 2>&1 && ./a.out first 2nd enough)'
"Without arguments
"let s:c_compile           = '(clang -xc - 2>&1 && ./a.out)'
"Without compile message
"let s:c_compile           = '(clang -xc - && ./a.out)'

let s:c_wrap              = "sed '1i<pre>' | sed '$a</pre>'"
let s:c_cmd               = s:c_compile.'|'.s:c_wrap
"let s:port_filename       = getpid().'.'.bufnr('%').'.'.'data.port'
let s:port_filename       = getpid().'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
let s:send_output_to_port = 'socketsend '.s:port

silent execute 'w !'.s:c_cmd.'|'.s:send_output_to_port
