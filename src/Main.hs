module Main where

import           Monitoring.Shinken.Parser

import           Data.Either
import           System.Directory
import           System.Environment
import           System.FilePath.Find
import           System.IO

pattern = "*.cfg"

main = do
        dir   <- getCurrentDirectory
        files <- search dir
        putStrLn "* Found Files:"
        mapM_ putStrLn files
        putStrLn ""
        content <- mapM readFile files
        let normalisedContent = map normaliseComments content
            objects = concat . rights $ map parseConfigFile (zip files normalisedContent)
        putStrLn "* Parsed objects:"
        print $ objects
        putStrLn ""
        putStrLn "* Stats"
        putStr "    * Files found: "
        print $ length files
        putStr "    * Objects found: "
        print $ length objects

search = find always (fileName ~~? pattern &&? fileName /~? "shinken.cfg")

normaliseComments :: String -> String
normaliseComments = map (\ x -> if x == ';' then '#' else x)
