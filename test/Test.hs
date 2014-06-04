module Main where

import Test.Hspec
import Test.QuickCheck

import Archie
import Archie.Types
import qualified Data.Text as Text

main :: IO ()
main = hspec $ describe "Testing Archie" $ do

  -- HUnit/HSpec  tests.
  describe "CSS generator" $ do
    it "Can generate empty CSS" $ do
      let sheet = Stylesheet []
      renderCss sheet `shouldBe` ""
