# Design & Development

More information for development.

## Before reading

Have a look of the table below.
It shows techniques, tools and their implementions used in this project

| Function | Solution | Implemention | Relative files | Help | *Remarks* |
| - | - | - | - | - | - |
| Sending vim buffer to other program | ```:w !``` | vim/neoim | [```../ft```](../ft) | ```:help w_c``` ||
| Getting renderable preview(HTML, SVG) data | socket | golang | [```../websocket.go```](../websocket.go) | [pkg.go.dev](https://pkg.go.dev/net) ||
| HTTP server | golang | golang | [```../websocket.go```](../websocket.go) | [pkg.go.dev](https://pkg.go.dev/net/http) ||
| HTTP client | javascript | javascript | [```../websocket.go```](../websocket.go) ||
| Sending stdin to TCP port | netcat | ```nc``` | [```../ft```](../ft) | [GNU netcat](https://netcat.sourceforge.net/) ||
| Sending buffer changes to browser | websocket | golang.org/x/net | [```../websocket.go```](../websocket.go) | [pkg.go.dev](https://pkg.go.dev/golang.org/x/net/websocket) ||

## How does it work

## Some details
