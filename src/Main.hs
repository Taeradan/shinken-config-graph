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
            parseResults = zipWith (\ x y -> (x, parseConfigFile x y)) files normalisedContent
            errors = filter (\ (_,x) -> isLeft x) parseResults
            objects = concat . rights . map snd $ parseResults
        mapM_ printErrors errors
        putStrLn "* Stats"
        putStr "    * Files found: "
        print $ length files
        putStr "    * Objects found: "
        print $ length objects
        putStr "    * Files with errors: "
        print $ length errors

search = find always (fileName ~~? pattern
                  &&? fileName /~? "shinken.cfg"
                  &&? directory /~? "**resource.d")

normaliseComments :: String -> String
normaliseComments = map (\ x -> if x == ';' then '#' else x)

printErrors :: (FilePath, Either ParseError [Object]) -> IO ()
printErrors (filepath, object) = do
    putStr "***** File: "
    putStrLn filepath
    print object
    putStrLn ""
