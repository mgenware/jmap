[![pub package](https://img.shields.io/pub/v/jmap.svg)](https://pub.dev/packages/jmap)
[![Build Status](https://github.com/mgenware/jmap/workflows/Build/badge.svg)](https://github.com/mgenware/jmap/actions)

A minimal library to work with JSON decoded maps and lists in a type-safe way.

## Usage

Install and import this package:

```sh
import 'package:jmap/jmap.dart';
```

Example:

```dart
  const json = """
    {
      "i": 1,
      "obj": {
          "i": 2
      },
      "array": [
          -3,
          3.14,
          {
            "s":"_s_"
          }
      ]
    }
""";
  Map<String, dynamic> map = jsonDecode(json);
  // Create a [JMap] from [Map<String, dynamic>].
  JMap jmap = JMap(map);

  // Access members.
  print(jmap.getInt('i')); // 1
  print(jmap.getInt('obj')); // 0 (map['obj'] is not an int)
  print(jmap.getIntOrNull('__')); // null

  // JSON objects are returned as [JMap].
  JMap obj = jmap.getMap('obj');
  print(obj.getInt('i')); // 2

  // JSON arrays are returned as [JList].
  JList arr = jmap.getList('array');
  print(arr.getStringOrNull(1) ?? '--haha--'); // --haha--

  // Chaining.
  print(jmap.getList('array').getMap(2).getString('s')); // _s_
  print(jmap.getList('array').getMap(2).getDoubleOrNull('__') ?? -1.1); // -1.1
```
