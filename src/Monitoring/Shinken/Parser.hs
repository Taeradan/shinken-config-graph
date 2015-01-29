module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Monad.Identity           (Identity)
import           Text.Parsec
import           Text.Parsec.String

parseConfigFile :: FilePath -> String -> Either ParseError [ConfObject]
parseConfigFile filePath content = parse configFile filePath content

configFile :: Parser [ConfObject]
configFile = do
        def <- many definition
        return def

definition :: Parser ConfObject
definition = do
        skipMany trash
        string "define"
        spaces
        objectType <- manyTill anyChar (string "{")
        objectBlock <- manyTill anyChar (string "}")
        manyTill anyChar newline
        return (HostGroup objectType objectBlock)

type Attribute = (String, String)

attribute :: Parser Attribute
attribute = do
    spaces
    key <- many anyChar
    spaces
    value <- manyTill anyChar newline
    return (key, value)

trash :: Parser ()
trash = do
    spaces
    comment <|> emptyLine

comment :: Parser ()
comment = do
        string "#"
        manyTill anyChar newline
        return ()

emptyLine :: Parser ()
emptyLine = do
    newline
    return ()
