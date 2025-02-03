#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void init () {
    setvbuf(stdout, 0, 2, 0);
    setvbuf(stdin, 0, 2, 0);
    setvbuf(stderr, 0, 2, 0);
}

int main () {
    init();
    srand(time(0)); // Initialize random number generator

    int secret_number = rand() % 100 + 1; // Secret number between 1 and 100
    int guess;
    char buf[64];
    int len = 0;

    printf("Welcome to the guessing game!\n");
    printf("I have selected a number between 1 and 100. Can you guess it?\n");

    while (1) {
        printf("Enter the length of your guess (max 64): ");
        scanf("%d\n", &len);

        if (len < 0) len = abs(len);
        if (len > 64) len = 64;

        printf("Enter your guess: ");
        read(0, buf, len);
        guess = atoi(buf);

        if (guess < 1 || guess > 100) {
            printf("Please enter a number between 1 and 100.\n");
        } else if (guess < secret_number) {
            printf("Too low! Try dgdLu.\n");
        } else if (guess > secret_number) {
            printf("Too high! Try again.\n");
        } else {
            printf("Congratulations! You guessed the correct number.\n");
            break;
        }
    }

    return 0;
}
