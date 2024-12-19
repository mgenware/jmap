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
  }, ignoreCase: false);

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

  test('Deep clone', () {
    final m2 = m.deepClone();
    expect(m2.map, m.map);
    expect(m2.map, isNot(same(m.map)));
    expect(m2.getJMap('o').map, m.getJMap('o').map);
    expect(m2.getJMap('o').map, isNot(same(m.getJMap('o').map)));
    expect(m2.getJList('a').list, m.getJList('a').list);
    expect(m2.getJList('a').list, isNot(same(m.getJList('a').list)));
  });

  test('Ignore case', () {
    final m = JMap({
      'i': -123,
      'd': 123.456,
      's': '_s_',
      'b': true,
      'O': {
        'i': -2,
        'o': {'s': '_s_'}
      },
      'a': [
        -3,
        3.14,
        {'s': '_s_'}
      ]
    }, ignoreCase: true);
    expect(m.getInt('I'), -123);
    expect(m.getInt('i'), -123);
    expect(m.getDouble('D'), 123.456);
    expect(m.getDouble('d'), 123.456);
    expect(m.getBool('B'), true);
    expect(m.getBool('b'), true);
    expect(m.getString('S'), '_s_');
    expect(m.getString('s'), '_s_');
    expect(m.getJList('A').list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(m.getJList('a').list, [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(m.getJMap('O').map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(m.getJMap('o').map, {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(m.map, {
      'i': -123,
      'd': 123.456,
      's': '_s_',
      'b': true,
      'O': {
        'i': -2,
        'o': {'s': '_s_'}
      },
      'a': [
        -3,
        3.14,
        {'s': '_s_'}
      ]
    });

    // `ignoreCase` should pass to child JMap and JList.
    expect(m.getJMap('o').ignoreCase, true);
    expect(m.getJList('a').ignoreCase, true);
  });

  test('getJMap and missing key (ignore case = false)', () {
    final m = JMap({'v': 0}, ignoreCase: false);
    final o = m.getJMap('o');
    expect(o.ignoreCase, false);
    expect(o.map, <String, dynamic>{});
    o.map['i'] = 2;
    expect(m.map, {'v': 0});
    expect(o.map, {'i': 2});
    expect(m.getJMap('o').map, <String, dynamic>{});
  });

  test('getJMap and missing key (ignore case = true)', () {
    final m = JMap({'v': 0}, ignoreCase: true);
    final o = m.getJMap('o');
    expect(o.ignoreCase, true);
    expect(o.map, <String, dynamic>{});
    o.map['i'] = 2;
    expect(m.map, {'v': 0});
    expect(o.map, {'i': 2});
    expect(m.getJMap('o').map, <String, dynamic>{});
  });

  test('containsKey', () {
    expect(m.containsKey('i'), true);
    expect(m.containsKey('x'), false);
    expect(m.containsKey('I'), false);

    final m2 = JMap({'v': 0}, ignoreCase: true);
    expect(m2.containsKey('v'), true);
    expect(m2.containsKey('V'), true);
  });

  test('getObject', () {
    expect(m.getObject('i'), -123);
    expect(m.getObject('d'), 123.456);
    expect(m.getObject('s'), '_s_');
    expect(m.getObject('b'), true);
    expect(m.getObject('o'), {
      'i': -2,
      'o': {'s': '_s_'}
    });
    expect(m.getObject('a'), [
      -3,
      3.14,
      {'s': '_s_'}
    ]);
    expect(m.getObject('_'), null);
  });
}
