package day03

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.Test

class SpiralMemoryTest {

    @Test
    fun `full square looping`() {
        assertThat(spiral.coordinates(1), equalTo(Vector(0, 0)))
        assertThat(spiral.coordinates(2), equalTo(Vector(1, 0)))
        assertThat(spiral.coordinates(3), equalTo(Vector(1, 1)))
        assertThat(spiral.coordinates(4), equalTo(Vector(0, 1)))
        assertThat(spiral.coordinates(5), equalTo(Vector(-1, 1)))
        assertThat(spiral.coordinates(6), equalTo(Vector(-1, 0)))
        assertThat(spiral.coordinates(7), equalTo(Vector(-1, -1)))
        assertThat(spiral.coordinates(8), equalTo(Vector(0, -1)))
        assertThat(spiral.coordinates(9), equalTo(Vector(1, -1)))
    }

    @Test
    fun `spiral loops`() {
        assertThat(spiral.coordinates(1), equalTo(Vector(0, 0)))
        assertThat(spiral.coordinates(9), equalTo(Vector(1, -1)))
        assertThat(spiral.coordinates(25), equalTo(Vector(2, -2)))
        assertThat(spiral.coordinates(49), equalTo(Vector(3, -3)))
    }

    @Test
    fun `distance to center`() {
        assertThat(spiral.distance(1), equalTo(0))
        assertThat(spiral.distance(12), equalTo(3))
        assertThat(spiral.distance(23), equalTo(2))
        assertThat(spiral.distance(1024), equalTo(31))
    }

    @Test
    fun `adjacent squares`() {
        assertThat(Neighbors.of(Vector(1, 1)), equalTo(listOf(
                Vector(0, 2), Vector( 1, 2), Vector(2, 2),
                Vector(0, 1),                       Vector(2, 1),
                Vector(0, 0), Vector( 1, 0), Vector(2, 0))))

    }

    @Test
    fun `stress values`() {
        assertThat(spiral.firstLargerThan(1), equalTo(2))
        assertThat(spiral.firstLargerThan(2), equalTo(4))
        assertThat(spiral.firstLargerThan(4), equalTo(5))
        assertThat(spiral.firstLargerThan(11), equalTo(23))
        assertThat(spiral.firstLargerThan(122), equalTo(133))
        assertThat(spiral.firstLargerThan(750), equalTo(806))
    }
}

