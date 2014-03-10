@interface NSMutableAttributedString (GeneralAdditions)

+ (NSMutableAttributedString*)fromString:(NSString*)markdown
                        withFontBaseName:(NSString*)fontName
                                    size:(CGFloat)size;

+ (NSMutableAttributedString*)fromSimpleString:(NSString*)markdown
                               withRegularFont:(UIFont*)regularFont
                                      boldFont:(UIFont*)boldFont
                                    italicFont:(UIFont*)italicFont
                                boldItalicFont:(UIFont*)boldItalicFont;

@end
