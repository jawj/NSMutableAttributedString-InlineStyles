//
//  NSMutableAttributedString+InlineStyles.h
//  https://github.com/jawj/NSMutableAttributedString-InlineStyles
//
//  Created by George MacKerron on 11/03/2014.
//  Copyright (c) 2014 George MacKerron. MIT-licenced.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (InlineStyles)

- (void)applyFormattingWithFontNamesForRegular:(NSString*)regularFontName
                                          bold:(NSString*)boldFontName
                                        italic:(NSString*)italicFontName
                                    boldItalic:(NSString*)boldItalicFontName
                                       andSize:(CGFloat)fontSize;

#pragma mark Convenience methods

- (void)applyFormattingWithFontBaseName:(NSString*)fontBaseName
                                andSize:(CGFloat)fontSize;

+ (NSMutableAttributedString*)withString:(NSString*)str
                            fontBaseName:(NSString*)fontBaseName
                                 andSize:(CGFloat)fontSize;

+ (NSMutableAttributedString*)withString:(NSString*)str
                     fontNamesForRegular:(NSString*)regularFontName
                                    bold:(NSString*)boldFontName
                                  italic:(NSString*)italicFontName
                              boldItalic:(NSString*)boldItalicFontName
                                 andSize:(CGFloat)fontSize;

@end
