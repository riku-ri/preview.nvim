include(__root__/README/md.m4)
# __title__

Preview anything in __2vim__.

## How to use it

### Requirement

- Platform
	- Linux
- Editor
	- __2vim__
		- vim 8 or later
		- neovim is preferred
		- Ensure editor can detech filetype, and set __code__(&ft).
			try Running __code__(:set ft) in a specific filetype file.
- Browser
	- Ensure the browser support websocket
	- Ensure the browser can open a html as an argument in command line
	- You can set it by set __code__(g:preview_browser)
- [golang](https://go.dev/)
	- Program is written by go language, so
		ensure go programs can works

### Quick start

__md_code__
make -B -f makefile.default
__md_code__

And then edit a file in [__code__(test/)](test/) by neovim, like

__md_code__
nvim test/preview.c
__md_code__

> __flink__(ft/c/preiview.vim) use __code__(clang) as compiler,
> ensure __code__(clang) is valid.

And run __code__(:so ~/.vim/preview/preview.vim) in neovim.
A browser will be opened and shows the resoult if code in __code__(preview.c) is executed.

Try editing and see changes in web page.


If __code__(dot) is valid,
try __flink__(test/lwip_dhcp_renew_calltree.dot).
__code__(source ~/.vim/preview/preview.vim) too.

And __flink__(preview.r), __flink__(ft/r/preview.vim) is for R language.

## What __code__(makefile.default) will do

![](README/make.svg)

And relative files will be:

define(`__table_title__', `Description,path,Vim-variable')
| __md_table_title__(__table_title__) |
| __md_table_spline__(__table_title__) |
| __code__(preview.vim) | __code__(~/.vim/preview/preview.vim) | Not in a vim variabl, You shold source it directly |
| Compiled __code__(websocket.go) | __code__(~/.vim/preview/websocket) | __code__(g:preview_websocket_program) |
| Some example of specific filetypes | __code__(~/.vim/preview/ft/*.vim) | __code__('g:preview_'.&ft.'_vimrc') |

## How does it work

After __code__(make -f makefile.default),
assuming you are editing a
[dot](https://graphviz.org/doc/info/lang.html)
file,
and __code__(:source ~/.vim/preview/preview.vim) in neovim,
it will works as below:

![](README/dot.svg)

The  browser will update preview when neovim buffer change.

## __more_details__

# For developers

Content below explain
**How I design _git_ itself**
 and **What I actually do**.

## What we need to do

### For sending data from __2vim__ edit buffer to browser

![](__relative_root__/README/nvim2browser.svg)

**GRAPH** above shows how I send data from a
*unsaved but changed* edit buffer to browser.

#### From __2vim__ edit buffer to other programs

This can be simply done by __code__(:w !). Just __code__(:help w_c).

The truly troublesome process is
convert various file types to
what browser can render(generally html).
See __flink__(ft/) for more details.

### For auto refresh page content when edit buffer changed

Up to now,
maybe websocket is the only choise.

More specifically,
every time the edit bufffer changed was deteted by

__md_code__
autocmd InsertLeave,TextChanged,TextChangedI <buffer>
__md_code__

__code__(w !) will send the whole
buffer content to some programs
that convert it to renderable format,
and the converted data will be sent to
a socket.
And then websocket get it from socket,
and replace the web page content to it
by change __code__(\<body/\>)'s __code__(innerHTML).

These are implememted in __flink__(websocket.go)

## Combine steps above

In __flink__(preview.vim).

Besides, __flink__(preview.vim)
also startup a browser,
write socket number, websocket number to files,
and manage them by __2vim__ rpc.

> Note that _git_ is mainly for neovim.
> So maybe vim would not work,
> especially about rpc.
