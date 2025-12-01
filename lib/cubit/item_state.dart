part of 'item_cubit.dart';

enum ItemStatus { initial, loading, loaded }

class ItemState {
  final ItemStatus status;
  final List<Item> items;

  ItemState({required this.status, required this.items});

  factory ItemState.initial() =>
      ItemState(status: ItemStatus.initial, items: []);

  ItemState copyWith({ItemStatus? status, List<Item>? items}) {
    return ItemState(status: status ?? this.status, items: items ?? this.items);
  }
}
