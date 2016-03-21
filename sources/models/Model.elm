module Model (Model, model, modelEncoder, modelDecoder) where

import Json.Encode as Encode  exposing (Value, object)
import Json.Decode as Decode  exposing (Decoder, object5, oneOf, (:=))

import Size                   exposing (Size, size, sizeEncoder, sizeDecoder)
import Position               exposing (Position, position, positionEncoder, positionDecoder)
import Unit                   exposing (Unit, unitEncoder, unitDecoder)

type alias Model =
  {
    size : Size,
    position : Position,
    units : List Unit,
    unit : Maybe Unit,
    nextId : Int
  }

model : Model
model =
  {
    size = size (1218, 1118),
    position = position (0, 0),
    units = [],
    unit = Nothing,
    nextId = 0
  }

star : (a -> Value) -> List a -> Value
star encoder = Encode.list << List.map encoder

mark : (a -> Value) -> Maybe a -> Value
mark encoder a =
  case a of
    Just a ->
      encoder a
    Nothing ->
      Encode.null

modelEncoder : Model -> Value
modelEncoder model =
  object
    [
      ("size", sizeEncoder model.size),
      ("position", positionEncoder model.position),
      ("units", star unitEncoder model.units),
      ("unit", mark unitEncoder model.unit),
      ("nextId", Encode.int model.nextId)
    ]

try : Decoder a -> Decoder (Maybe a)
try decoder =
  oneOf
    [
      Decode.null Nothing,
      Decode.map Just decoder
    ]

modelDecoder : Decoder Model
modelDecoder =
  object5 Model
    ("size" := sizeDecoder)
    ("position" := positionDecoder)
    ("units" := Decode.list unitDecoder)
    ("unit" := try unitDecoder)
    ("nextId" := Decode.int)
