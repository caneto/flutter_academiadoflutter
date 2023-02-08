
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFazAlgo extends Mock implements FazAlgo {
  @override
  Future<void> teste() async {
      
  }
}

void main() {
  var mock = MockFazAlgo();
  
  test('testar', () async {
    //Arrange
    when(() => mock.teste()).thenAnswer((_) async {});
    //Act
    Testar(mock).fazer();
    //Assert
    verify(() => mock.teste());//.called(1);
  });

}


class Testar {
  FazAlgo fazAlgo;

  Testar(this.fazAlgo);

  void fazer(){
    fazAlgo.teste();
  }

}


class FazAlgo {

  Future<void> teste() async {}

}