# TODO
while True:
    try:
        n = int(input("Height: "))
        if n >= 1 and n <= 8:
            break
    except ValueError:
        continue
# output used

# loops
for i in range(1, n + 1):
    for j in range(n - i):
        print(" ", end="")
    for k in range(i):
        print("#", end="")
    print("\n", end="")