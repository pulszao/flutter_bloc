import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc/logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
                if (state.counterValue > 0 && state.counterValue % 5 == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Multiple of 5!'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  _buildDisplayText(state),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            _buildNavigationButtons(context),
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
          heroTag: '${widget.title}',
          onPressed: () => context.read<CounterCubit>().decrement(),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
        FloatingActionButton(
          heroTag: '${widget.title} 2nd',
          onPressed: () => context.read<CounterCubit>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Column _buildNavigationButtons(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          color: Colors.redAccent,
          child: const Text(
            'Go to Second Screen',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/second');
          },
        ),
        const SizedBox(height: 24),
        MaterialButton(
          color: Colors.greenAccent,
          child: const Text(
            'Go to Third Screen',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed('/third');
          },
        ),
      ],
    );
  }
}
