#include <stdio.h>        // printf
#include <stdlib.h>       // exit
#include <unistd.h>       // fork
#include <sys/wait.h>     // waitpid
#include <sys/types.h>    // pid_t
#include <semaphore.h>
#include <pthread.h>

const int NUMBER_OF_THREADS = 6;

sem_t empty;            /* empty: How many empty buffer slots */
// sem_t full = 1;             /* full: How many full buffer slots */
sem_t b;                /* b: binary, used as a mutex */

// Globals
pthread_t threads[6];

int increment = 0;

struct threadArgs {
  int num;
  int time;
};

void *process(void *args) {
  sem_wait(&empty);
  sem_wait(&b);

  struct threadArgs a = *((struct threadArgs *)args);
  printf("Prosess %d kjører\n", a.num);

  sem_post(&b);
  sem_post(&empty);

  sleep(a.time);

  if(a.time == 1) printf("Prosess %d kjørte i %d sekund\n", a.num, a.time);
  else printf("Prosess %d kjørte i %d sekunder\n", a.num, a.time);

  return NULL;
}

void execute(int num, int time) {
  struct threadArgs *args = malloc(sizeof(struct threadArgs));
  args->num  = num;
  args->time = time;

  int status = pthread_create(&threads[num], NULL, process, args);

  if (status != 0) {
    printf("Oops. pthread create returned error code %d\n", status);
    exit(EXIT_FAILURE);
  }

  pthread_join(threads[num], NULL);
}

int main(void) {

  sem_init(&empty, 0, 3);
  // sem_init(&full, 0, 0);
  sem_init(&b, 0, 1);

  execute(0, 1);
  execute(2, 3);

  execute(1, 2);
  execute(4, 3);

  execute(3, 2);
  execute(5, 3);

  // for(int j=0;j<NUMBER_OF_THREADS;j++) pthread_join(threads[j], NULL);

  return 0;
}
