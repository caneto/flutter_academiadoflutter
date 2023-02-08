import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:mysql1/mysql1.dart';

import 'mock_result_row.dart';

class MockResults extends Mock implements Results {
  final List<ResultRow> _rows = [];

  @override
  Iterator<ResultRow> get iterator => _rows.iterator;

  @override
  bool get isEmpty => !iterator.moveNext();

  @override
  ResultRow get first {
    final it = iterator;
    if(!it.moveNext()){
      throw Exception();
    }
    return it.current;
  }

  MockResults([String? json, List<String>? blobFields]) {
    if(json != null) {
      final data = jsonDecode(json);
      if(data is List) {
        _rows.addAll(data.map((f) => MockResultRow(f, blobFields)).toList());
      } else {
        _rows.add(MockResultRow(data, blobFields));
      }
    }
  }
}
