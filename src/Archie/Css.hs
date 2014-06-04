module Archie.Css (
  CSSRenderable,
  css
  ) where

import Archie.Types

class CSSRenderable a where
  css :: a -> String

instance CSSRenderable Stylesheet where
  css (Stylesheet (st:sts)) = (css st) ++ (css $ Stylesheet sts)
  css (Stylesheet []) = ""

instance CSSRenderable Statement where
  css (RulesetSt ruleset) = css ruleset

instance CSSRenderable Ruleset where
  css (Ruleset (Nothing) decls) = "{" ++ (css decls) ++ "}"
  css (Ruleset (Just sel) decls) = (css sel) ++ (css $ Ruleset Nothing decls)

instance CSSRenderable Declarations where
  css (Declarations (decl:decls)) = (css decl) ++ (css $ Declarations decls)
  css (Declarations []) = ""

instance CSSRenderable Selector where
  css (Selector sel) = sel
  css (PseudoClass sel pseudo) = sel ++ ":" ++ pseudo

instance CSSRenderable Declaration where
  css (Declaration prop val) = (css prop) ++ ": " ++ (css val) ++ ";\n"

instance CSSRenderable Property where
  css (Property a) = a

instance CSSRenderable Dimension where
  css Px = "px"
  css Em = "em"
  css Rem = "rem"
  css In = "in"
  css Cm = "cm"
  css Mm = "mm"
  css Pt = "pt"
  css Pc = "pc"
  css Ex = "ex"
  css Ch = "ch"
  css Vh = "vh"
  css Vw = "vw"
  css Vmin = "vmin"

instance CSSRenderable Value where
  css (IntVal num) = show num
  css (DoubleVal num) = show num
  css (PercentageVal num) = (show num) ++ "%"
  css (DimensionVal num dim) = (show num) ++ (css dim)
  css (StringVal str) = str
  css (UriVal str) = str
  css (HashVal str) = str
