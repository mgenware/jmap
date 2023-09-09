import 'package:jmap/jmap.dart';
import 'package:test/test.dart';

void main() {
  // ignore: implicit_dynamic_map_literal
  final m = JMap({
    'i': -123,
    'd': 123.456,
    's': '_s_',
    'b': true,
    'o': {
      'i': -2,
      'o': {'s': '_s_'}
    },
    'a': [
      -3,
      3.14,
      {'s': '_s_'}
    ]
  });

  test('int', () {
    expect(m.getInt('i'), -123);
    expect(m.getInt('_'), 0);
    expect(m.getIntOrNull('i'), -123);
    expect(m.getIntOrNull('_'), null);
  });
  test('double', () {
    expect(m.getDouble('d'), 123.456);
    expect(m.getDouble('_'), 0.0);
    expect(m.getDoubleOrNull('d'), 123.456);
    expect(m.getDoubleOrNull('_'), null);
  });
  test('bool', () {
    expect(m.getBool('b'), true);
    expect(m.getBool('_'), false);
    expect(m.getBoolOrNull('b'), true);
    expect(m.getBoolOrNull('_'), null);
  });
  test('string', () {
    expect(m.getString('s'), '_s_');
    expect(m.getString('_'), '');
    expect(m.getStringOrNull('s'), '_s_');
    expect(m.getStringOrNull('_'), null);
  });
  test('array', () {
    expect(m.getJList('a').list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    // ignore: implicit_dynamic_list_literal
    expect(m.getJList('_').list, <dynamic>[]);
    expect(m.getJListOrNull('a')?.list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(m.getJListOrNull('_'), null);
  });
  test('map', () {
    expect(m.getJMap('o').map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    // ignore: implicit_dynamic_map_literal
    expect(m.getJMap('_').map, <String, dynamic>{});
    expect(m.getJMapOrNull('o')?.map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(m.getJMapOrNull('_'), null);
  });
  test('getDescription', () {
    expect(m.getDescription('b'), 'true');
    expect(m.getDescription('_'), '');
    expect(m.getDescription('s'), '_s_');
  });

  test('allocJMap', () {
    final m2 = m.allocJMap('o');
    expect(m2.map, m.getJMap('o').map);
    expect(m2.map, same(m.getJMap('o').map));
  });

  test('Deep clone', () {
    final m2 = m.deepClone();
    expect(m2.map, m.map);
    expect(m2.map, isNot(same(m.map)));
    expect(m2.getJMap('o').map, m.getJMap('o').map);
    expect(m2.getJMap('o').map, isNot(same(m.getJMap('o').map)));
    expect(m2.getJList('a').list, m.getJList('a').list);
    expect(m2.getJList('a').list, isNot(same(m.getJList('a').list)));
  });
}
