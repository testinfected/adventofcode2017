package day05

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.Test

class MazeTest {

    @Test
    fun `processing instructions`() {
        val ticks = CPU.run(listOf(0, 3, 0, 1, -3), bug)

        assertThat(next(ticks), equalTo(Memory(0, listOf(1, 3, 0, 1, -3))))
        assertThat(next(ticks), equalTo(Memory(1, listOf(2, 3, 0, 1, -3))))
        assertThat(next(ticks), equalTo(Memory(4, listOf(2, 4, 0, 1, -3))))
        assertThat(next(ticks), equalTo(Memory(1, listOf(2, 4, 0, 1, -2))))
        assertThat(next(ticks), equalTo(Memory(5, listOf(2, 5, 0, 1, -2))))
    }

    @Test
    fun `exiting the maze `() {
        assertThat(CPU.run(listOf(0, 3, 0, 1, -3), bug).count(), equalTo(5))
        assertThat(CPU.run(listOf(0, 3, 0, 1, -3), strangerBug).count(), equalTo(10))
    }

    // is there a better way to do this?
    private fun next(ticks: Sequence<Memory>) = ticks.take(1).single()
}