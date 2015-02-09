module Main where

import           Monitoring.Shinken.Configuration
import           Monitoring.Shinken.Parser

import           Data.Either
import           Data.List                        hiding (find)
import           System.Directory
import           System.Environment
import           System.FilePath.Find
import           System.IO
import           Text.Parsec

pattern = "*.cfg"

main = do
        dir   <- getCurrentDirectory
        files <- search dir
        content <- mapM readFile files
        let normalisedContent = map normaliseComments content
            objects = zipWith parseConfigFile files normalisedContent
        let all = zip files objects
            errors = filter (\ (_,x) -> isLeft x) all
            goods = filter (\ (_,x) -> isRight x) all
        mapM_ printBoth errors
        putStrLn "* Stats"
        putStr "    * Files found: "
        print $ length files
        putStr "    * Objects found: "
        print . length . concat . rights $ objects
        putStr "    * Files with errors: "
        print $ length errors

search = find always (fileName ~~? pattern
                  &&? fileName /~? "shinken.cfg"
                  &&? directory /~? "**resource.d")

normaliseComments :: String -> String
normaliseComments = map (\ x -> if x == ';' then '#' else x)

printBoth :: FilePath -> Either ParseError [Object] -> IO ()
printBoth filepath object = do
    putStr "***** File: "
    putStrLn filepath
    print object
    putStrLn ""
