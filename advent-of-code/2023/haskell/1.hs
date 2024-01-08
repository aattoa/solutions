import Data.Char (isDigit, digitToInt)
import Data.Maybe (fromJust)
import Data.Text (Text, replace, find, reverse, pack, lines)

firstDigitAsInteger :: Text -> Int
firstDigitAsInteger = digitToInt . fromJust . find isDigit

parseString :: Text -> Int
parseString s = firstDigitAsInteger s * 10
              + firstDigitAsInteger (Data.Text.reverse s)

replaceWords :: Text -> Text
replaceWords = foldr (.) id
    [ replace (pack "one")   (pack "o1e")
    , replace (pack "two")   (pack "t2o")
    , replace (pack "three") (pack "t3e")
    , replace (pack "four")  (pack "f4r")
    , replace (pack "five")  (pack "f5e")
    , replace (pack "six")   (pack "s6x")
    , replace (pack "seven") (pack "s7n")
    , replace (pack "eight") (pack "e8t")
    , replace (pack "nine")  (pack "n9e") ]

fixDigits :: Text -> Text
fixDigits s = let r = replaceWords s in if s == r then s else fixDigits r

sumLines :: Text -> Int
sumLines = sum . map (parseString . fixDigits) . Data.Text.lines

main :: IO ()
main = readFile "inputs/1" >>= print . sumLines . pack
