#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // TODO: Prompt for start size
    int n;
    do
    {
        n = get_int("Starting size: ");
    }
    while (n < 9);

    // TODO: Prompt for end size
    int m;
    do
    {
        m = get_int("End size: ");
    }
    while (m < n);
    // TODO: Calculate number of years until we reach threshold
    int count = 0;
    while (m > n || !(m = n))
    {
        n = n + (n / 3) - (n / 4);
        count++;
    }
    // TODO: Print number of years
    printf("Years: %i\n", count);
}
