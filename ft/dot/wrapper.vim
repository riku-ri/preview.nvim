let s:dot_cmd             = "dot -Tsvg"
let s:port_filename       = getpid().'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
let s:send_output_to_port = 'socketsend '.s:port

silent execute 'w !sed '."'".'1idigraph'.'"'.split(@%,'/')[-1].'"'.'\{' .
\ 'graph[labelloc="t"fillcolor=none style=dashed fontname="Monaspace Xenon"]' .
\ 'node[shape=box fontname="Monaspace Xenon" nojustify=true]' .
\ 'edge[arrowhead=vee arrowtail=vee fontname="Monaspace Xenon"]' .
\ "'".'|'.'sed '."'".'$a'.'\}'."'".'|'.s:dot_cmd.'|'.s:send_output_to_port
