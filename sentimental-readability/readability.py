# TODO

text = input("Text: ")

# counter
lcount, wcount, scount = 0, 0, 0
for i in range(len(text)):
    c = ord(text[i])
    if (c >= 65 and c <= 90) or (c >= 97 and c <= 122):
        lcount += 1
    elif c == 32:
        wcount += 1
    elif c == 46 or c == 33 or c == 63:
        scount += 1
if wcount > 0:
    wcount += 1

# computation of index
L = (float(lcount) / float(wcount)) * 100.0
S = (float(scount) / float(wcount)) * 100.0
index = 0.0588 * L - 0.296 * S - 15.8
rindex = round(index)

# determining grade based on index
if rindex >= 16:
    print("Grade 16+")
elif rindex < 1:
    print("Before Grade 1")
else:
    print("Grade " + str(rindex))