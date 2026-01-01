import 'package:cloud_firestore/cloud_firestore.dart';

class Sticker {
  final String id;
  final String number;
  final String name;
  final String sectionId;
  final bool isOwned;
  final int repeatedCount;

  const Sticker({
    required this.id,
    required this.number,
    required this.name,
    required this.sectionId,
    this.isOwned = false,
    this.repeatedCount = 0,
  });

  Sticker copyWith({
    String? id,
    String? number,
    String? name,
    String? sectionId,
    bool? isOwned,
    int? repeatedCount,
  }) {
    return Sticker(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      sectionId: sectionId ?? this.sectionId,
      isOwned: isOwned ?? this.isOwned,
      repeatedCount: repeatedCount ?? this.repeatedCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name': name,
      'sectionId': sectionId,
      'isOwned': isOwned,
      'repeatedCount': repeatedCount,
    };
  }

  factory Sticker.fromJson(Map<String, dynamic> json) {
    return Sticker(
      id: json['id'] as String,
      number: json['number'] as String,
      name: json['name'] as String,
      sectionId: json['sectionId'] as String,
      isOwned: json['isOwned'] as bool? ?? false,
      repeatedCount: json['repeatedCount'] as int? ?? 0,
    );
  }

  factory Sticker.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Sticker(
      id: doc.id,
      number: data['number'] as String,
      name: data['name'] as String,
      sectionId: data['sectionId'] as String,
      isOwned: data['isOwned'] as bool? ?? false,
      repeatedCount: data['repeatedCount'] as int? ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Sticker && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
