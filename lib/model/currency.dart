import 'dart:convert';

class Currency {
  final String name;
  final String code;

  const Currency({
    required this.name,
    required this.code,
  });

  Currency copyWith({
    String? name,
    String? code,
  }) {
    return Currency(
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      name: map['name'],
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() => 'Currency(name: $name, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}
