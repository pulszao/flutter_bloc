import 'package:counter_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                final snackBar = SnackBar(
                  content: Text(state.wasIncremented ? 'Incremented!' : 'Decremented!'),
                  duration: const Duration(milliseconds: 300),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              builder: (context, state) {
                return Text(
                  _buildDisplayText(state),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            // ... Rest of your code
          ],
        ),
      ),
    );
  }

  String _buildDisplayText(CounterState state) {
    if (state.counterValue < 0) {
      return 'BRR, NEGATIVE ${state.counterValue}';
    } else if (state.counterValue % 2 == 0) {
      return 'YAAAY ${state.counterValue}';
    } else if (state.counterValue == 5) {
      return 'HMM, NUMBER 5';
    } else {
      return state.counterValue.toString();
    }
  }

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: widget.title,
          backgroundColor: widget.color,
          onPressed: () => context.read<CounterCubit>().decrement(),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        FloatingActionButton(
          heroTag: '${widget.title} 2nd',
          backgroundColor: widget.color,
          onPressed: () => context.read<CounterCubit>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
