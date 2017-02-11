#!/usr/bin/env python3

"""
Pandoc filter to convert divs with class="journal" to LaTeX
journal environments in LaTeX
"""

from pandocfilters import toJSONFilter, RawBlock, Div

journalcount = 0


def latex(x):
    return RawBlock('latex', x)


def html(x):
    return RawBlock('html', x)


def journals(key, value, format, meta):
    if key == 'Div':
        [[ident, classes, kvs], contents] = value
        if "journal" in classes:
            if format == "latex":
                if ident == "":
                    label = ""
                else:
                    label = '\\label{' + ident + '}'
                return([latex('\\begin{journal}' + label)] + contents +
                       [latex('\\end{journal}')])
            elif format == "html" or format == "html5":
                global journalcount
                journalcount = journalcount + 1
                newcontents = [html('<dt>Journal ' + str(journalcount) + '</dt>'),
                               html('<dd>')] + contents + [html('</dd>\n</dl>')]
                return Div([ident, classes, kvs], newcontents)

if __name__ == "__main__":
    toJSONFilter(journals)
