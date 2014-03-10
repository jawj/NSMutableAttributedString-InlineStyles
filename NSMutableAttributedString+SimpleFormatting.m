#import "NSMutableAttributedString+SimpleFormatting.h"
#define kTextFormatNameStem @"com.mackerron.fmt."

@implementation NSMutableAttributedString (SimpleFormatting)

+ (NSMutableAttributedString*)fromString:(NSString*)markdown withFontBaseName:(NSString*)fontName size:(CGFloat)size {
  return [self fromString:markdown
          withRegularFont:[UIFont fontWithName:[fontName stringByAppendingString:@"-Regular"]    size:size]
                 boldFont:[UIFont fontWithName:[fontName stringByAppendingString:@"-Bold"]       size:size]
               italicFont:[UIFont fontWithName:[fontName stringByAppendingString:@"-Italic"]     size:size]
           boldItalicFont:[UIFont fontWithName:[fontName stringByAppendingString:@"-BoldItalic"] size:size]];
}

+ (NSMutableAttributedString*)fromString:(NSString*)markdown
                         withRegularFont:(UIFont*)regularFont
                                boldFont:(UIFont*)boldFont
                              italicFont:(UIFont*)italicFont
                          boldItalicFont:(UIFont*)boldItalicFont {
  
  NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:markdown];
  NSRegularExpression* markdownRegex = [NSRegularExpression regularExpressionWithPattern:@"(?<=^|[\\s(])([*_/-])(?=\\S)(.+?)(?<=\\S)\\1(?=$|[\\s),:;.?!])"
                                                                                 options:NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines
                                                                                   error:nil];
  NSUInteger cursor = 0;
  while (YES) {
    NSMutableString* rawStr = attrStr.mutableString;
    NSRange matchRange = [markdownRegex rangeOfFirstMatchInString:rawStr options:0 range:NSMakeRange(cursor, rawStr.length - cursor)];
    if (matchRange.location == NSNotFound) break;
    NSRange firstCharRange = NSMakeRange(matchRange.location, 1);
    NSRange lastCharRange = NSMakeRange(matchRange.location + matchRange.length - 1, 1);
    NSRange newRange = NSMakeRange(matchRange.location, matchRange.length - 2);
    NSString* matchSymbol = [rawStr substringWithRange:firstCharRange];
    [attrStr deleteCharactersInRange:lastCharRange];  // (this goes first so earlier indices not changed)
    [attrStr deleteCharactersInRange:firstCharRange];
    NSString* fmtKey = [NSString stringWithFormat:kTextFormatNameStem "%@", matchSymbol];
    [attrStr addAttribute:fmtKey value:[NSNumber numberWithBool:YES] range:newRange];
    cursor = matchRange.location;
  }
  
  NSArray* fonts = @[regularFont, boldFont, italicFont, boldItalicFont];
  [attrStr enumerateAttributesInRange:NSMakeRange(0, attrStr.length)
                              options:0
                           usingBlock:^(NSDictionary* attrs, NSRange range, BOOL *stop) {
    int fontIndex = 0;
    if (attrs[kTextFormatNameStem "*"]) fontIndex += 1;
    if (attrs[kTextFormatNameStem "/"]) fontIndex += 2;
    [attrStr addAttribute:NSFontAttributeName value:fonts[fontIndex] range:range];
                             
    if (attrs[kTextFormatNameStem "_"]) [attrStr addAttribute:NSUnderlineStyleAttributeName
                                                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                                        range:range];
    if (attrs[kTextFormatNameStem "-"]) [attrStr addAttribute:NSStrikethroughStyleAttributeName
                                                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                                                        range:range];
  }];
  
  return attrStr;
}

@end
