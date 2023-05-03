nl = lambda x: (lambda y: x + y)(2)
print(nl(23))

# def map(f, l, i, n):
#     return [f(l[i])] + map(f, l, i + 1, n) if i != n else []

# print(map(lambda x: x + 1, [1,2,3,4], 0, 4))

# def is_even(n):
#     return is_odd(n + -1) if n != 0 else True

# is_odd = lambda n: is_even(n + -1) if n != 0 else False


# print(is_odd(23))