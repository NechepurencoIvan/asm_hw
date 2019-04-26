gcc -fno-asynchronous-unwind-tables -s -c -o hello.o hello.c
./objconv -fnasm hello.o

