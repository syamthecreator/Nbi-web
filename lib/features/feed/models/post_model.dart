/// Strongly-typed Feed Post entity.
class PostModel {
  final String id;
  final String schoolName;
  final String schoolLogo;
  final String authorMeta;
  final String category; // 'announcements', 'homework', 'events', 'fees'
  final String badgeText;
  final String badgeType; // 'urgent', 'homework', 'events', 'fees', 'announcement'
  final String title;
  final String content;
  final String? attachmentName;
  final String? attachmentSize;
  final int likesCount;
  final bool isLiked;
  final bool isBookmarked;
  final bool isPinned;
  final bool isMuted;

  const PostModel({
    required this.id,
    required this.schoolName,
    required this.schoolLogo,
    required this.authorMeta,
    required this.category,
    required this.badgeText,
    required this.badgeType,
    required this.title,
    required this.content,
    this.attachmentName,
    this.attachmentSize,
    required this.likesCount,
    this.isLiked = false,
    this.isBookmarked = false,
    this.isPinned = false,
    this.isMuted = false,
  });

  PostModel copyWith({
    String? id,
    String? schoolName,
    String? schoolLogo,
    String? authorMeta,
    String? category,
    String? badgeText,
    String? badgeType,
    String? title,
    String? content,
    String? attachmentName,
    String? attachmentSize,
    int? likesCount,
    bool? isLiked,
    bool? isBookmarked,
    bool? isPinned,
    bool? isMuted,
  }) {
    return PostModel(
      id: id ?? this.id,
      schoolName: schoolName ?? this.schoolName,
      schoolLogo: schoolLogo ?? this.schoolLogo,
      authorMeta: authorMeta ?? this.authorMeta,
      category: category ?? this.category,
      badgeText: badgeText ?? this.badgeText,
      badgeType: badgeType ?? this.badgeType,
      title: title ?? this.title,
      content: content ?? this.content,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentSize: attachmentSize ?? this.attachmentSize,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolName': schoolName,
      'schoolLogo': schoolLogo,
      'authorMeta': authorMeta,
      'category': category,
      'badgeText': badgeText,
      'badgeType': badgeType,
      'title': title,
      'content': content,
      'attachmentName': attachmentName,
      'attachmentSize': attachmentSize,
      'likesCount': likesCount,
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'isPinned': isPinned,
      'isMuted': isMuted,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      schoolName: json['schoolName'] as String,
      schoolLogo: json['schoolLogo'] as String,
      authorMeta: json['authorMeta'] as String,
      category: json['category'] as String,
      badgeText: json['badgeText'] as String,
      badgeType: json['badgeType'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      attachmentName: json['attachmentName'] as String?,
      attachmentSize: json['attachmentSize'] as String?,
      likesCount: json['likesCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isPinned: json['isPinned'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
    );
  }
}
