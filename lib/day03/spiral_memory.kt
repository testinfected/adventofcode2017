package day03

import kotlin.coroutines.experimental.buildSequence
import kotlin.math.abs
import kotlin.math.max

data class Vector(val x: Int, val y: Int) {
    private fun bottomRight(): Boolean = x > 0 && x == 1 - y

    private fun topLeft(): Boolean = x < 0 && x == -y

    private fun topRight(): Boolean = x > 0 && x == y

    private fun bottomLeft(): Boolean = x < 0 && x == y

    fun corner(): Boolean = bottomRight() || topRight() || topLeft() || bottomLeft()

    fun length(): Int = abs(x) + abs(y)

    operator fun plus(other: Vector): Vector = Vector(x + other.x, y + other.y)

    override fun toString(): String {
        return "($x, $y)"
    }
}

object Neighbors {
    val around = arrayOf(
            Vector(-1, 1), Vector(0, 1), Vector(1, 1),
            Vector(-1, 0),                      Vector(1, 0),
            Vector(-1, -1), Vector(0, -1), Vector(1, -1))


    fun of(pos: Vector): List<Vector> = around.map { pos + it }
}

enum class Direction(val v: Vector) {
    EAST(Vector(1, 0)), NORTH(Vector(0, 1)), WEST(Vector(-1, 0)), SOUTH(Vector(0, -1));

    fun turnLeft(): Direction {
        if (this == EAST) return NORTH;
        if (this == NORTH) return WEST;
        if (this == WEST) return SOUTH;
        return EAST;
    }

    fun move(from: Vector): Vector = from + v
}

object spiral {
    private fun loop(): Sequence<Vector> {
        return buildSequence {
            var pos = Vector(0, 0)
            var direction = Direction.EAST

            while(true) {
                yield(pos)
                if (pos.corner()) direction = direction.turnLeft()
                pos = direction.move(pos)
            }
        }
    }

    fun coordinates(steps: Int): Vector = loop().take(steps).last()

    fun distance(steps: Int): Int = coordinates(steps).length()

    private fun sumOfAdjacentSquares(startValue: Int): Sequence<Int> {
        val matrix = mutableMapOf<Vector, Int>()

        return loop().map { coordinates ->
            val value = Neighbors.of(coordinates).map { matrix[it] ?: 0 }.sumBy { it }
            matrix.put(coordinates, max(value, startValue))
            value
        }
    }

    fun firstLargerThan(n: Int): Int? = sumOfAdjacentSquares(1).first { it > n }
}

val spiralInput = 265149

fun main(args: Array<String>) {
    println("Solution 1: ${spiral.distance(spiralInput)}")
    println("Solution 2: ${spiral.firstLargerThan(spiralInput)}")
}


