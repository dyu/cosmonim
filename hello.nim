import std/[tables]

var x = newTable[string, string]()
x["hello"] = "world"

echo "Hello, world!"

writeFile("testing", "hellohere")

echo readFile("testing")