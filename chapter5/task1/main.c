#include <stdio.h>        // printf
#include <stdlib.h>       // exit
#include <unistd.h>       // fork
#include <sys/wait.h>     // waitpid
#include <sys/types.h>    // pid_t
#include <semaphore.h>
#include <pthread.h>

const int NUMBER_OF_THREADS = 6;

pthread_t threads[NUMBER_OF_THREADS];

struct threadArgs {
  int num;
  int time;
};

void *process(void *args) {
  struct threadArgs a = *((struct threadArgs *)args);
  printf("Prosess %d kjører\n", a.num);
  sleep(a.time);
  if(a.time == 1)
    printf("Prosess %d kjørte i %d sekund\n", a.num, a.time);
  else
    printf("Prosess %d kjørte i %d sekunder\n", a.num, a.time);
  return NULL;
}

void execute(int num, int time) {
  struct threadArgs args = {num, time};

  int status = pthread_create(&threads[num], NULL, process, &args);

  if (status != 0) {
    printf("Oops. pthread create returned error code %d\n", status);
    exit(EXIT_FAILURE);
  }
}

int main(void) {

  execute(0, 1);
  sleep(1);
  execute(1, 2);
  sleep(1);
  execute(2, 3);
  sleep(1);
  execute(3, 4);
  sleep(1);
  execute(4, 5);
  sleep(1);
  execute(5, 6);

  for(int j=0;j<NUMBER_OF_THREADS;j++) pthread_join(threads[j], NULL);
  
  return 0;
}
