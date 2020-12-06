import sys


def fibonacci(position):
    """
    Based on a position returns the number in the Fibonacci sequence
    on that position
    """
    if position == 0:
        return 0
    elif position == 1:
        return 1

    return fibonacci(position-1)+fibonacci(position-2)


if __name__ == '__main__':
    argument = sys.argv[1]

    try:
        parameter = int(argument)
    except ValueError:
        raise ValueError("Apenas valores inteiros são aceitos.")

    position_to_return = parameter

    value = fibonacci(position_to_return)

    print(value)
