import java.io.File

val lines = File("input.txt").bufferedReader().lines()

var result = 0

lines.forEach {
    val (_, tail) = it.split(":")
    val numbers = tail.split(" ")
    var checkWinners = false
    var points = 0
    var mapNum = HashMap<String, Boolean>()
    numbers.forEach {
        val el = it.trim()

        if (el.equals("|")) checkWinners = true
        if (!el.isEmpty()) {
            when (checkWinners) {
                false ->
                        if (!mapNum.containsKey(el)) {
                            mapNum[el] = true
                        }
                true ->
                        if (mapNum.containsKey(el)) {
                            when (points) {
                                0 -> points = 1
                                else -> points *= 2
                            }
                        }
            }
        }
    }
    result += points
}

println("Result: $result")
