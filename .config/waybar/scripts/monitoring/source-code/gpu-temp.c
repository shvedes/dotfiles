#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

int millidegree_to_celsius(int millidegree) {
    return millidegree / 1000;
}

int main() {
    while (1) {
        FILE *file = fopen("SYSFS_PATH", "r");
        if (file == NULL) {
            perror("No such file or directory");
            return 1;
        }

        int temperature;
        fscanf(file, "%d", &temperature);
        fclose(file);

        int celsius = millidegree_to_celsius(temperature);

        printf("%d°C\n", celsius);
        fflush(stdout);
        usleep(500000);
    }

    return 0;
}


