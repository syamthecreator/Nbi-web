/// Strongly-typed Carousel Advertisement model for feed sidebar.
class AdSlideModel {
  final int id;
  final String title;
  final String description;
  final String mediaAsset;
  final bool isVideo;
  final String actionText;
  final String discountTag;

  const AdSlideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaAsset,
    this.isVideo = false,
    required this.actionText,
    this.discountTag = 'UP TO 40% OFF',
  });

  AdSlideModel copyWith({
    int? id,
    String? title,
    String? description,
    String? mediaAsset,
    bool? isVideo,
    String? actionText,
    String? discountTag,
  }) {
    return AdSlideModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaAsset: mediaAsset ?? this.mediaAsset,
      isVideo: isVideo ?? this.isVideo,
      actionText: actionText ?? this.actionText,
      discountTag: discountTag ?? this.discountTag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'mediaAsset': mediaAsset,
      'isVideo': isVideo,
      'actionText': actionText,
      'discountTag': discountTag,
    };
  }

  factory AdSlideModel.fromJson(Map<String, dynamic> json) {
    return AdSlideModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      mediaAsset: json['mediaAsset'] as String,
      isVideo: json['isVideo'] as bool? ?? false,
      actionText: json['actionText'] as String,
      discountTag: json['discountTag'] as String? ?? 'UP TO 40% OFF',
    );
  }
}
