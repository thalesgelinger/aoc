import java.io.File

val lines = File("input2.txt").bufferedReader().lines()

var mapGameCopies = HashMap<Int, Int>()

lines.forEach {
    val (gameTitle, tail) = it.split(":")
    val numbers = tail.split(" ")
    val gameId = gameTitle.split(" ").last().toInt()
    mapGameCopies[gameId] = mapGameCopies[gameId]?.let { it + 1 } ?: 1

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
                                else -> points += 1
                            }
                        }
            }
        }
    }

    val until = gameId + points
    val currentIdCopies = mapGameCopies[gameId]?.let { it } ?: 1
    for (i in 1..currentIdCopies) {
        for (j in gameId + 1..until) {
            mapGameCopies[j] = mapGameCopies[j]?.let { it + 1 } ?: 1
        }
    }
}

val result = mapGameCopies.values.reduce { acc, cur -> acc.toInt() + cur.toInt() }

println("Result: $result")
