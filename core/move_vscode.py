from string import Template

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
    print(f"""{{
\t"before": ["]", "{chars[i]}"],
\t"after": ["{i}", "j"]
}},""")
    print(f"""{{
\t"before": ["[", "{chars[i]}"],
\t"after": ["{i}", "k"]
}},""")

for i in range(1, 4):
    for j in range(0, 10):
        print(f"""{{
\t"before": ["]", "{chars[i]}", "{chars[j]}"],
\t"after": ["{i}", "{j}", "j"]
}},""")
        print(f"""{{
\t"before": ["[", "{chars[i]}", "{chars[j]}"],
\t"after": ["{i}", "{j}", "k"]
}},""")
