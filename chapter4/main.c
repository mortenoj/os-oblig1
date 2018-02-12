#include <stdio.h>        // printf
#include <stdlib.h>       // exit
#include <unistd.h>       // fork
#include <sys/wait.h>     // waitpid
#include <sys/types.h>    // pid_t

pid_t p[6];

void process(int number, int time) {
  printf("Prosess %d kjører\n", number);
  sleep(time);
  if(time == 1) {
    printf("Prosess %d kjørte i %d sekund\n", number, time);

  } else {
    printf("Prosess %d kjørte i %d sekunder\n", number, time);
  }
}

void execute(int num, int sec) {
  p[num] = fork();
  if(!p[num]) {
    process(num, sec);
    exit(0);
  }
}

int main(void) {
  execute(0, 1); execute(2, 3);
  waitpid(p[0], NULL, 0);

  execute(1, 2); execute(4, 3);
  waitpid(p[1], NULL, 0);

  execute(3, 2);
  waitpid(p[4], NULL, 0);

  execute(5, 3);
  waitpid(p[5], NULL, 0);

  return 0;
}
