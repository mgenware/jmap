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
import 'dart:convert';
import 'package:jmap/jmap.dart';

void main() {
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
  final map = jsonDecode(json) as Map<String, dynamic>;

  // Create a [JMap] from [Map<String, dynamic>].
  final JMap jmap = JMap(map, ignoreCase: false);

  // Access members.
  print(jmap.getInt('i')); // 1
  print(jmap.getInt('obj')); // 0 (map['obj'] is not an int)
  print(jmap.getIntOrNull('__')); // null

  // Objects can be accessed as [JMap].
  final JMap obj = jmap.getJMap('obj');
  print(obj.getInt('i')); // 2

  // Arrays can be accessed as [JList].
  final JList arr = jmap.getJList('array');
  print(arr.getStringOrNull(1) ?? 'fallback value'); // fallback value

  // Chaining.
  print(jmap.getJList('array').getJMap(2).getString('s')); // _s_
  print(
      jmap.getJList('array').getJMap(2).getDoubleOrNull('__') ?? -1.1); // -1.1
}
```

## Options

- Use `JMap({}, ignoreCase: true);` to create a case-insensitive `JMap`.
