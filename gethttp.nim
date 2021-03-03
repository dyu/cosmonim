import std/[httpclient, strformat]

let c = newHttpClient()
let resp = c.get("http://ix.io")

echo fmt"Status: {resp.status}, body len: {resp.body.len}"