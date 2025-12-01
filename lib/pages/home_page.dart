import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/item_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ItemCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(hintText: 'New item'),
                    onSubmitted: (v) => _addItem(),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addItem),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ItemCubit, ItemState>(
              builder: (context, state) {
                if (state.status == ItemStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.items.isEmpty) {
                  return const Center(child: Text('No items'));
                }
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (_, index) {
                    final item = state.items[index];
                    return Dismissible(
                      key: Key(item.id),
                      background: Container(color: Colors.red),
                      onDismissed: (_) {
                        context.read<ItemCubit>().delete(item.id);
                      },
                      child: ListTile(
                        leading: Checkbox(
                          value: item.completed,
                          onChanged: (_) {
                            context.read<ItemCubit>().toggleComplete(item.id);
                          },
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            decoration: item.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<ItemCubit>().delete(item.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    context.read<ItemCubit>().add(text);
    _ctrl.clear();
  }
}
