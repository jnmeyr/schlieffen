module Unit (Unit, unit, unitEncoder, unitDecoder) where

import Json.Encode as Encode  exposing (Value, object)
import Json.Decode as Decode  exposing (Decoder, object4, (:=))

import Country                exposing (Country(..), countryEncoder, countryDecoder)
import Kind                   exposing (Kind(..), kindEncoder, kindDecoder)
import Position               exposing (Position, position, positionEncoder, positionDecoder)

type alias Unit =
  {
    id : Int,
    country : Country,
    kind : Kind,
    position : Position
  }

unit : Int -> Unit
unit id =
  {
    id = id,
    country = Austria,
    kind = Army,
    position = position (0, 0)
  }

unitEncoder : Unit -> Value
unitEncoder unit =
  object
    [
      ("id", Encode.int unit.id),
      ("country", countryEncoder unit.country),
      ("kind", kindEncoder unit.kind),
      ("position", positionEncoder unit.position)
    ]

unitDecoder : Decoder Unit
unitDecoder =
  object4 Unit
    ("id" := Decode.int)
    ("country" := countryDecoder)
    ("kind" := kindDecoder)
    ("position" := positionDecoder)
