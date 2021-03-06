class ItemSet {
  final int id;
  String name;
  List<String> items;
  int position;

  ItemSet({this.id, this.name, this.items, this.position});

  Map<String, dynamic> toMap() {
    String idString = items.join("|");

    return {'id': id, 'name': name, 'items': idString, 'position': position};
  }

  // Implement toString to make it easier to see information about
  // each Preset when using the print statement.
  @override
  String toString() {
    return 'Preset{id: $id, name: $name, item_ids: $items, position: $position}';
  }
}
