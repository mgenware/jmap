import 'package:jmap/jmap.dart';
import 'package:test/test.dart';

void main() {
  // ignore: implicit_dynamic_list_literal
  var l = JList([
    -123,
    123.456,
    true,
    '_s_',
    [
      -3,
      3.14,
      {'s': '_s_'}
    ],
    {
      'i': -2,
      'o': {'s': '_s_'}
    },
  ]);

  test('int', () {
    expect(l.getInt(0), -123);
    expect(l.getInt(1), 0);
    expect(l.getIntOrNull(0), -123);
    expect(l.getIntOrNull(1), null);
  });
  test('double', () {
    expect(l.getDouble(1), 123.456);
    expect(l.getDouble(0), 0.0);
    expect(l.getDoubleOrNull(1), 123.456);
    expect(l.getDoubleOrNull(0), null);
  });
  test('bool', () {
    expect(l.getBool(2), true);
    expect(l.getBool(1), false);
    expect(l.getBoolOrNull(2), true);
    expect(l.getBoolOrNull(1), null);
  });
  test('string', () {
    expect(l.getString(3), '_s_');
    expect(l.getString(2), '');
    expect(l.getStringOrNull(3), '_s_');
    expect(l.getStringOrNull(2), null);
  });
  test('array', () {
    expect(l.getList(4)?.list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    // ignore: implicit_dynamic_list_literal
    expect(l.getList(3)?.list, []);
    expect(l.getListOrNull(4)?.list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(l.getListOrNull(3), null);
  });
  test('map', () {
    expect(l.getMap(5).map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    // ignore: implicit_dynamic_map_literal
    expect(l.getMap(4).map, {});
    expect(l.getMapOrNull(5)?.map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(l.getMapOrNull(4), null);
  });
}
