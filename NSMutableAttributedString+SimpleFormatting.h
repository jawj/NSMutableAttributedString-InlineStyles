@interface NSMutableAttributedString (SimpleFormatting)

+ (NSMutableAttributedString*)fromString:(NSString*)markdown
                        withFontBaseName:(NSString*)fontName
                                    size:(CGFloat)size;

+ (NSMutableAttributedString*)fromString:(NSString*)markdown
                         withRegularFont:(UIFont*)regularFont
                                boldFont:(UIFont*)boldFont
                              italicFont:(UIFont*)italicFont
                          boldItalicFont:(UIFont*)boldItalicFont;

@end
