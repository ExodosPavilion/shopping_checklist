class Item {
  final int id;
  String item;
  int priority;
  bool checked;
  int position;
  int presetId;

  Item(
      {this.id,
      this.item,
      this.priority,
      this.checked,
      this.position,
      this.presetId = -1});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item,
      'priority': priority,
      'checked': checked ? 1 : 0,
      'position': position,
      'presetId': presetId,
    };
  }

  // Implement toString to make it easier to see information about
  // each Item when using the print statement.
  @override
  String toString() {
    return 'Item{id: $id, item: $item, prioirty: $priority, checked: $checked, position: $position, presetId: $presetId}';
  }
}
