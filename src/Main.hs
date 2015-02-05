module Main where

import           Monitoring.Shinken.Parser

import           System.Directory
import           System.Environment
import           System.FilePath.Find
import           System.IO

pattern = "*.cfg"

main = do
        dir   <- getCurrentDirectory
        files <- search dir
        putStrLn "* Fichiers trouvés :"
        mapM_ putStrLn files
        let testFile = head files
        testContent <- readFile testFile
        let normalisedTestContent = normaliseComments testContent
        putStrLn ""
        putStrLn $ "* Fichier de test :" ++ testFile
        putStrLn normalisedTestContent
        putStrLn ""
        putStrLn "* Parsing du fichier"
        print $ parseConfigFile testFile normalisedTestContent

search = find always (fileName ~~? pattern &&? fileName /~? "shinken.cfg")

normaliseComments :: String -> String
normaliseComments = map (\x -> if x==';' then '#' else x)
