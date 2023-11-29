
import java.io.File

val file = File("example.txt")

val bufferedReader = file.bufferedReader()

bufferedReader.useLines { lines ->
    lines.forEach { line ->
        println(line)
    }
}
