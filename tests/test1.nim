import unittest

import uleb128
test "can encode/decode":
  let
    data: uint = 29912
    encoded = uleb128Encode data
    decoded = uleb128Decode encoded
  check (decoded == data)
