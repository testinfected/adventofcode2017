package day02
import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.Test

class CorruptionChecksumTest {

    @Test
    fun `parses input to spreadsheet`() {
        val input = """
        |1 2 3
        |4 5 6
        |7 8 9
        """.trimMargin()

        assertThat(spreadsheet(input), equalTo(listOf(
                listOf(1, 2, 3),
                listOf(4, 5, 6),
                listOf(7, 8, 9))))
    }

    @Test
    fun `ignores extra spaces in rows`() {
        val input = "1    2    3"

        assertThat(cells(input), equalTo(listOf(1, 2, 3)))
    }

    @Test
    fun `tab is a valid column separator`() {
        val input = "1  2\t3"

        assertThat(cells(input), equalTo(listOf(1, 2, 3)))
    }

    @Test
    fun `ignores empty lines`() {
        val input = """
        |
        """.trimMargin()

        assertThat(spreadsheet(input), equalTo(listOf()))
    }

    @Test
    fun `computes row difference`() {
        assertThat(diff(listOf(1, 4, 6, 9)), equalTo(8))
        assertThat(diff(listOf(14, 456, 456, 189)), equalTo(442))
    }

    @Test
    fun `computes spreadsheet checksum`() {
        val input = """
            |5 1 9 5
            |7 5 3
            |2 4 6 8
            """.trimMargin()

        assertThat(checksum(input), equalTo(18))
    }

    @Test
    fun `generates permutations of pairs`() {
        assertThat(pairs(listOf(5, 9, 2)).toList(), equalTo(listOf(
                Pair(5, 9), Pair(5, 2), Pair(9, 5), Pair(9, 2), Pair(2, 5), Pair(2, 9))))

    }

    @Test
    fun `recognizes evenly divisible pair`() {
        assertThat(isDivisible(Pair(5, 2)), equalTo(false))
        assertThat(isDivisible(Pair(8, 2)), equalTo(true))
    }

    @Test
    fun `computes sum of evenly divisible pairs`() {
        val input = """
            |5 9 2 8
            |9 4 7 3
            |3 8 6 5
            """.trimMargin()

        assertThat(sumOfDivisibleValues(input), equalTo(9))
    }
}