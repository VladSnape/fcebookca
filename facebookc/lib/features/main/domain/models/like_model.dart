enum Liketype { haha, heart, shock, angry, cry, jaime }

class LikeModel {
  final Liketype liketype;
  final String authorId;

  LikeModel({
    required this.liketype,
    required this.authorId,
  });

  static LikeModel fromMap(Map<String, dynamic> likeData) {
    return LikeModel(
      liketype: _parseLikeType(likeData['liketype']),
      authorId: likeData['authorId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'liketype': liketype.toString().split('.').last, // Convert enum to string
      'authorId': authorId,
    };
  }

  static Liketype _parseLikeType(String? likeTypeString) {
    switch (likeTypeString) {
      case 'haha':
        return Liketype.haha;
      case 'heart':
        return Liketype.heart;
      case 'shock':
        return Liketype.shock;
      case 'angry':
        return Liketype.angry;
      case 'cry':
        return Liketype.cry;
      case 'jaime':
        return Liketype.jaime;
      default:
        throw ArgumentError('Invalid like type string: $likeTypeString');
    }
  }
}
