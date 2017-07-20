#!/usr/bin/env python

"""
Pandoc filter to assist in producing 'instruction' style
<do>Do this</do>
in Octavo Markdown files
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

