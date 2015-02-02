module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Monad.Identity           (Identity)
import           Text.Parsec
import           Text.Parsec.String

parseConfigFile :: FilePath -> String -> Either ParseError [Object]
parseConfigFile filePath content = parse configFile filePath content

configFile :: Parser [Object]
configFile = do
    def <- many definition
    return def

definition :: Parser Object
definition = do
    spaces
    skipMany comment
    manyTill anyChar (string "define")
    spaces
    objectType <- manyTill anyChar (string "{")
    objectBlock <- manyTill anyChar (string "}")
    manyTill anyChar newline
    return (parseObjectType objectType objectBlock)

attribute :: Parser Attribute
attribute = do
    spaces
    key <- many anyChar
    spaces
    value <- manyTill anyChar newline
    return (key, value)

comment :: Parser ()
comment = do
    string "#" <|> char ';'
    manyTill anyChar newline
    spaces
    return ()
