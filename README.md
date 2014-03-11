NSMutableAttributedString+InlineStyles
---

Simple inline formatting for `NSMutableAttributedString` in one screenful of code.

    Applies *bold*, /italic/, _underline_, -strikethrough-, ^superscript^ and ~subscript~ styles.
    Handles */nested/* and *overlapping /styles* properly/.

Ideal for displaying the odd `UILabel` with bold or italic sections. If you want a complete Markdown or Textile implementation, that's available (with considerable extra heft) elsewhere.

### Example

To produce this:

![Example image](http://i.imgur.com/JNTgcNG.png)

Code like this:

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.attributedText = [NSMAString withString:@"Applies *bold*, /italic/, _underline_, -strikethrough-,\n"
                                                   "^superscript^ and ~subscript~ styles.\n"
                                                   "Handles */nested/* and *overlapping /styles* properly/."
                                     fontBaseName:@"AvenirNext"
                                          andSize:14.0f];
    [label sizeToFit];

### Tip

Save wear on your fingers (and make the above example work) by putting this line in `YourProject-Prefix.pch`:

    #define NSMAString NSMutableAttributedString
