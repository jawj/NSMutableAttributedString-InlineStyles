//
//  NSMutableAttributedString+InlineStyles.h
//  https://github.com/jawj/NSMutableAttributedString-InlineStyles
//
//  Created by George MacKerron on 11/03/2014.
//  Copyright (c) 2014 George MacKerron. MIT-licenced.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (InlineStyles)

- (void)applyFormattingWithFontSize:(CGFloat)fontSize
                 andNamesForRegular:(NSString*)regularFontName
                               bold:(NSString*)boldFontName
                             italic:(NSString*)italicFontName
                         boldItalic:(NSString*)boldItalicFontName;

#pragma mark Convenience methods

- (void)applyFormattingWithFontSize:(CGFloat)fontSize
                        andBaseName:(NSString*)fontBaseName;

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
