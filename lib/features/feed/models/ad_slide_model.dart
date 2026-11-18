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
}
