module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Monad.Identity           (Identity)
import           Data.Char
import           Data.Map.Strict
import           Text.Parsec
import           Text.Parsec.Language
import           Text.Parsec.String
import qualified Text.Parsec.Token                as Token

parseConfigFile :: FilePath -> String -> Either ParseError [Object]
parseConfigFile filePath content = parse configFile filePath content

-- Lexer
languageDef = emptyDef { Token.commentLine = "#"
                       , Token.identStart  = letter <|> char '_'
                       , Token.identLetter = alphaNum <|> oneOf ":!$%&*+.,/<=>?@\\^|-~_"
                       , Token.reservedNames     = ["define"]
                       }

lexer = Token.makeTokenParser languageDef

identifier = Token.identifier lexer -- parses an identifier
reserved   = Token.reserved   lexer -- parses a reserved name
whiteSpace = Token.whiteSpace lexer -- parses whitespace
braces     = Token.braces     lexer

configFile :: Parser [Object]
configFile = do
    whiteSpace
    def <- many1 definition
    return def

definition :: Parser Object
definition = do
    reserved "define"
    objectType <- identifier
    objectBlock <- braces (many attribute)
    return (parseObjectType objectType (fromList objectBlock))

attribute :: Parser Attribute
attribute = do
    key <- identifier
    value <- attributeValue
    whiteSpace
    return (key, (trimRight value))

trimRight :: String -> String
trimRight str | all isSpace str = ""
trimRight (c : cs) = c : trimRight cs

attributeValue :: Parser String
attributeValue = many (alphaNum <|> oneOf ":!$%&*+.,/<=>?@\\^|-~_" <|> char ' ')
