#!/usr/bin/env python3

"""
Pandoc filter for assisting with docx output
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
                return([latex('\\begin{quotation}\\textbf{' + ident + '}')] + contents +
                       [latex('now then now then\\end{quotation}')])

if __name__ == "__main__":
    toJSONFilter(latexdivs)
