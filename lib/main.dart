import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stateful_widget/core/dependencies.dart';
import 'package:stateful_widget/cubit/home_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeCubitPage(),
    );
  }
}

class HomeCubitPage extends StatelessWidget {
  const HomeCubitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.errorMessage != null)
                    Text(
                      state.errorMessage ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  Text(
                    '${state.number}',
                    style: const TextStyle(fontSize: 60),
                  ),
                  if (state.results != null)
                    Text(
                      '${state.results}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  if (state.isLoading) const CircularProgressIndicator(),
                  ElevatedButton(
                    onPressed: () async {
                      context.read<HomeCubit>().fetchData();
                    },
                    child: const Text(
                      'JAZDA',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
