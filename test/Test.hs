module Main where

import Test.Hspec
import Test.QuickCheck

import Archie
import Clay
import Clay.Selector
import qualified Data.Text as Text

instance Eq Value where
  (==) (Value (Prefixed a)) (Value (Prefixed b)) = a == b
  (==) (Value (Plain a)) (Value (Plain b)) = a == b
  (==) (Value _) (Value _) = False
  (/=) (Value (Prefixed a)) (Value (Prefixed b)) = a /= b
  (/=) (Value (Plain a)) (Value (Plain b)) = a /= b
  (/=) (Value _) (Value _) = True

main :: IO ()
main = hspec $ describe "Testing Archie" $ do

  -- HUnit/HSpec  tests.
  describe "Selector" $ do
    it "value defaults to 'inherit'" $ do
      let x = value $ text $ Text.pack "#container"
      x `shouldBe` value (Literal $ Text.pack "inherit")

