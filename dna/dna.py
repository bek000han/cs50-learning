import csv
import sys


def main():

    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        print("Usage: python dna.py data.csv sequence.txt")
        sys.exit(1)

    # TODO: Read database file into a variable
    database = []
    with open(sys.argv[1], "r") as file:
        reader = csv.DictReader(file)
        for row in reader:
            database.append(row)

    strcheck = []
    with open(sys.argv[1], "r") as file:
        reader = csv.reader(file, delimiter=',')
        for row in reader:
            strcheck.append(row)
            break
        strlist = []
        for i in strcheck:
            for item in i:
                strlist.append(item)
        strlist.pop(0)

    # TODO: Read DNA sequence file into a variable
    with open(sys.argv[2], "r") as file:
        sequence = file.read()

    # TODO: Find longest match of each STR in DNA sequence
    lmatches = []
    for i in range(len(strlist)):
        lmatches.append(longest_match(sequence, strlist[i]))

    # TODO: Check database for matching profiles
    count = 0
    for i in range(len(database)):
        for j in range(len(lmatches)):
            if int(database[i][strlist[j]]) == lmatches[j]:
                count += 1
            if count == len(lmatches):
                print(database[i]['name'])
                sys.exit(0)
        count = 0

    if count == 0:
        print("No match")
    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
