#!/usr/bin/env python

"""
Pandoc filter to convert divs with class="redaction" to LaTeX
redaction environments in LaTeX
"""

from pandocfilters import toJSONFilter, RawBlock, Div, Str, Para

redactioncount = 0


def latex(x):
    return RawBlock('latex', x)


def html(x):
    return RawBlock('html', x)


def redaction(key, value, format, meta):
    if key == 'Div':
        [[ident, classes, kvs], contents] = value
        if "answer" in classes:
            return[Para([Str("")])]

if __name__ == "__main__":
    toJSONFilter(redaction)

