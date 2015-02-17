{-# LANGUAGE OverloadedStrings #-}

module AboutCssGen where

import Clay
import Prelude hiding ((**))
import Data.Monoid
import Data.Text.Lazy
import System.Directory
import Consts

{- aboutStyles
 - Generates CSS for the about page. -}

aboutStyles = "#aboutDiv" ? do
    maxWidth (px 1000)
    padding 0 (em 1) 0 (em 1)
    margin nil auto nil auto
    textAlign justify
    h1 <> h2 <> h3 <? do
        color blue3


