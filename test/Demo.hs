module Demo (runDemo) where

import Test.Hspec

import Archie
import Archie.Types
import Archie.Constants
import qualified Data.Text as Text

runDemo :: Spec
runDemo = do
  describe "demo CSS and JS" $ do
    --describe "generates correct CSS" $

    describe "generates correct JS" $
      let selector1 = Selector "#left"
      let declaration1 = DeclarationJS (Property "width")
                          (ValueJS (Just (Function "function(val){return val/2}"))
                            (Property "width") (Selector "body"))
      let ruleset1 = Ruleset (Just selector) (Declarations [declaration1])
      let statement1 = RulesetSt ruleset1

      let selector = Selector "#middle"
      let declaration2 = DeclarationJS (Property "width")
                          (ValueJS (Just (Function "function(val){return val/2}"))
                            (Property "width") (Selector "body"))
      let ruleset2 = Ruleset (Just selector) (Declarations [declaration2])
      let statement2 = RulesetSt ruleset2

      let selector = Selector "#right"
      let declaration3 = DeclarationJS (Property "width")
                          (ValueJS (Just (Function "function(val){return val/2}"))
                            (Property "width") (Selector "body"))
      let ruleset3 = Ruleset (Just selector) (Declarations [declaration3])
      let statement3 = RulesetSt ruleset3

      let sheet = Stylesheet [statement1, statement2, statement3]
      renderJs sheet `shouldBe` jsPrefix ++ "rules.push(function(cause) {var $el = $('#container');" ++
                                            "$el.css('width', (function(val){return val/2})" ++
                                            "($('body').css('width')));});"
