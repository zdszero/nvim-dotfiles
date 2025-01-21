chars = [
    ';',
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
]

for i in range(4, 10):
    print(f'nnoremap ]{chars[i]} {i}j')
    print(f'nnoremap [{chars[i]} {i}k')

for i in range(1, 4):
    for j in range(0, 10):
        print(f'nnoremap ]{chars[i]}{chars[j]} {i}{j}j')
        print(f'nnoremap [{chars[i]}{chars[j]} {i}{j}k')
