module Archie (
  Stylesheet,
  Statement,
  AtRule,
  Ruleset,
  Declaration,
  Property,
  Value,
  Dimension(..)) where

newtype Stylesheet = Stylesheet [Statement]
data Statement =  RulesetSt Ruleset
               | AtRuleSt AtRule
newtype AtRule = AtRule String -- TODO: change to real value or worry later
data Ruleset = Ruleset (Maybe Selector) [Declaration]
data Selector = Selector Sel
              | PseudoClass Sel Pseudo
type Sel = String
type Pseudo = String
data Declaration = Declaration Property Value
newtype Property = Property String
data Value = IntVal Integer
           | DoubleVal Double
           | PercentageVal Double
           | DimensionVal Double Dimension
           | StringVal String
           | UriVal String
           | HashVal String -- TODO: Add other values as needed
data Dimension = Px
               | Em
               | Rem
               | In
               | Cm
               | Mm
               | Pt
               | Pc
               | Ex
               | Ch
               | Vh
               | Vw
               | Vmin

class CSSRenderable a where
  css :: a -> String

class JSRenderable a where
  js :: a -> String

instance CSSRenderable (Dimension) where
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
  css Vw = "vw"
  css Vmin = "vmin"

instance CSSRenderable (Value) where
  css (IntVal num) = show num
  css (DoubleVal num) = show num
  css (PercentageVal num) = (show num) ++ "%"
  css (DimensionVal num dim) = (show num) ++ (css dim)
  css (StringVal str) = str
  css (UriVal str) = str
  css (HashVal str) = str
