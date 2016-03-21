module Country (Country(..), charCountry, countryColor, countryEncoder, countryDecoder) where

import Maybe                 exposing (withDefault)
import Color                 exposing (Color, grey, red, green, purple, orange, yellow, blue)
import Json.Encode as Encode exposing (Value)
import Json.Decode as Decode exposing (Decoder, map)

type Country =
  Austria |
  England |
  France |
  Germany |
  Italy |
  Russia |
  Turkey

charCountry : Char -> Maybe Country
charCountry char =
  case char of
    '1' ->
      Just Austria
    '2' ->
      Just England
    '3' ->
      Just France
    '4' ->
      Just Germany
    '5' ->
      Just Italy
    '6' ->
      Just Russia
    '7' ->
      Just Turkey
    _ ->
      Nothing

stringCountry : String -> Maybe Country
stringCountry string =
  case string of
    "Austria" ->
      Just Austria
    "England" ->
      Just England
    "France" ->
      Just France
    "Germany" ->
      Just Germany
    "Italy" ->
      Just Italy
    "Russia" ->
      Just Russia
    "Turkey" ->
      Just Turkey
    _ ->
      Nothing

countryColor : Country -> Color
countryColor country =
  case country of
    Austria ->
      orange
    England ->
      purple
    France ->
      blue
    Germany ->
      grey
    Italy ->
      green
    Russia ->
      red
    Turkey ->
      yellow

countryEncoder : Country -> Value
countryEncoder country =
  case country of
    Austria ->
      Encode.string "Austria"
    England ->
      Encode.string "England"
    France ->
      Encode.string "France"
    Germany ->
      Encode.string "Germany"
    Italy ->
      Encode.string "Italy"
    Russia ->
      Encode.string "Russia"
    Turkey ->
      Encode.string "Turkey"

countryDecoder : Decoder Country
countryDecoder =
  map (stringCountry >> withDefault Austria) Decode.string
