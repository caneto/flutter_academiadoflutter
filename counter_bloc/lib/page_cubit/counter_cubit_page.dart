import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Cubit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(
                  'Counter ${state.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                     context.read<CounterCubit>().increment();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text(''),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text(''),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
