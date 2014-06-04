module Archie.Constants (
  floatDecimalPlaces,
  jsPrefix
  ) where

floatDecimalPlaces :: Int
floatDecimalPlaces = 2

jsPrefix :: String
jsPrefix = "var SUBTREE = 0;" ++
  "var RESIZE = 1;" ++
  "var rules = [];" ++

  "var updateReferences = function(cause) {" ++
    "rules.forEach(function(f) {" ++
      "f(cause);" ++
    "});" ++
  "};" ++

  "$(document).on('DOMSubtreeModified', function() {" ++
    "updateReferences({subtree: true});" ++
  "});" ++

  "$(window).resize(function() {" ++
    "updateReferences({resize: true});" ++
  "});"