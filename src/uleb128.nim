



proc uleb128Encode*(value: uint): seq[uint8] =
  var
    v = value
  while true:
    var b = v and 0x7f
    v = v shr 7
    if v == 0:
      result.add uint8(b)
      break
    else:
      result.add uint8(b or 0x80)
  return result

proc uleb128Decode*(data: openArray[uint8]): uint64 =
  var
    i = 0
    shift: uint64 = 0
  while true:
    if i < data.len:
      let b = data[i]
      result = result or (uint64(b and 0x7f) shl shift)
      if not bool(b and 0x80): break
      inc i
      inc shift, 7
    else:
      return 0
  return result


proc leb128Encode*(value: int): seq[uint8] =
  var val = value
  while true:
    let
      b = uint8(val and 0x7f)
      signBitSet = (b and 0x40'u8) != 0'u8
    val = ashr(val, 7)
    if (val == 0 and not signBitSet) or (val == -1 and signBitSet):
      result.add b
      break
    else:
      result.add b or 0x80'u8
  return result

proc leb128Decode*(data: seq[uint8]): int =
  var
    b: uint8
    i = 0
    shift = 0
  while true:
    b = data[i]
    result = result or int(b and 0x7f) shl shift
    shift += 7
    if not bool(b and 0x80): break
    inc i
  let
    signBitSet = (b and 0x40'u8) != 0'u8
    size = sizeof(result) * 8
  if signBitSet and (shift < size):
    result = result or (int(-1) shl shift)
  return result


      
    
    
    

  
