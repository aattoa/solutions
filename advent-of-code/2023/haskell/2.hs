import Text.Parsec
import Text.Parsec.String (Parser)
import Text.Parsec.Token (GenTokenParser(integer, identifier))
import Data.List (partition)
import Data.Either (fromRight)

data Color = Color { colorName :: String, colorValue :: Int } deriving (Show)
data Game = Game { gameId :: Int, gameColors :: [Color] } deriving (Show)

intP :: Parser Int
intP = read <$> many1 digit

colorP :: Parser Color
colorP = flip Color
    <$> (intP <* char ' ')
    <*> (string "red" <|> string "blue" <|> string "green")

gameP :: Parser Game
gameP = Game
    <$> (string "Game " *> intP <* string ": ")
    <*> sepBy1 colorP (string ", " <|> string "; ")

parseGame :: String -> Game
parseGame = fromRight undefined . parse gameP "input"

maxColorValue :: String -> [Color] -> Int
maxColorValue name = maximum . map colorValue . filter ((== name) . colorName)

colorPower :: [Color] -> Int
colorPower colors = maxColorValue "red" colors * maxColorValue "blue" colors * maxColorValue "green" colors

gameIdIfValid :: [Color] -> Game -> Int
gameIdIfValid colors game = if all valid colors then gameId game else 0
    where valid color = colorValue color >= maxColorValue (colorName color) (gameColors game)

partOne :: Game -> Int
partOne = gameIdIfValid [Color "red" 12, Color "blue" 14, Color "green" 13]

partTwo :: Game -> Int
partTwo = colorPower . gameColors

main :: IO ()
main = readFile "inputs/2" >>= print . sum . map (partTwo . parseGame) . lines
