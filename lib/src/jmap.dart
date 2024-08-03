import 'dart:convert';

import 'package:collection/collection.dart';

/// Type alias for [List<JMap>].
typedef JMapList = List<JMap>;

/// A wrapper around a [List<dynamic>].
class JList {
  final bool ignoreCase;

  JList(List<dynamic>? list, {required this.ignoreCase}) {
    this.list = list ?? [];
  }

  int get count => list.length;
  bool get isEmpty => list.isEmpty;
  bool get isNotEmpty => list.isNotEmpty;

  /// Returns the internal list.
  late final List<dynamic> list;

  /// The length of this list.
  int get length {
    return list.length;
  }

  /// Gets a nullable [int].
  int? getIntOrNull(int idx) {
    return _get<int>(idx);
  }

  /// Gets an [int] or 0.
  int getInt(int idx) {
    return getIntOrNull(idx) ?? 0;
  }

  /// Gets a nullable [double].
  double? getDoubleOrNull(int idx) {
    return _get<double>(idx);
  }

  /// Gets a [double] or 0.
  double getDouble(int idx) {
    return getDoubleOrNull(idx) ?? 0;
  }

  /// Gets a nullable [String].
  String? getStringOrNull(int idx) {
    return _get<String>(idx);
  }

  /// Gets a [String] or ''.
  String getString(int idx) {
    return _get<String>(idx) ?? '';
  }

  /// Gets a nullable [bool].
  bool? getBoolOrNull(int idx) {
    return _get<bool>(idx);
  }

  /// Gets a [bool] or false.
  bool getBool(int idx) {
    return _get<bool>(idx) ?? false;
  }

  /// Gets a nullable [JMap].
  JMap? getJMapOrNull(int idx) {
    final obj = _get<Map<String, dynamic>>(idx);
    return obj == null ? null : JMap(obj, ignoreCase: ignoreCase);
  }

  /// Gets a [JMap] that can be empty.
  JMap getJMap(int idx) {
    // ignore: implicit_dynamic_map_literal
    return getJMapOrNull(idx) ?? JMap({}, ignoreCase: ignoreCase);
  }

  /// Gets a nullable [JList].
  JList? getJListOrNull(int idx) {
    final list = _get<List<dynamic>>(idx);
    return list == null ? null : JList(list, ignoreCase: ignoreCase);
  }

  /// Gets a [JList] that can be empty.
  JList? getJList(int idx) {
    // ignore: implicit_dynamic_list_literal
    return getJListOrNull(idx) ?? JList([], ignoreCase: ignoreCase);
  }

  JList deepClone() {
    final json = jsonEncode(list);
    final clone = jsonDecode(json) as List<dynamic>;
    return JList(clone, ignoreCase: ignoreCase);
  }

  List<T> toList<T>() {
    final List<T> res = [];
    for (var i = 0; i < list.length; i++) {
      final item = _get<T>(i);
      if (item != null) {
        res.add(item);
      }
    }
    return res;
  }

  JMapList toJMapList() {
    final dicts = toList<Map<String, dynamic>>();
    return dicts.map((e) => JMap(e, ignoreCase: ignoreCase)).toList();
  }

  T? _get<T>(int idx) {
    return list[idx] is T ? list[idx] as T : null;
  }

  @override
  String toString() {
    return list.toString();
  }
}

Map<String, dynamic> _canonicalizeMap(Map<String, dynamic> map) {
  return CanonicalizedMap<String, String, dynamic>.from(
      map, (key) => key.toLowerCase());
}

/// A wrapper around a [Map<String, dynamic>].
class JMap {
  final bool ignoreCase;

  JMap(Map<String, dynamic>? map, {required this.ignoreCase}) {
    if (ignoreCase) {
      this.map = _canonicalizeMap(map ?? <String, dynamic>{});
    } else {
      this.map = map ?? <String, dynamic>{};
    }
  }

  int get count => map.length;
  bool get isEmpty => map.isEmpty;
  bool get isNotEmpty => map.isNotEmpty;

  /// Returns the internal map.
  late final Map<String, dynamic> map;

  /// Length of this map.
  int get length {
    return map.length;
  }

  /// Returns if the map contains the key.
  bool containsKey(String key) {
    return map.containsKey(key);
  }

  /// Gets a nullable [int].
  int? getIntOrNull(String key) {
    return _get<int>(key);
  }

  /// Gets an [int] or 0.
  int getInt(String key) {
    return getIntOrNull(key) ?? 0;
  }

  /// Gets a nullable [double].
  double? getDoubleOrNull(String key) {
    return _get<double>(key);
  }

  /// Gets a [double] or 0.
  double getDouble(String key) {
    return getDoubleOrNull(key) ?? 0;
  }

  /// Gets a nullable [String].
  String? getStringOrNull(String key) {
    return _get<String>(key);
  }

  /// Gets a [String] or ''.
  String getString(String key) {
    return getStringOrNull(key) ?? '';
  }

  /// Gets a nullable [bool].
  bool? getBoolOrNull(String key) {
    return _get<bool>(key);
  }

  /// Gets a [bool] or false.
  bool getBool(String key) {
    return getBoolOrNull(key) ?? false;
  }

  /// Gets a nullable [JMap].
  JMap? getJMapOrNull(String key) {
    final obj = _get<Map<String, dynamic>>(key);
    return obj == null ? null : JMap(obj, ignoreCase: ignoreCase);
  }

  /// Gets a [JMap] that can be empty.
  JMap getJMap(String key) {
    // ignore: implicit_dynamic_map_literal
    return getJMapOrNull(key) ?? JMap({}, ignoreCase: ignoreCase);
  }

  /// Gets a nullable [JList].
  JList? getJListOrNull(String key) {
    final list = _get<List<dynamic>>(key);
    return list == null ? null : JList(list, ignoreCase: ignoreCase);
  }

  /// Gets a [JList] that can be empty.
  JList getJList(String key) {
    // ignore: implicit_dynamic_list_literal
    return getJListOrNull(key) ?? JList([], ignoreCase: ignoreCase);
  }

  /// Returns [value.toString()] if it exists. Otherwise, returns an empty string.
  String getDescription(String key) {
    // ignore: implicit_dynamic_variable
    final value = map[key];
    return value != null ? value.toString() : '';
  }

  JMap deepClone() {
    final json = jsonEncode(map);
    final clone = jsonDecode(json) as Map<String, dynamic>;
    return JMap(clone, ignoreCase: ignoreCase);
  }

  T? _get<T>(String key) {
    return map[key] is T ? map[key] as T : null;
  }

  @override
  String toString() {
    return map.toString();
  }
}
