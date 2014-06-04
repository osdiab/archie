module Main where

import Test.Hspec
import Test.QuickCheck

import Archie
import Archie.Types
import Archie.Constants
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
      renderCss sheet `shouldBe` "#container{width: 960px;}"

  describe "JS generator" $ do
    it "Can generate empty JS" $ do
      let sheet = Stylesheet []
      renderJs sheet `shouldBe` jsPrefix

    it "Can generate a single static style rule" $ do
      let selector = Selector "#container"
      let declaration = Declaration (Property "width") (DimensionVal 960 Px)
      let ruleset = Ruleset (Just selector) (Declarations [declaration])
      let statement = RulesetSt ruleset
      let sheet = Stylesheet [statement]
      renderJs sheet `shouldBe` jsPrefix ++ "rules.push(function(cause) {var $el = $('#container');};"

    it "Can generate a single dynamic style rule" $ do
      let selector = Selector "#container"
      let declaration = DynDeclaration (Property "width") (DynamicValue (Property "width") (Selector "window"))
      let ruleset = Ruleset (Just selector) (Declarations [declaration])
      let statement = RulesetSt ruleset
      let sheet = Stylesheet [statement]
      renderJs sheet `shouldBe` jsPrefix ++ "rules.push(function(cause) {var $el = $('#container');" ++
                                            "$el.css('width', $('window').css('width'));};"
