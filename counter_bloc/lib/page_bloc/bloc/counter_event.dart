part of 'counter_bloc.dart';

abstract class CounterEvent {

}

class CounterIncrement extends CounterEvent {}
class CounterDecrement extends CounterEvent {}