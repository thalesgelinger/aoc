package main

import (
	"fmt"
	"os"
)

func main() {
	file, _ := os.ReadFile("example.txt")
	fmt.Println(string(file))
}
