class UserSticker {
  final String stickerId;
  final bool isOwned;
  final int repeatedCount;
  final DateTime? updatedAt;

  const UserSticker({
    required this.stickerId,
    this.isOwned = false,
    this.repeatedCount = 0,
    this.updatedAt,
  });

  UserSticker copyWith({
    String? stickerId,
    bool? isOwned,
    int? repeatedCount,
    DateTime? updatedAt,
  }) {
    return UserSticker(
      stickerId: stickerId ?? this.stickerId,
      isOwned: isOwned ?? this.isOwned,
      repeatedCount: repeatedCount ?? this.repeatedCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stickerId': stickerId,
      'isOwned': isOwned,
      'repeatedCount': repeatedCount,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserSticker.fromJson(Map<String, dynamic> json) {
    return UserSticker(
      stickerId: json['stickerId'] as String,
      isOwned: json['isOwned'] as bool? ?? false,
      repeatedCount: json['repeatedCount'] as int? ?? 0,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserSticker && other.stickerId == stickerId;
  }

  @override
  int get hashCode => stickerId.hashCode;
}
