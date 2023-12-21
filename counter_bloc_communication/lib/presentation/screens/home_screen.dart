import 'package:counter_bloc/constants/enum.dart';
import 'package:counter_bloc/logic/cubit/counter_cubit.dart';
import 'package:counter_bloc/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                    return const Text(
                      'Wi-Fi',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    );
                  } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
                    return const Text(
                      'Mobile',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    );
                  } else if (state is InternetDisconnected) {
                    return const Text(
                      'Disconnected',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Divider(
                height: 5,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ${state.counterValue}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ${state.counterValue}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    );
                  } else if (state.counterValue == 5) {
                    return const Text(
                      'HMM, NUMBER 5',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    );
                  }
                },
              ),
              // SizedBox(
              //   height: 24,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title}'),
              //       onPressed: () {
              //         BlocProvider.of<CounterCubit>(context).decrement();
              //         // context.bloc<CounterCubit>().decrement();
              //       },
              //       tooltip: 'Decrement',
              //       child: Icon(Icons.remove),
              //     ),
              //     FloatingActionButton(
              //       heroTag: Text('${widget.title} 2nd'),
              //       onPressed: () {
              //         // BlocProvider.of<CounterCubit>(context).increment();
              //         context.bloc<CounterCubit>().increment();
              //       },
              //       tooltip: 'Increment',
              //       child: Icon(Icons.add),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.redAccent,
                child: Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/second',
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/third',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
