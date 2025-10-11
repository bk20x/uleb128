

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
    shift: uint64 = 0
    i = 0
  while true:
    if i < data.len:
      var b = data[i]
      inc i
      result = result or (uint64(b and 0x7f) shl shift)
      if not bool(b and 0x80): break
      inc shift, 7
    else:
      return 0
  return result


