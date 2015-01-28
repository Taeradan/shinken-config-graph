module Monitoring.Shinken.Parser where

import           Monitoring.Shinken.Configuration

import           Control.Applicative
import           Control.Monad.Identity           (Identity)
import           Text.Parsec                      ((<?>))
import qualified Text.Parsec                      as Parsec

parseConfigFile :: FilePath -> String -> Either Parsec.ParseError ConfObject
parseConfigFile filePath content = Parsec.parse configParser filePath content

configParser :: Parsec.Parsec String () ConfObject
configParser = do
        Parsec.string "define"
        Parsec.spaces
        Parsec.string "hostgroup"
        return (HostGroup)
