package day5

import java.nio.file.Files
import java.nio.file.Paths
import kotlin.coroutines.experimental.buildSequence

// Let's play with type aliases
typealias Program = List<Int>
typealias Bug = (Int) -> Int

data class Memory(private val pointer: Int, private val instructions: Program) {
    fun takeStep(bug: Bug): Memory = Memory(jump(), corruptProgram(bug))

    private fun jump() = pointer + instructions[pointer]

    private fun corruptProgram(bug: Bug): Program {
        // There must be a better way
        val program = instructions.toMutableList()
        program[pointer] += bug(program[pointer])
        return program
    }

    val overflow = pointer >= instructions.size
}

object CPU {
    // Generate a sequence of all intermediate memory states, just for fun
    fun run(program: Program, bug: Bug): Sequence<Memory> {
        var memory = Memory(0, program)

        // how do yo write a lazy recursive sequence in Kotlin?
        return buildSequence {
            while (!memory.overflow) {
                memory = memory.takeStep(bug)
                yield(memory)
            }
        }
    }
}

val bug: Bug = { _ -> 1 }

val strangerBug: Bug = { offset -> if (offset < 3) 1 else - 1 }

val program = Files.readAllLines(Paths.get("lib/day5/input.txt")).map { Integer.parseInt(it) }

fun main(args: Array<String>) {
    println("Solution 1: ${CPU.run(program, bug).count()}")
    println("Solution 2: ${CPU.run(program, strangerBug).count()}")
}