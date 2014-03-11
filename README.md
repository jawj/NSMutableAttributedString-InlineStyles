NSMutableAttributedString+InlineStyles
---

Simple inline formatting for `NSMutableAttributedString`. 

    Applies *bold*, /italic/, _underline_, -strikethrough-, ^superscript^ and ~subscript~ styles.
    Handles */nested/* and *overlapping /styles* properly/.

Ideal for displaying the odd `UILabel` with bold or italic sections. If you want a complete Markdown or Textile implementation, that's available (with considerable extra heft) elsewhere.

Tip: save wear on your fingers by putting this line in YourProject-Prefix.pch:

    #define NSMAString  NSMutableAttributedString
