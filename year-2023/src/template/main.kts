import java.io.File

val lines = File("example.txt").bufferedReader().lines()

lines.forEach { line -> println(line) }
