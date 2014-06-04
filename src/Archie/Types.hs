module Archie.Types (
  Stylesheet(..),
  Statement(..),
--  AtRule(..),
  Ruleset(..),
  Declarations(..),
  Declaration(..),
  Selector(..),
  Sel,
  Pseudo,
  Property(..),
  Value(..),
  ValueJS(..),
  Function(..),
  Dimension(..)) where

newtype Stylesheet = Stylesheet [Statement]

data Statement =  RulesetSt Ruleset

               -- TODO: support | AtRuleSt AtRule
-- newtype AtRule = AtRule String -- TODO: change to real value or worry later

data Ruleset = Ruleset (Maybe Selector) Declarations

newtype Declarations = Declarations [Declaration]

data Selector = Selector Sel
              | PseudoClass Sel Pseudo

type Sel = String

type Pseudo = String

data Declaration = Declaration Property Value
                 | DeclarationJS Property ValueJS

newtype Property = Property String

data Value = IntVal Integer
           | FloatVal Double
           | PercentageVal Double
           | DimensionVal Double Dimension
           | StringVal String
           | UriVal String
           | HashVal String -- TODO: Add other values as needed

-- For JavaScript generation
data ValueJS = ValueJS (Maybe Function) Property Selector

-- Function name can be something like "divideByTwo", where
-- divideByTwp = function(val){ return val / 2; }
data Function = Function String

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
