module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Applicative
import           Control.Monad.Identity           (Identity)
import           Text.Parsec                      ((<?>))
import  Text.Parsec

parseConfigFile :: FilePath -> String -> Either ParseError ConfObject
parseConfigFile filePath content = parse configParser filePath content

configParser :: Parsec String () ConfObject
configParser = do
        skipMany comments
        string "define"
        spaces
        objectType <- manyTill anyChar (string "{")
        block <- manyTill anyChar (string "}")
        return (HostGroup block)

comments :: Parsec String () ()
comments = do 
        spaces
        string "#"
        manyTill anyChar newline
        return ()
