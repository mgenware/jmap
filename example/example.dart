import 'dart:convert';

import 'package:jmap/jmap.dart';

void main() {
  // ignore: prefer_single_quotes
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
  final jmap = JMap(map);

// ignore_for_file: avoid_print
  // Access members.
  print(jmap.getInt('i')); // 1
  print(jmap.getInt('obj')); // 0 (map['obj'] is not an int)
  print(jmap.getIntOrNull('__')); // null

  // JSON objects are returned as [JMap].
  final obj = jmap.getMap('obj');
  print(obj.getInt('i')); // 2

  // JSON arrays are returned as [JList].
  final arr = jmap.getList('array');
  print(arr.getStringOrNull(1) ?? '--haha--'); // --haha--

  // Chaining.
  print(jmap.getList('array').getMap(2).getString('s')); // _s_
  print(jmap.getList('array').getMap(2).getDoubleOrNull('__') ?? -1.1); // -1.1
}
