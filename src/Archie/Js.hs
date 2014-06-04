module Archie.Js (
  JSRenderable,
  js
  ) where

import Archie.Types
import Archie.Constants
import Archie.Css

class JSRenderable a where
  js :: a -> String

instance JSRenderable Stylesheet where
  js (Stylesheet sts) = jsPrefix ++ (unwords $ map js sts)

instance JSRenderable Statement where
  js (RulesetSt ruleset) = js ruleset

instance JSRenderable Ruleset where
  js (Ruleset (Nothing) decls) = js decls
  js (Ruleset (Just sel) decls) = "rules.push(function(cause) {" ++
                                    "var $el = " ++ js sel ++ ";" ++
                                    js (Ruleset Nothing decls) ++
                                  "});"

instance JSRenderable Declarations where
  js (Declarations decls) = concat $ map js decls

instance JSRenderable Selector where
  js (Selector sel) = "$('" ++ sel ++ "')"
  js (PseudoClass sel pseudo) = js $ Selector (sel ++ ":" ++ pseudo)

instance JSRenderable Declaration where
  js decl =
    case decl of
      DynDeclaration prop (DynamicValue otherProp otherSel) ->
        "$el.css('" ++ css prop ++ "', " ++
        js otherSel ++ ".css('" ++ css otherProp ++ "'));"
      _ -> ""
