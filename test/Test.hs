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

    it "Can generate a single style rule" $ do
      let selector = Selector "#container"
      let declaration = Declaration (Property "width") (DimensionVal 960 Px)
      let ruleset = Ruleset (Just selector) (Declarations [declaration])
      let statement = RulesetSt ruleset
      let sheet = Stylesheet [statement]
      renderCss sheet `shouldSatisfy` (\val -> length val /= 0)
