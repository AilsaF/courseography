-- import Distribution.Simple
-- main = defaultMain
{-# OPTIONS_GHC -Wall #-}

import Distribution.PackageDescription
import Distribution.Simple
import Distribution.Simple.LocalBuildInfo
import Distribution.Simple.PreProcess
import Distribution.Simple.Utils
import System.Exit
import System.FilePath
import System.Process (rawSystem, system)

main :: IO ()
main = defaultMainWithHooks
       simpleUserHooks { hookedPreProcessors = [("pre", myCustomPreprocessor)] }
  where
    myCustomPreprocessor :: BuildInfo -> LocalBuildInfo -> PreProcessor
    myCustomPreprocessor _bi lbi =
      print "==================="
      PreProcessor {
        platformIndependent = True,
        runPreProcessor = mkSimplePreProcessor $ \inFile outFile verbosity ->
          do info verbosity ("Preprocessing " ++ inFile ++ " to " ++ outFile)
             callProcess
        }

    -- Backwards compat with process < 1.2.
    callProcess :: IO ()
    callProcess = do
    	result <- system "convert"
	    case result of
	        ExitFailure 127 -> putStrLn $ "Convert is not available."
	        _ -> putStrLn "Ran successfully"
