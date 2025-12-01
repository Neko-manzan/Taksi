import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/item.dart';
import '../repository/item_repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final ItemRepository repository;
  final _uuid = Uuid();

  ItemCubit({required this.repository}) : super(ItemState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: ItemStatus.loading));
    final items = await repository.loadItems();
    emit(state.copyWith(status: ItemStatus.loaded, items: items));
  }

  Future<void> add(String title) async {
    final newItem = Item(id: _uuid.v4(), title: title, completed: false);
    final updated = [...state.items, newItem];
    emit(state.copyWith(items: updated));
    await repository.saveItems(updated);
  }

  Future<void> toggleComplete(String id) async {
    final updated = state.items.map((i) {
      if (i.id == id) return i.copyWith(completed: !i.completed);
      return i;
    }).toList();
    emit(state.copyWith(items: updated));
    await repository.saveItems(updated);
  }

  Future<void> delete(String id) async {
    final updated = state.items.where((i) => i.id != id).toList();
    emit(state.copyWith(items: updated));
    await repository.saveItems(updated);
  }
}
