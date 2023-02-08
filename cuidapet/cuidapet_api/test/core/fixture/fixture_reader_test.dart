import 'dart:io';

import 'package:test/test.dart';

import 'fixture_reader.dart';

void main() {

  test('should return json', () async {
    //Arrange
    //Act
    final json = FixtureReader.getJsonData('core/fixture/fixture_reader_test.json');
    
    //Assert
    expect(json, allOf([
      isNotEmpty
    ]));
  });

  test('should return Map<String, dynamic> ', () async {
    //Arrange
    
    //Act
    final data = FixtureReader.getData<Map<String,dynamic>>('core/fixture/fixture_reader_test.json');

    //Assert
    expect(data, allOf([
      isA<Map<String,dynamic>>(),
    ]));
    expect(data['id'], 1);
  });

   test('should return List ', () async {
    //Arrange
    
    //Act
    final data = FixtureReader.getData<List>('core/fixture/fixture_reader_list_test.json');

    //Assert
    expect(data, isA<List>());
    expect(data.isNotEmpty, isTrue);
    expect(data, isNotEmpty);
    expect(data.length, 2);
    expect(data.first['id'], 1);
  });

  test('should return FileSystemException if is file not found', () async {
    //Arrange
    
    //Act
    var call = FixtureReader.getData;
    
    //Assert
    expect(() => call('error.json'), throwsA(isA<FileSystemException>()));
  });



}