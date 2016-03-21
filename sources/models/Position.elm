module Position (Position, position, positionEncoder, positionDecoder, distance) where

import Json.Encode as Encode exposing (Value, object)
import Json.Decode as Decode exposing (Decoder, object2, (:=))

type alias Position =
  {
    x : Float,
    y : Float
  }

position : (Int, Int) -> Position
position (x, y) =
  {
    x = toFloat x,
    y = toFloat y
  }

positionEncoder : Position -> Value
positionEncoder position =
  object
    [
      ("x", Encode.float position.x),
      ("y", Encode.float position.y)
    ]

positionDecoder : Decoder Position
positionDecoder =
  object2 Position
    ("x" := Decode.float)
    ("y" := Decode.float)

distance : Position -> Position -> Float
distance from to =
  sqrt <| (from.x - to.x) ^ 2 + (from.y - to.y) ^ 2
