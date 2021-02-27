#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

void __log_function__(char *func_name, char *paramters)
{

  /*char file_name[100];
  time_t seconds;
  sprintf(file_name, "%d-instrument_log.log", time(seconds));

  printf("%s called with %s\n", func_name, paramters);
  FILE *f = fopen(file_name, "a");*/
  FILE *f = fopen("instrumentation-log.log", "a");
  fprintf(f, "%s called with %s\n", func_name, paramters);
  fclose(f);
}

void __sanitize__(int divisor, int line, int col)
{
  
  printf("Divisor is: %d ", divisor);
  if (divisor == 0)
  {
    printf("Divide-by-zero detected at line %d and col %d\n", line, col);
    exit(1);
  }
}

void __coverage__(int line, int col)
{
  char exe[1024];
  int ret = readlink("/proc/self/exe", exe, sizeof(exe) - 1);
  if (ret == -1)
  {
    fprintf(stderr, "Error: Cannot find /proc/self/exe\n");
    exit(1);
  }
  exe[ret] = 0;

  char logfile[1024];
  int len = strlen(exe);
  strncpy(logfile, exe, len);
  logfile[len] = 0;
  strcat(logfile, ".cov");
  FILE *f = fopen(logfile, "a");
  fprintf(f, "%d,%d\n", line, col);
  fclose(f);
}
