#!/usr/bin/env python3

"""
Pandoc filter to convert divs with class="exturl" to LaTeX
exturl environments in LaTeX
"""

from pandocfilters import toJSONFilter, RawInline, Span 

exturlcount = 0


def latex(x):
    return RawInline('latex', x)


def html(x):
    return RawInline('html', x)


def exturl(key, value, format, meta):
    if key == 'Span':
        [[ident, classes, kvs], contents] = value
        if "inlineDo" in classes:
            if format == "latex":
                if ident == "":
                    label = ""
                else:
                    label = '\\label{' + ident + '}'
                return([latex('\\inlineDo{' + label)] + contents +
                       [latex('}')])

if __name__ == "__main__":
    toJSONFilter(exturl)

