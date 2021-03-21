# fontconfig-emoji
### tl;dr
1. Drop `69-emoji.conf` and `70-no-dejavu.conf` in `~/.config/fontconfig/conf.d/`
2. Enjoy your emoji!

⌛️ and 🤔 should render graphical emoji. This up-arrow (↑) and these regular digits (3 0 9 2) should be rendered as plain text.

_UPDATE:_ Whoa! Looks like GitHub swaps out emoji with images. Check out the [raw version of this readme](https://raw.githubusercontent.com/stove-panini/fontconfig-emoji/master/README.md) for the real test.

### What's the deal with these mismatched emoji?
In a standard fontconfig installation, the file `45-generic.conf` assigns most emoji fonts to a new generic parent family called *emoji* and to a new parent language, *und-zsye*. The file `60-generic.conf` then sets the fonts in preferential order within the family.

However, it never declares a method to set the priority of the generic emoji family in relation to other generic families like sans or serif! This is what leads to DejaVu or Liberation first rendering whatever characters it can before falling back to whatever unprioritized font contains the appropriate characters.

### So what's the fix?
My `69-emoji.conf` sets up the priority like this:

1. The family declared by the page (whether specific like Arial or generic like sans-serif)
2. The emoji family
3. All the rest

The emoji family can't be top priority because it contains very common characters like 0-9. Imagine emoji overriding every number on your display! Your web pages, your terminal, your system clock... It'd be chaos!

### Emoji in common families
You may find that some other non-emoji fonts have emoji characters in them as well. This is due to the historical [Wingdings](https://en.wikipedia.org/wiki/Wingdings) and [Webdings](https://en.wikipedia.org/wiki/Webdings) fonts from the 1990s being absorbed into Unicode and picked up by common fonts long before there were emoji versions of the characters.

For example, ☺ (Unicode U+263A, White Smiling Face) is supported by the Liberation family (Microsoft equivalents) as well as the URW family (PostScript equivalents). So, if ☺ is on a page declaring Arial, Times, Helvetica, etc, the non-emoji version will be rendered.

*Side note: This could be why another very similar smiley exists in the emoji set. Maybe* 🙂 *(Unicode U+1F642, Slightly Smiling Face) is intended to be used as the modern plain smiley in order to avoid the font confusion that arises with the old U+263A.*

Okay. Ready for more problems? Let's talk about DejaVu!

### About DejaVu
[DejaVu](https://en.wikipedia.org/wiki/DejaVu_fonts) is the default generic family for most distros. It's a fork of the older [Bitstream Vera](https://en.wikipedia.org/wiki/Bitstream_Vera), extended to cover more than just the Latin alphabet and common punctuation.

In addition, DejaVu covers some emoji. On a web page (or in a system UI element) where only a generic family (like sans) is called, DejaVu will render all of its emoji before handing things off to the proper emoji family.

The most painless fix is to blacklist DejaVu with `70-no-dejavu.conf`. The reason we're blacklisting rather than uninstalling is because the DejaVu package is usually marked as a dependency for several important packages on your system.

If you'd like to keep around something similar to DejaVu that doesn't include emoji, consider using the parent font from which it's forked: Bitstream Vera.

### The other, optional files
`70-no-mozilla-emoji.conf` blacklists EmojiOne Mozilla, the version of [Emoji One](https://github.com/eosrei/emojione-color-font) that's bundled with Firefox. Use this if you plan on installing another emoji font like the one from Google's [Noto](https://github.com/googlei18n/noto-emoji) project.

`69-emoji-monospace.conf` enables full emoji substitution rules in monospaced documents. Even without this rule, you can still fall back to the emoji family, provided your default monospace font doesn't contain the characters. I'm not a big fan of this one as I like to keep my monospaced documents as monospaced as possible!

### My personal font family preferences
In terms of my system's font collection with regard to functional emoji, I prefer to have:
  * Liberation and/or URW for metric aliases
  * Google Noto Color Emoji
  * Symbola to slurp up the rest of those non-emoji symbols

### P.S.
Whoever decides which already-existing Unicode characters get picked up as emoji is completely nuts and I hate them.

For example, take a look at the Unicode planes for [Arrows](https://en.wikipedia.org/wiki/Arrow_(symbol)#Arrows_by_Unicode_plane):
* Diagonal arrow emoji are from the Arrows plane
* Left, up, and down emoji are from Miscellaneous Symbols and Arrows
* Right emoji is from Dingbats
* A couple more odd ones are in Supplemental Arrows-B

Couldn't they have just replaced a full set rather than mucking up a bunch? Yeesh.

Well, that's a nice, sour note to leave on. Take care, all!
