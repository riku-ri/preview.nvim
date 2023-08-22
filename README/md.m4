divert(-1)
pandoc -f markdown+ignore_line_breaks -s --toc --preserve-tabs --standalone -H $HOME/.lulix/css/dvl/github.css
define(`__code__', `<code>'`$1'`</code>')
define(`__md_code__',	changequote([,])[changequote([,])```changequote(`,')]changequote(`,'))
changecom(`>>', `<<')
define(`_git_', `__git__[<sub><i>github</i></sub>]() ')
define(`__flink__', [`__code__($1)']($1))
define(`__md_table_title__', `ifelse(`$#', `0', , `$#', `1', ``$1'', ``$1' | __md_table_title__(shift($@))')')
define(`__md_table_spline__', `ifelse(`$#', `0', , `$#', `1', `-', `- | __md_table_spline__(shift($@))')')
define(`__title_path__', `ifelse(__path__, `', ,`: __code__(__path__)')')
define(`__title__', `_git_ __title_path__')
define(`__2vim__', `neovim<sub><i>or vim</i></sub>')
define(`__more_details__',
` More details

> Enter subdirectories to learn about specific components.
'
)
divert(-0)dnl
