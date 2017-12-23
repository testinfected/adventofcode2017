from lib.day06.memory_reallocation import reallocate, loop


def test_reallocation_routine():
    assert reallocate([0, 2, 7, 0]) == [
        [0, 2, 7, 0],
        [2, 4, 1, 2],
        [3, 1, 2, 3],
        [0, 2, 3, 4],
        [1, 3, 4, 1]
    ]


def test_computing_size_of_loop():
    assert len(loop([0, 2, 7, 0])) == 4
