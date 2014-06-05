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

    it "Can generate three column fixed layout" $ do
      let selector1 = Selector "#left"
      let declaration1a = Declaration (Property "width") (DimensionVal 200 Px)
      let declaration1b = Declaration (Property "right") (StringVal "auto")
      let declaration1c = Declaration (Property "border-right") (StringVal "1px solid #999")
      let ruleset1 = Ruleset (Just selector1) (Declarations [declaration1a, declaration1b, declaration1c])
      let statement1 = RulesetSt ruleset1

      let selector2 = Selector "#right"
      let declaration2a = Declaration (Property "width") (DimensionVal 200 Px)
      let declaration2b = Declaration (Property "left") (StringVal "auto")
      let declaration2c = Declaration (Property "border-left") (StringVal "1px solid #999")
      let ruleset2 = Ruleset (Just selector2) (Declarations [declaration2a, declaration2b, declaration2c])
      let statement2 = RulesetSt ruleset2

      let selector3 = Selector "#middle"
      let declaration3a = DeclarationJS (Property "left")
                          (ValueJS Nothing
                            (Property "width") (Selector "#left"))
      let declaration3b = DeclarationJS (Property "right")
                          (ValueJS Nothing
                            (Property "width") (Selector "#right"))
      let ruleset3 = Ruleset (Just selector3) (Declarations [declaration3a, declaration3b])
      let statement3 = RulesetSt ruleset3

      let sheet = Stylesheet [statement1, statement2, statement3]

      --Stylesheet [
      --  Rule $ St $ (Sel "#right") Ds [
      --                    D (P "width") (V 200 Px),
      --                    D (P "height") (V 200 Px),
      --                  ],
      --  Rule $ St $ (Sel "#left") Ds [
      --                    D (P "width") (V 200 Px),
      --                    D (P "height") (V 200 Px),
      --                  ]
      --]
      
      renderJs sheet `shouldBe` jsPrefix ++ "rules.push(function(cause) {var $el = $('#container');" ++
                                            "$el.css('width', (function(val){return val/2})" ++
                                            "($('body').css('width')));});"
      renderCss sheet `shouldBe` "#container{width: 960px;}"
