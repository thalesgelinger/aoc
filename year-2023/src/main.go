package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
	"unicode"
)

func toInt(str string) int {
	val, _ := strconv.Atoi(str)
	return val
}

func main() {
	file, _ := os.ReadFile("input.txt")
	content := string(file)
	lines := strings.Split(content, "\n")
	head, tail := lines[0], lines[1:]

	seedsStr := strings.Split(strings.Split(head, ":")[1], " ")

	var seeds []int

	for _, v := range seedsStr {
		if v != "" {
			seeds = append(seeds, toInt(strings.TrimSpace(v)))
		}
	}

	result := -1

	for _, seed := range seeds {
		seedDestination := seed
		hasUpdated := false
		for _, line := range tail {
			if line != "" && unicode.IsDigit(rune(line[0])) {
				splitedValues := strings.Split(line, " ")
				destination, source, rangeLength := toInt(splitedValues[0]), toInt(splitedValues[1]), toInt(splitedValues[2])

				if source <= seedDestination && seedDestination < (source+rangeLength) && !hasUpdated {
					seedDestination = seedDestination - source + destination
					hasUpdated = true
				}

			} else {
				hasUpdated = false
			}

		}
		if result < 0 {
			result = seedDestination
		} else {
			if result > seedDestination {
				result = seedDestination
			}
		}
	}

		fmt.Println("Location Lowest: ", result)
}
