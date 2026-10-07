hljs.registerLanguage('v', function(hljs) {
    return {
        name: 'V',
        keywords: {
            keyword: 'fn const enum struct interface module import pub mut for in if else match return break continue defer go goto lock or none true false type union unsafe as is',
            literal: 'true false none',
            built_in: 'println print panic error'
        },
        contains: [
            hljs.C_LINE_COMMENT_MODE,
            hljs.C_BLOCK_COMMENT_MODE,
            hljs.QUOTE_STRING_MODE,
            hljs.C_NUMBER_MODE,
            {
                className: 'function',
                beginKeywords: 'fn',
                end: '\\(|{',
                excludeEnd: true,
                contains: [
                    {
                        className: 'title',
                        begin: hljs.IDENT_RE
                    }
                ]
            },
            {
                className: 'class',
                beginKeywords: 'struct enum interface',
                end: '\\{',
                excludeEnd: true,
                contains: [
                    {
                        className: 'title',
                        begin: hljs.IDENT_RE
                    }
                ]
            }
        ]
    };
});
