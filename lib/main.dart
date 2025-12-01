import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/item_repository.dart';
import 'cubit/item_cubit.dart';
import 'pages/home_page.dart';

void main() {
  final repo = ItemRepository();
  runApp(MyApp(repository: repo));
}

class MyApp extends StatelessWidget {
  final ItemRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => ItemCubit(repository: repository),
        child: MaterialApp(
          title: 'Taksi',
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
