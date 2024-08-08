class KeyValue {
  final int id;
  final String key;
  final String value;

  KeyValue({
    required this.id,
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }

  static KeyValue fromMap(Map<String, dynamic> map) {
    return KeyValue(
      id: map['id'],
      key: map['key'],
      value: map['value'],
    );
  }
}