module Main where

import Control.Monad    (msum)
import Control.Monad.IO.Class (liftIO)
import Happstack.Server
import GridResponse
import GraphResponse
import ExportResponse
import DrawResponse
import ImageResponse
import PostResponse
--import AboutResponse
import Database.CourseQueries
import Css.CssGen
import Filesystem.Path.CurrentOS
import System.Directory
import qualified Data.Text as T
import Diagram

main :: IO ()
main = do
    generateCSS
    cwd <- getCurrentDirectory
    let staticDir = encodeString $ parent $ decodeString cwd
    contents <- readFile "../README.md"
    simpleHTTP nullConf $
        msum [ dir "grid" gridResponse,
               dir "graph" graphResponse,
               dir "draw" drawResponse,
               dir "image" $ graphImageResponse,
               dir "timetable-image" $ look "courses" >>= timetableImageResponse,
               --dir "about" $ aboutResponse contents,
               dir "post" postResponse,
               dir "static" $ serveDirectory EnableBrowsing [] staticDir,
               dir "export" exportResponse,
               dir "course" $ path (\s -> liftIO $ queryCourse (T.pack s)),
               dir "course" $ look "name" >>= retrieveCourse,
               dir "all-courses" $ liftIO allCourses
               ]

retrieveCourse :: String -> ServerPart Response
retrieveCourse course =
    liftIO $ queryCourse (T.pack course)
