module Main where

import Test.Hspec
import Test.QuickCheck

import Archie
import Clay
import Clay.Selector
import qualified Data.Text as Text

main :: IO ()
main = hspec $ describe "Testing Archie" $ do

  -- HUnit/HSpec  tests.
  describe "CSS generator" $ do
    it "has a useless test" $ do
      1 `shouldBe` 1
