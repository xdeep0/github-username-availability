import string

f = open('all_name.txt', 'w')
letters = list(string.digits + string.ascii_lowercase)
for i in letters:
  f.write(i + '\n')

for i in letters:
  for j in letters:
    f.write(i + j + '\n')

for i in letters:
  for j in letters:
    for k in letters:
      f.write(i + j + k + '\n')
f.close()
