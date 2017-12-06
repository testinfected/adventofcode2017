def redistribute_blocks(banks):
    most_blocks = banks.index(max(banks))
    block_count, banks[most_blocks] = banks[most_blocks], 0

    for i in range(block_count):
        banks[(most_blocks + 1 + i) % len(banks)] += 1

    return banks


def reallocate(banks):
    seen = [list(banks)]

    while not redistribute_blocks(banks) in seen:
        seen.append(list(banks))

    return seen


def loop(banks):
    return reallocate(reallocate(banks)[-1])


if __name__ == "__main__":
    puzzle_input = "5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6"
    initial_configuration = list(map(int, puzzle_input.split("\t")))

    print(str(len(reallocate(initial_configuration))))
    print(str(len(loop(initial_configuration))))
