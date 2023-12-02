package main

import (
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	file, _ := os.ReadFile("input.txt")
	content := string(file)

	redMax, greenMax, blueMax := 12, 13, 14

	lines := strings.Split(content, "\n")

	lines = lines[:len(lines)-1]

	semiCommaComma := regexp.MustCompile(`;|,`)

	response := 0

	for _, line := range lines {
		gameSplitted := strings.Split(line, ":")

		gameColorSet := semiCommaComma.Split(gameSplitted[1], -1)
		isSetValid := true

		for _, gameColorSet := range gameColorSet {
			colorAndValue := strings.Split(gameColorSet, " ")
			// FIXME: i should not start with 1, missing trim
			valueAsString, color := colorAndValue[1], colorAndValue[2]
			value, _ := strconv.Atoi(valueAsString)

			switch color {
			case "red":
				if value > redMax {
					isSetValid = false
				}
				break
			case "blue":
				if value > blueMax {
					isSetValid = false
				}
				break
			case "green":
				if value > greenMax {
					isSetValid = false
				}
				break
			}

			if !isSetValid {
				break
			}
		}

		if isSetValid {
			gameIdAsString := strings.Split(gameSplitted[0], " ")[1]
			gameId, _ := strconv.Atoi(gameIdAsString)
			response += gameId
		}
	}

	fmt.Println("Response: ", response)
}
