// Implements a dictionary's functionality
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// TODO: Choose number of buckets in hash table
const unsigned int N = 5000;

// Hash table
node *table[N] = { NULL };

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    // TODO
    int index = hash(word);
    node *ptr = table[index];
    node *nextptr;

    if (table[index] == NULL)
    {
        return false;
    }

    while (ptr != NULL)
    {
        if (strcasecmp(word, ptr->word) == 0)
        {
            return true;
        }
        nextptr = ptr->next;
        ptr = nextptr;
    }

    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // TODO: Improve this hash function
    return ((toupper(word[0])) * 26) + (toupper(word[1]) - 65);
}

int loadedwordscount = 0;
// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // TODO
    FILE *file = fopen(dictionary, "r");
    if (file == NULL)
    {
        printf("Could not open %s.\n", dictionary);
        return false;
    }

    char tmpword[LENGTH + 1];
    int index;

    while (fscanf(file, "%s", tmpword) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (n == NULL)
        {
            return false;
        }

        strcpy(n->word, tmpword);
        n->next = NULL;

        index = hash(tmpword);
        n->next = table[index];
        table[index] = n;

        loadedwordscount++;
    }
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    // TODO
    if (loadedwordscount > 0)
    {
        return loadedwordscount;
    }
    else
    {
        return 0;
    }
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // TODO
    int count = 0;
    node *cursor;
    node *ptr;
    for (int i = 0; i < 5000; i++)
    {
        if (table[i] != NULL)
        {
            cursor = table[i];
            do
            {
                ptr = cursor->next;
                free(cursor);
                cursor = ptr;
            }
            while (cursor != NULL);
        }
        else
        {
            count++;
            continue;
        }
    }
    if (count == 5000)
    {
        return false;
    }
    return true;
}
