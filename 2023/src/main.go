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
	file, _ := os.ReadFile("input2.txt")
	content := string(file)
	lines := strings.Split(content, "\n")
	head, tail := lines[0], lines[1:]

	seedsStr := strings.Split(strings.Split(head, ":")[1], " ")

	var seedsPre []int

	for _, v := range seedsStr {
		if v != "" {
			val := toInt(strings.TrimSpace(v))
			seedsPre = append(seedsPre, val)
		}
	}

	var seeds [][]int

	for i, val := range seedsPre {
		if i%2 != 0 {
			prevVal := seeds[len(seeds)-1]
			seeds[len(seeds)-1] = []int{prevVal[0], prevVal[0] + val}
		} else {
			seeds = append(seeds, []int{val})
		}
	}

	blocks := [][][]int{}

	for _, line := range tail {
		if line != "" && unicode.IsDigit(rune(line[0])) {
			splitedValues := strings.Split(line, " ")
			destination, source, rangeLength := toInt(splitedValues[0]), toInt(splitedValues[1]), toInt(splitedValues[2])
			blocks[len(blocks)-1] = append(blocks[len(blocks)-1], []int{destination, source, rangeLength})
		} else if line == "" {
			continue
		} else {
			blocks = append(blocks, [][]int{})
		}
	}

	for _, block := range blocks {

		var nextSources [][]int
		fmt.Println("Seeds: ", seeds)
		for len(seeds) > 0 {
			seedStart, seedEnd := seeds[0][0], seeds[0][1]
			fmt.Println("Seed: ", seeds[0])
			seeds = seeds[1:]

			matches := [][]int{}

			for _, rg := range block {
				fmt.Println("Range: ", rg)
				destination, source, rangeLength := rg[0], rg[1], rg[2]

				overlapStart := max(seedStart, source)
				overlapEnd := min(seedEnd, source+rangeLength)

				if overlapStart < overlapEnd {
					startMapped := overlapStart - source + destination
					endMapped := overlapEnd - source + destination
					matches = append(matches, []int{startMapped, endMapped})

					if overlapStart > seedStart {
						seeds = append(seeds, []int{seedStart, overlapStart})
					}

					if overlapEnd < seedEnd {
						seeds = append(seeds, []int{overlapEnd, seedEnd})
					}
					break
				}
			}
			if len(matches) == 0 {
				nextSources = append(nextSources, []int{seedStart, seedEnd})
			} else {
				for _, m := range matches {
					nextSources = append(nextSources, m)
				}
			}
		}
		fmt.Println("Next sources: ", nextSources)
		seeds = nextSources
	}

	result := seeds[0][0]
	for _, s := range seeds {
		result = min(result, min(s[0]))
	}

	fmt.Println("Seeds: ", seeds)
	fmt.Println("Result: ", result)
}
