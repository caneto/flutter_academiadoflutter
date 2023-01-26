// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

abstract class CounterState {
  final int counter;

  const CounterState(this.counter);
}

class CounterStateInitial extends CounterState {
  CounterStateInitial() : super(0);

}


class CounterStateData extends CounterState {
  CounterStateData(int counter) : super(counter);
}