/// Type alias for [List<JMap>].
typedef JMapList = List<JMap>;

/// A wrapper around a [List<dynamic>].
class JList {
  JList(this.list);

  /// Returns the internal list.
  final List<dynamic> list;

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
  JMap? getMapOrNull(int idx) {
    var obj = _get<Map<String, dynamic>>(idx);
    return obj == null ? null : JMap(obj);
  }

  /// Gets a [JMap] that can be empty.
  JMap getMap(int idx) {
    // ignore: implicit_dynamic_map_literal
    return getMapOrNull(idx) ?? JMap({});
  }

  /// Gets a nullable [JList].
  JList? getListOrNull(int idx) {
    var list = _get<List<dynamic>>(idx);
    return list == null ? null : JList(list);
  }

  /// Gets a [JList] that can be empty.
  JList? getList(int idx) {
    // ignore: implicit_dynamic_list_literal
    return getListOrNull(idx) ?? JList([]);
  }

  List<T> toList<T>() {
    List<T> res = [];
    for (var i = 0; i < list.length; i++) {
      var item = _get<T>(i);
      if (item != null) {
        res.add(item);
      }
    }
    return res;
  }

  JMapList toJMapList() {
    var dicts = toList<Map<String, dynamic>>();
    return dicts.map((e) => JMap(e)).toList();
  }

  T? _get<T>(int idx) {
    return list[idx] is T ? list[idx] as T : null;
  }
}

/// A wrapper around a [Map<String, dynamic>].
class JMap {
  JMap(this.map);

  /// Returns the internal map.
  final Map<String, dynamic> map;

  /// Length of this map.
  int get length {
    return map.length;
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
  JMap? getMapOrNull(String key) {
    var obj = _get<Map<String, dynamic>>(key);
    return obj == null ? null : JMap(obj);
  }

  /// Gets a [JMap] that can be empty.
  JMap getMap(String key) {
    // ignore: implicit_dynamic_map_literal
    return getMapOrNull(key) ?? JMap({});
  }

  /// Gets a nullable [JList].
  JList? getListOrNull(String key) {
    var list = _get<List<dynamic>>(key);
    return list == null ? null : JList(list);
  }

  /// Gets a [JList] that can be empty.
  JList getList(String key) {
    // ignore: implicit_dynamic_list_literal
    return getListOrNull(key) ?? JList([]);
  }

  /// Returns [value.toString()] if it exists. Otherwise, returns an empty string.
  String getDescription(String key) {
    // ignore: implicit_dynamic_variable
    var value = map[key];
    return value != null ? value.toString() : '';
  }

  T? _get<T>(String key) {
    return map[key] is T ? map[key] as T : null;
  }
}
