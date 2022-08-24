import std/[tables]

var x = newTable[string, string]()
x["hello"] = "world"

echo "Hello, world!"

writeFile("hello.txt", x["hello"])

echo readFile("hello.txt")
