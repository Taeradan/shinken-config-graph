module Main where

import System.Environment
import System.Directory
import System.IO
import System.IO.Unsafe
import System.FilePath.Find
import qualified Data.List as L

pattern = "*.cfg"

search dir =
  find always (fileName ~~? pattern) dir

main = do
          dir   <- getCurrentDirectory
          files <- search dir
          mapM_ putStrLn files
