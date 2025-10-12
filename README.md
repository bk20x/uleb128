# uleb128
```
import uleb128

# uleb128
block:
  let
    data: uint = 255254
    encoded = uleb128Encode data  # returns seq[uint8]
    decoded = uleb128Decode encoded 

  assert decoded == data
  
# leb128
block:
  let
    data: int = 23852835925
    encoded = leb128Encode data
    decoded = leb128Decode data

  assert decoded == data
```
