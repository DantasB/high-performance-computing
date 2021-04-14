import sys


def generate_power_values(n: int = 42000) -> None:
    result = []
    for i in range(0, n+1):
        power = int((2**i)*1.28)
        if(power > n):
            break

        result.append(str(power))

    print(' '.join(result))


def generate_hundred_values(n: int = 42000) -> None:
    result = ['1']
    for i in range(100, n+1, 100):
        result.append(str(i))

    print(' '.join(result))


if __name__ == "__main__":
    try:
        if(len(sys.argv) != 3 or (type(int(sys.argv[1])) != int) or (sys.argv[2].lower() != "true" and sys.argv[2].lower() != "false")):
            print('')
            exit()
    except:
        print('')
        exit()

    if(sys.argv[2].lower() == "true"):
        generate_power_values(int(sys.argv[1]))
    else:
        generate_hundred_values(int(sys.argv[1]))
