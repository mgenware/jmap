import 'package:jmap/jmap.dart';
import 'package:test/test.dart';

void main() {
  // ignore: implicit_dynamic_list_literal
  final l = JList([
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
    expect(l.getJList(4)?.list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    // ignore: implicit_dynamic_list_literal
    expect(l.getJList(3)?.list, <dynamic>[]);
    expect(l.getJListOrNull(4)?.list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(l.getJListOrNull(3), null);
  });
  test('map', () {
    expect(l.getJMap(5).map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    // ignore: implicit_dynamic_map_literal
    expect(l.getJMap(4).map, <String, dynamic>{});
    expect(l.getJMapOrNull(5)?.map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(l.getJMapOrNull(4), null);
  });

  test('Deep clone', () {
    final l2 = l.deepClone();
    expect(l2.list, l.list);
    expect(l2.list, isNot(same(l.list)));
    expect(l2.list[4], isNot(same(l.list[4])));
    expect(l2.list[5], isNot(same(l.list[5])));
  });
}
