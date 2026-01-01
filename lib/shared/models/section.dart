import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  final String id;
  final String name;
  final String? imageUrl;
  final int totalStickers;
  final int order;

  const Section({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.totalStickers,
    required this.order,
  });

  Section copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? totalStickers,
    int? order,
  }) {
    return Section(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      totalStickers: totalStickers ?? this.totalStickers,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'totalStickers': totalStickers,
      'order': order,
    };
  }

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      totalStickers: json['totalStickers'] as int,
      order: json['order'] as int,
    );
  }

  factory Section.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Section(
      id: doc.id,
      name: data['name'] as String,
      imageUrl: data['imageUrl'] as String?,
      totalStickers: data['totalStickers'] as int,
      order: data['order'] as int? ?? 0,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Section && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
