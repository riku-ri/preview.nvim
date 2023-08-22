From [```../README.md```](../README.md),
we know that renderable data will
be sent to a socket and
finally replace web page content directly.
In other words,
socket just receive text and never change them.

But somtimes we want to view something
converted from the edit buffer but not
itself. To do that, we have to write
convertors for various file types.

It is complicated.
But I divide all the types to several kinds below.

## Something can be quickly, simply converted to svg, html *etc*.

- __code__(.dot)  
	In fact _git_ was written for
	__code__(.dot) at the first.
- __code__(.md)

## Something interpreted. And we want to view the result of it.

python, perl, lua, ... for a lot.

A example for R language is in __flink__(r/).
Because the R interpreter __code__(Rscript)
didn't get text from standard input
but the filename argument.
There is some explain for it.

## Something compiled. And we want to view the result of it.

Typically C language code.
We may have to save some temporary files.

## Something can be converted to various types per se

__code__(.m4)

## TeX

More and More complicated.
