module Main where

import qualified Data.List            as L
import           System.Directory
import           System.Environment
import           System.FilePath.Find
import           System.IO
import           System.IO.Unsafe

pattern = "*.cfg"

search dir =
  find always (fileName ~~? pattern) dir

main = do
          dir   <- getCurrentDirectory
          files <- search dir
          mapM_ putStrLn files
          filesContent <- mapM readFile files
          mapM_ putStrLn filesContent
