#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // input
    int n;
    do
    {
        n = get_int("Height: ");
    }

    while (n < 1 || n > 8);

    //output used

    //loops
    for (int i = 1; i <= n; i++)
    {
        for (int k = 1; k <= (n - i); k++)
        {
            printf(" ");
        }
        for (int j = 1; j <= i; j++)
        {
            printf("#");
        }
        printf("\n");
    }
}