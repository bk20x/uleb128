# uleb128
```
import uleb128


let
  data: uint = 255254
  encoded = uleb128Encode data  # returns seq[uint8]
  decoded = uleb128Decode encoded 
  
assert decoded == data
  



```
