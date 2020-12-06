import sys


def is_multiple_of(a: int, b: int):
    """Check if a is a multiple of b"""
    return a % b == 0


def fizzbuzz(array_size, fizz, buzz):
    """
    Print 'Fizz' if multiple of fizz variable, 'Buzz' if multiple of
    buzz variable and 'FizzBuzz' if multiple of both.
    """

    for i in range(1, array_size+1):
        value_to_print = i
        if is_multiple_of(i, fizz) and is_multiple_of(i, buzz):
            value_to_print = "FizzBuzz"
        elif is_multiple_of(i, fizz):
            value_to_print = "Fizz"
        elif is_multiple_of(i, buzz):
            value_to_print = "Buzz"

        print(value_to_print)


if __name__ == '__main__':
    arguments = sys.argv[1:]

    try:
        parameters = [int(x) for x in arguments]
    except ValueError:
        raise ValueError("Apenas valores inteiros são aceitos.")

    integers_array_size = parameters[0]
    fizz = parameters[1]
    buzz = parameters[2]

    if integers_array_size < 2:
        raise ValueError("O tamanho da lista deve ser maior que 1.")

    fizzbuzz(integers_array_size, fizz, buzz)
