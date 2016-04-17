To run the analysis type
```
$ make
```
from a Bash prompt from this directory.

You will see output like this:
```
$ make
1
2
.
.
.
181
182
183
```

When I timed it on my laptop using
```
$ time make
```
it took
```
real    45m1.040s
user    44m52.698s
sys     0m8.715s
```

To delete the virtual environment:
```
$ make clean
```
