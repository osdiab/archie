module Archie (Stylesheet, Statement, AtRule, Ruleset, Declaration, Property, Value) where

newtype Stylesheet = Stylesheet [Statement]
data Statement =  RulesetSt Ruleset | AtRuleSt AtRule
newtype AtRule = AtRule String -- TODO: change to real value or worry later
data Ruleset = Ruleset (Maybe Selector) [Declaration]
data Selector = Selector Sel | PseudoClass Sel Pseudo
type Sel = String
type Pseudo = String
data Declaration = Declaration Property Value
newtype Property = Property String
data Value = Num Double | Int Integer | Perc Double | Dim Double Dimension
           | Str String | Uri String | Hash String -- TODO: Add other values as needed
data Dimension = Px | Em | Rem | In | Cm | Mm | Pt | Pc | Ex | Ch | Vh | Vw | Vmin
