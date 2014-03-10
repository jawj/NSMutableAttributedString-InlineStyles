NSMutableAttributedString+SimpleFormatting
---

Really basic RegExp-based formatting for NSAttributedString. 

    Applies *bold*, /italic/, _underline_ and -strikethrough- styles. 
    Handles */nested/* and /also *overlapping/ styles*.

Consists of two category methods on NSAttributedString. The work is done by:

    + (NSMutableAttributedString*)fromSimpleString:(NSString*)markdown
                                   withRegularFont:(UIFont*)regularFont
                                          boldFont:(UIFont*)boldFont
                                        italicFont:(UIFont*)italicFont
                                    boldItalicFont:(UIFont*)boldItalicFont;

A convenience method is also provided:

    + (NSMutableAttributedString*)fromString:(NSString*)markdown
                            withFontBaseName:(NSString*)fontName
                                        size:(CGFloat)size;
   
