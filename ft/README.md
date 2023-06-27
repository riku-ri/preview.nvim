# preview.nvim/ft

Some example for make a specific filetype can be preview

## What we need to do

### Create a file named filetype and with suffix ```.vim```

like ```dot.vim```.

You can rename this file,
just ensure the path of file can match ```g:preview_dot_vimrc```.

If you want to preview a markdown file, it will be ```g:preview_md_vimrc```.
Exactly, the word between ```g:preview_``` and ```_vimrc``` is
```:set ft``` in neovim.

### Find out a way to send data from standard input to a specific TCP port

Assuming you want to preview a
[dot](https://graphviz.org/doc/info/lang.html)
file, you should compile dot code in the file,
make it can be randered by browser, and send it to a TCP port
in the ```dot.vim```(or other name, see above)

#### From neovim buffer to other programs

Just like [```dot.vim```](dot.vim) in this directory,
```dot -Tsvg``` will compile dot code from **stdin** to a svg graph,
and output svg to **stdout**.

To send the neovim buffer content to ```dot -Tsvg```,
run ```:w !dot -Tsvg``` in the neovim buffer.
And maybe we want to show error message when compile is failed with ```2>&1```.
Hence

```
let s:dot_cmd             = "dot -Tsvg 2>&1"
```

And

```
silent excute 'w !'.s:dot_cmd ...
```

> ```:help write_c``` for more detals

#### From a standard output to TCP port

Here we use [**GNU netcat**](https://netcat.sourceforge.net/)
```nc```.

```nc 127.0.0.1 <port>``` will get data from stdin and send it to ```<port>```

Options in [```dot.vim```](dot.vim):
- ```-t``` : Use TCP
- ```-c``` : Close after sending

**Note that close the connection after sending is necessary. Behavior without closing is undefined.**

So pipe ```nc``` is enough

#### Whitch port is in use

Depends on operating system.
But every time we ```:source ~/.vim/preview/preview.vim```,
the port will save in a file named ```(VIM pid).(VIM buffer id).data.port```.
Hence

```
let s:port_filename       = getpid().'.'.bufnr('%').'.'.'data.port'
```

Note that the port number in ```(VIM pid).(VIM buffer id).data.port``` file
has colon prefix.

```nc``` use port number without colon.
Hence

```
let s:port                = substitute(readfile(s:port_filename)[0], ":", "", "")
```

Every time we source [```dot.vim```](dot.vim)

```
silent execute 'w !dot -Tsvg|nc -tc 127.0.0.1 `cat '.getpid().'.'.bufnr('%').'.'.'data.port'.'|tr -d ":"`'
```

Command above will be run.

To synchronize buffer,
just run ```:so dot.vim``` on every change of edit buffer.
This is done in [```../preview.vim```](../preview.vim) 

## Other situations

### Interpreted

It was easy to do that if you want to preview the output of code,
just pipe to the interpreter.

[```r.vim```](r.vim) shows how to do it.

The R interpreter ```Rscript``` use the command line argument as script filename,
we can use ```/dev/stdin``` for it.

Note that the result in stdout will be sent to TCP port directly,
and browser will render it directly too,
so linebreak, and some characters(like ```<```) will make error.
Use ```sed``` ```tr``` to fix them.

In [```r.vim```](r.vim), we wrap output in ```<pre></pre>```
by ```sed```.

### Compied

In most cases, compiler don't provide way to send result to stdout.
Because the result may be format with many binary information, like ELF, PDF

In [```c.vim```](c.vim) we compile it, use the default output name ```a.out```,
and run ```a.out``` then pipe it. And we wrap it with ```<pre>``` for
correctly rendering too.

Compile command and execute command should be wrap in a pair of parenthesis
cause posix shell syntax.

