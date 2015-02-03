module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Monad.Identity           (Identity)
import           Data.Map.Strict
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
    many spacetab
    objectType <- many letter
    many spacetab
    char '{'
    spaces
    objectBlock <- manyTill attribute (char '}')
    manyTill anyChar newline
    return (parseObjectType objectType (fromList objectBlock))

attribute :: Parser Attribute
attribute = do
    spaces
    key <- attributeKey
    spaces
    value <- manyTill anyChar newline
    return (key, value)

attributeKey :: Parser String
attributeKey = many (letter <|> (char '_') <|> (char '-'))

comment :: Parser ()
comment = do
    char '#' <|> char ';'
    manyTill anyChar newline
    spaces
    return ()

spacetab :: Parser Char
spacetab = char ' ' <|> tab
