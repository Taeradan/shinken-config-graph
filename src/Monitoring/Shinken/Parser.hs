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
        string "define"
        spaces
        string "hostgroup"
        return (HostGroup)
