module Size (Size, size, sizeEncoder, sizeDecoder) where

import Json.Encode as Encode exposing (Value, object)
import Json.Decode as Decode exposing (Decoder, object2, (:=))

type alias Size =
  {
    width : Float,
    height : Float
  }

size : (Int, Int) -> Size
size (width, height) =
  {
    width = toFloat width,
    height = toFloat height
  }

sizeEncoder : Size -> Value
sizeEncoder size =
  object
    [
      ("width", Encode.float size.width),
      ("height", Encode.float size.height)
    ]

sizeDecoder : Decoder Size
sizeDecoder =
  object2 Size
    ("width" := Decode.float)
    ("height" := Decode.float)
