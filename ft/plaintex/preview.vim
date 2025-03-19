let g:tex_compiler        = 'luatex'
let s:port_filename       = getpid().'.'.bufnr('%').'.'.'data.port'
let s:port                = substitute(readfile(s:port_filename)[0], ":",     "",        "")
let s:send_output_to_port = 'python ~/.vim/preview/ft/plaintex/plaintex.py /dev/stdin '.s:port
"let s:send_output_to_port = 'socketsend '.s:port

let s:tex_cmd_compile = "sed '1i\\\\\\relax'|".g:tex_compiler." --interaction=scrollmode 1>/dev/null"
let s:tex_cmd_pdf2svg = "pdf2svg texput.pdf /dev/stdout"
"let s:tex_cmd_svg2png2base64 = "rsvg-convert -fpng|perl ./tex.pl|tr -d '\\n'"
let s:tex_cmd_nosafe = "(" . s:tex_cmd_compile . "&&" . s:tex_cmd_pdf2svg . ")"
"let s:tex_cmd_onerror = "(cat texput.log|sed '1i<pre>'|sed '$a</pre>')"
let s:tex_cmd_onerror = "(printf '')"
let g:tex_cmd_safe = "(" . "test `ps --no-headers -C ".g:tex_compiler."|wc -l` -ge 1" . "||" . "(" . s:tex_cmd_nosafe . '||' . s:tex_cmd_onerror . ")" . ")"
let s:tex_cmd         = g:tex_cmd_safe

execute 'w !' . s:tex_cmd . '|' . s:send_output_to_port . '&'
