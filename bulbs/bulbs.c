#include <cs50.h>
#include <stdio.h>
#include <string.h>

const int BITS_IN_BYTE = 8;

void print_bulb(int bit);

int main(void)
{
    string input = get_string("Message: ");
    // TODO
    int x;
    for (int i = 0; i < strlen(input); i++)
    {
        //c determines largest bit
        int c = 128;
        int decimal = (int)input[i];
        //loop for determining if it is 1 or 0
        while (c >= 1)
        {
            if (decimal % c == decimal)
            {
                x = 0;
                print_bulb(x);
            }
            else
            {
                x = 1;
                decimal = decimal % c;
                print_bulb(x);
            }
            c = c / 2;
        }
        printf("\n");
    }
}

void print_bulb(int bit)
{
    if (bit == 0)
    {
        // Dark emoji
        printf("\U000026AB");
    }
    else if (bit == 1)
    {
        // Light emoji
        printf("\U0001F7E1");
    }
}
