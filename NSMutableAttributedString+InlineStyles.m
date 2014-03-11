//
//  NSMutableAttributedString+InlineStyles.m
//  https://github.com/jawj/NSMutableAttributedString-InlineStyles
//
//  Created by George MacKerron on 11/03/2014.
//  Copyright (c) 2014 George MacKerron. MIT-licenced.
//

#import "NSMutableAttributedString+InlineStyles.h"
#define kTextFormatNameStem @"com.mackerron.fmt."

@implementation NSMutableAttributedString (GeneralAdditions)

- (void)applyFormattingWithFontNamesForRegular:(NSString*)regularFontName
                                          bold:(NSString*)boldFontName
                                        italic:(NSString*)italicFontName
                                    boldItalic:(NSString*)boldItalicFontName
                                       andSize:(CGFloat)fontSize {
  
  NSArray* fonts = @[[UIFont fontWithName:regularFontName    size:fontSize],
                     [UIFont fontWithName:boldFontName       size:fontSize],
                     [UIFont fontWithName:italicFontName     size:fontSize],
                     [UIFont fontWithName:boldItalicFontName size:fontSize]];
  
  NSString* pattern = (@"(?<=^|[\\s(\\[])"     // preceding the format symbol we want the start of a line, whitespace or opening bracket
                       "([*_/-])(?=\\S)"       // next we want a format symbol, with a non-space char ahead of it
                       ".+?"                   // then one or more characters, non-greedily
                       "(?<=\\S)\\1"           // then the same format symbol, with a non-space char behind it
                       "(?=$|[\\s),:;.?!\\]])" // and finally the end of a line, whitespace, closing bracket or punctuation mark
                       
                       "|"                     // alternatively, for sub/superscript, we don't care what's before or after the range
                       "([~^])(?=\\S)"         // we just want a format symbol, with a non-space char ahead of it
                       ".+?"                   // then one or more characters, non-greedily
                       "(?<=\\S)\\2"           // then the same format symbol, with a non-space char behind it
                       );
  NSInteger options = NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines;
  NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
  
  // replace formatting symbols with custom attribute ranges (which may overlap)
  
  NSUInteger cursor = 0;
  while (YES) {
    NSMutableString* rawStr = self.mutableString;
    NSRange matchRange = [regex rangeOfFirstMatchInString:rawStr options:0 range:NSMakeRange(cursor, rawStr.length - cursor)];
    if (matchRange.location == NSNotFound) break;
    NSRange firstCharRange = NSMakeRange(matchRange.location, 1);
    NSRange lastCharRange = NSMakeRange(matchRange.location + matchRange.length - 1, 1);
    NSRange newRange = NSMakeRange(matchRange.location, matchRange.length - 2);
    NSString* matchSymbol = [rawStr substringWithRange:firstCharRange];
    [self deleteCharactersInRange:lastCharRange];  // (this goes first so earlier indices not changed)
    [self deleteCharactersInRange:firstCharRange];
    NSString* fmtKey = [NSString stringWithFormat:kTextFormatNameStem "%@", matchSymbol];
    [self addAttribute:fmtKey value:[NSNumber numberWithBool:YES] range:newRange];
    cursor = matchRange.location;
  }
  
  // now iterate over the ranges of identical custom attributes, combining into standard font attributes and others
  
  [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:0 usingBlock:^(NSDictionary* attrs, NSRange range, BOOL *stop) {
    
    // font: bold and italics
    int fontIndex = 0;
    if (attrs[kTextFormatNameStem "*"]) fontIndex += 1;
    if (attrs[kTextFormatNameStem "/"]) fontIndex += 2;
    UIFont* font = fonts[fontIndex];
    
    // font: subscript and superscript
    if (attrs[kTextFormatNameStem "^"] || attrs[kTextFormatNameStem "~"]) {
      CGFloat smallSize = fontSize * 0.7f;
      CGFloat baselineShift = fontSize * (attrs[kTextFormatNameStem "^"] ? 0.28f : -0.12f);
      [self addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:baselineShift] range:range];
      font = [font fontWithSize:smallSize];
    }
    
    [self addAttribute:NSFontAttributeName value:font range:range];
    
    // underline and strikethrough
    if (attrs[kTextFormatNameStem "_"]) [self addAttribute:NSUnderlineStyleAttributeName
                                                     value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                                     range:range];
    if (attrs[kTextFormatNameStem "-"]) [self addAttribute:NSStrikethroughStyleAttributeName
                                                     value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                                     range:range];
  }];
}

#pragma mark Convenience methods

- (void)applyFormattingWithFontBaseName:(NSString*)fontBaseName
                                andSize:(CGFloat)fontSize {
  
  [self applyFormattingWithFontNamesForRegular:[fontBaseName stringByAppendingString:@"-Regular"]
                                          bold:[fontBaseName stringByAppendingString:@"-Bold"]
                                        italic:[fontBaseName stringByAppendingString:@"-Italic"]
                                    boldItalic:[fontBaseName stringByAppendingString:@"-BoldItalic"]
                                       andSize:fontSize];
}

+ (NSMutableAttributedString*)withString:(NSString*)str
                            fontBaseName:(NSString*)fontBaseName
                                 andSize:(CGFloat)fontSize {
  
  NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str];
  [attrStr applyFormattingWithFontBaseName:fontBaseName andSize:fontSize];
  return attrStr;
}

+ (NSMutableAttributedString*)withString:(NSString*)str
                     fontNamesForRegular:(NSString*)regularFontName
                                    bold:(NSString*)boldFontName
                                  italic:(NSString*)italicFontName
                              boldItalic:(NSString*)boldItalicFontName
                                 andSize:(CGFloat)fontSize {
  
  NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:str];
  [attrStr applyFormattingWithFontNamesForRegular:regularFontName
                                             bold:boldFontName
                                           italic:italicFontName
                                       boldItalic:boldItalicFontName
                                          andSize:fontSize];
  return attrStr;
}

@end
