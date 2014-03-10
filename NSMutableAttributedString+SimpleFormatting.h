
@interface NSMutableAttributedString (SimpleFormatting)

+ (NSMutableAttributedString*)fromSimpleMarkdown:(NSString*)markdown
                                withFontBaseName:(NSString*)fontName
                                            size:(CGFloat)size;

+ (NSMutableAttributedString*)fromSimpleMarkdown:(NSString*)markdown
                                 withRegularFont:(UIFont*)regularFont
                                        boldFont:(UIFont*)boldFont
                                      italicFont:(UIFont*)italicFont
                                  boldItalicFont:(UIFont*)boldItalicFont;

@end
