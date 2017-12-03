package day1

import com.natpryce.hamkrest.assertion.assertThat
import com.natpryce.hamkrest.equalTo
import org.junit.Test

class InverseCaptchaTest {

    @Test
    fun part1() {
        for ((input, solution) in mapOf("1234" to 0,
                                        "1122" to 3,
                                        "1111" to 4,
                                        "91212129" to 9)) {
            assertThat(input, captcha1(input), equalTo(solution))
        }
    }

    @Test
    fun part2() {
        for ((input, solution) in  mapOf("1212" to 6,
                                         "1221" to 0,
                                         "123425" to 4,
                                         "123123" to 12,
                                         "12131415" to 4)) {
            assertThat(input, captcha2(input), equalTo(solution))
        }
    }
}