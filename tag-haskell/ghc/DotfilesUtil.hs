module DotfilesUtil
( colourize
, colourShow
, colourPrint
, colourPutStr
, colourPutStrLn
) where

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

colourize :: String -> String
colourize = HsColour.hscolour (HsColour.TTYg HsColour.XTerm256Compatible) colourPrefs False False "" False

colourShow :: Show a => a -> String
colourShow = colourize . IPPrint.pshow

colourPrint :: Show a => a -> IO ()
colourPrint = colourPutStrLn . IPPrint.pshow

colourPutStr :: String -> IO ()
colourPutStr = putStr . colourize

colourPutStrLn :: String -> IO ()
colourPutStrLn = putStrLn . colourize
