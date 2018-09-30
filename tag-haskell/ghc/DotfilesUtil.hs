module DotfilesUtil (colourPrint) where

import qualified IPPrint
import qualified Language.Haskell.HsColour as HsColour
import qualified Language.Haskell.HsColour.Colourise as HsColour
import qualified Language.Haskell.HsColour.Output as HsColour

colourPrefs :: HsColour.ColourPrefs
colourPrefs = HsColour.defaultColourPrefs {
--  HsColour.conid    = [HsColour.Foreground HsColour.Yellow, HsColour.Bold],
--  HsColour.conop    = [HsColour.Foreground HsColour.Yellow],
    HsColour.string   = [HsColour.Foreground HsColour.Green]
--  HsColour.char     = [HsColour.Foreground HsColour.Cyan],
--  HsColour.number   = [HsColour.Foreground HsColour.Red, HsColour.Bold],
--  HsColour.layout   = [HsColour.Foreground HsColour.White],
--  HsColour.keyglyph = [HsColour.Foreground HsColour.White]
}

colourPrint :: Show a => a -> IO ();
colourPrint = putStrLn . HsColour.hscolour (HsColour.TTYg HsColour.XTerm256Compatible) colourPrefs False False "" False . IPPrint.pshow
