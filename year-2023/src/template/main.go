package main

import (
	"fmt"
	"os"
)

func main() {
	file, _ := os.ReadFile("example.txt")
	content := string(file)
	fmt.Println(content)
}
