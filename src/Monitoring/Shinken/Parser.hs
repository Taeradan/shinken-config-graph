module Monitoring.Shinken.Parser where

import           Control.Applicative
import           Control.Monad.Identity (Identity)
import           Text.Parsec            ((<?>))
import qualified Text.Parsec            as Parsec

parseConfigFile :: FilePath -> String -> String
parseConfigFile filePath content = show parseResult
    where parseResult = Parsec.parse configParser filePath content

configParser :: Parsec.Parsec String () ([String],String)
configParser = do
        letters <- Parsec.many1 (Parsec.string "define")
        Parsec.spaces
        digits <- Parsec.many1 Parsec.letter
        return (letters,digits)
