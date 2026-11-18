import '../../../core/services/base_service.dart';
import '../models/ad_slide_model.dart';
import '../models/post_model.dart';

abstract class FeedService extends BaseService {
  FeedService({super.client});

  Future<List<PostModel>> fetchPosts({String? category, String? query});
  Future<List<AdSlideModel>> fetchAdSlides();
}

class FeedServiceImpl extends FeedService {
  FeedServiceImpl({super.client});

  @override
  Future<List<PostModel>> fetchPosts({String? category, String? query}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [];
  }

  @override
  Future<List<AdSlideModel>> fetchAdSlides() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [];
  }
}
