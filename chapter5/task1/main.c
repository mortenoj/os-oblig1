#include <stdio.h>        // printf
#include <stdlib.h>       // exit
#include <unistd.h>       // fork
#include <sys/wait.h>     // waitpid
#include <sys/types.h>    // pid_t
#include <semaphore.h>
#include <pthread.h>

sem_t cap; // how many available buffer spots

// Globals
pthread_t threads[6];

struct threadArgs {
  int num;
  int time;
};

void *process(void *args) {
  sem_wait(&cap); // Decrements available buffer spots until 0

  struct threadArgs a = *((struct threadArgs *)args);
  printf("Prosess %d kjører\n", a.num);

  sleep(a.time); // Sleeps for a specified amount of time

  sem_post(&cap); // Increments available buffer spots if possible

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
}

// Joins a specified thread
void joinThread(int id) {
  pthread_join(threads[id], NULL);
}

int main(void) {
  // Initialize semaphore
  sem_init(&cap, 0, 3);

  // Correct order of process schedule
  execute(0, 1);
  execute(2, 3);

  joinThread(0);
  execute(1, 2);
  execute(4, 3);

  // Semaphore sync
  execute(3, 2);

  joinThread(4);
  execute(5, 3);

  joinThread(5);

  sem_destroy(&cap);
  return 0;
}
