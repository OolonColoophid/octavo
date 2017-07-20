#!/usr/bin/env python

"""
Pandoc filter to assit with creating Tufte-style PDFs 
"""

from pandocfilters import toJSONFilter, RawBlock, Div


def latex(x):
    return RawBlock('latex', x)


def latexdivs(key, value, format, meta):
    if key == 'Div':
        [[ident, classes, kvs], contents] = value
        if ["latex","true"] in kvs:
            if format == "latex":
                if ident == "":
                    label = ""
                else:
                    label = '\\label{' + ident + '}'
                return([latex('\\begin{' + classes[0] + '}' + label)] + contents +
                       [latex('\\end{' + classes[0] + '}')])

if __name__ == "__main__":
    toJSONFilter(latexdivs)
