import std/[tables]

var x = newTable[string, string]()
x["hello"] = "world"

echo "Hello, world!"

writeFile("dist/testing.txt", "hellohere")

echo readFile("dist/testing.txt")
