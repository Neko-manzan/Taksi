import 'dart:convert';

class Item {
  final String id;
  final String title;
  final bool completed;

  Item({required this.id, required this.title, required this.completed});

  Item copyWith({String? id, String? title, bool? completed}) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'completed': completed};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as String,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}
