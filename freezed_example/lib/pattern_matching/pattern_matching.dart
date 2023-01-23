import 'package:freezed_annotation/freezed_annotation.dart';

part 'pattern_matching.freezed.dart';

@freezed
class Union with _$Union {
  factory Union(int value) = UnionData;
  factory Union.loading() = UnionLoading;
  factory Union.error([String? message]) = UnionError;
}

void main() {
  var union = Union(1);

  /*
    when
    maybeWhen
    map
    maybeMap*
  */

  var mensagem = union.when<String>(
    (value) => 'Union Data implementando',
    loading: () => 'Loading implementado',
    error: (String? message) => 'Erro implentado',
  );

  var mensagemMaybe = union.maybeWhen(
    null,
    loading: () => 'Loading implementado',
    orElse: () => 'Padrão implemtentado',
  );

  var mensagemMap = union.map(
    (UnionData value) => '${value.runtimeType} implementado',
    loading: (UnionLoading loading) => '${loading.runtimeType} implementado', 
    error: (UnionError error) => '${error.runtimeType} implementado',
  );

  print(mensagem);
  print(mensagemMaybe);

}
