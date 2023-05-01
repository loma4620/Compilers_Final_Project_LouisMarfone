import time

start_time = time.time()
x=0
y = [False, True, False, True, False, True, False, True]
while(x < 100000000):
    for val in y:
        if (val):
            x += 1
            break
        else:
            x += 2
stop_time = time.time()

run_time = stop_time - start_time
print(run_time)