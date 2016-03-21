module Kind (Kind(..), charKind, stringKind, kindShape, kindEncoder, kindDecoder) where

import Maybe                       exposing (withDefault)
import Graphics.Collage as Collage exposing (Shape, polygon, circle)
import Json.Encode      as Encode  exposing (Value)
import Json.Decode      as Decode  exposing (Decoder, map)

type Kind =
  Army |
  Fleet |
  Supply

charKind : Char -> Maybe Kind
charKind char =
  case char of
    'a' ->
      Just Army
    'f' ->
      Just Fleet
    's' ->
      Just Supply
    _ ->
      Nothing

stringKind : String -> Maybe Kind
stringKind string =
  case string of
    "Army" ->
      Just Army
    "Fleet" ->
      Just Fleet
    "Supply" ->
      Just Supply
    _ ->
      Nothing

kindShape : Kind -> Shape
kindShape kind =
  case kind of
    Army ->
      polygon [(0, 0), (-16, 0), (-12, -8), (12, -8), (16, 0), (0, 0), (0, 2), (-8, 2), (-8, 6), (8, 6), (8, 2), (0, 2), (8, 2), (8, 3), (16, 3), (16, 5), (10, 5), (10, 3), (8, 3), (8, 2), (0, 2), (0, 0)]
    Fleet ->
      polygon [(0, 0), (0, 4), (-12, 4), (0, 16), (12, 4), (0, 4), (0, 0), (-16, 0), (-12, -8), (12, -8), (16, 0), (0, 0)]
    Supply ->
      circle 8

kindEncoder : Kind -> Value
kindEncoder kind =
  case kind of
    Army ->
      Encode.string "Army"
    Fleet ->
      Encode.string "Fleet"
    Supply ->
      Encode.string "Supply"

kindDecoder : Decoder Kind
kindDecoder =
  map (stringKind >> withDefault Army) Decode.string
