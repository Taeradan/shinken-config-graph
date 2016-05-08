module Monitoring.Shinken.Print where

import           Monitoring.Shinken.Configuration

import qualified Data.Map.Strict                  as Map
import           Data.Maybe

printDotGraph :: [Object] -> String
printDotGraph objects = unlines [header, body objects, footer]
    where header = "digraph g {"
          footer = "}"

body :: [Object] -> String
body objects = concat [unlines $ mapMaybe node objects, unlines $ mapMaybe relations objects]

node :: Object -> Maybe String
node (Host attributes) = Map.lookup "host_name" attributes
node _ = Nothing

relations :: Object -> Maybe String
relations (Service attributes) = Map.lookup "host_name" attributes
relations _ = Nothing
