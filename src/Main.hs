module Main where

import           Monitoring.Shinken.Parser

import           System.Directory
import           System.Environment
import           System.FilePath.Find
import           System.IO

pattern = "*.cfg"

search = find always (fileName ~~? pattern)

main = do
        dir   <- getCurrentDirectory
        files <- search dir
        putStrLn "* Fichiers trouvés :"
        mapM_ putStrLn files
        let testFile = head files
        testContent <- readFile testFile
        putStrLn ""
        putStrLn $ "* Fichier de test :" ++ testFile
        putStrLn testContent
        putStrLn ""
        putStrLn "* Parsing du fichier"
        print $ parseConfigFile testFile testContent

