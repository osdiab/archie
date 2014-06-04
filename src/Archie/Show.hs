module Archie.Show (
  showCssFloat
  ) where

import Archie.Constants
import Numeric

isInt :: RealFloat a => a -> Bool
isInt x = x == fromInteger (round x)

showCssFloat :: RealFloat a => a -> String
showCssFloat x = case (isInt x) of
  True -> show $ round x
  False -> showFFloat (Just floatDecimalPlaces) x ""
