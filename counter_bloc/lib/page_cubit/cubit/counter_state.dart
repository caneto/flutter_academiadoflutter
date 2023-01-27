// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

abstract class CounterState  extends Equatable {
  final int counter;
  const CounterState(this.counter);

  @override
  List<Object> get props => [counter];

}

class CounterStateInitial extends CounterState {
  const CounterStateInitial() : super(0);

}


class CounterStateData extends CounterState {
  const CounterStateData(int counter) : super(counter);
}