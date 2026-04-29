class KamusModel {
  final int id;
  final String kata;
  final String arti;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  KamusModel({
    required this.id,
    required this.kata,
    required this.arti,
    this.createdAt,
    this.updatedAt,
  });

  factory KamusModel.fromJson(Map<String, dynamic> json) {
    return KamusModel(
      id: json['id'] ?? 0,
      kata: json['kata'] ?? '',
      arti: json['arti'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kata': kata,
      'arti': arti,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// For sqflite favorite storage
  Map<String, dynamic> toMap() {
    return {'id': id, 'kata': kata, 'arti': arti};
  }

  factory KamusModel.fromMap(Map<String, dynamic> map) {
    return KamusModel(id: map['id'], kata: map['kata'], arti: map['arti']);
  }
}
