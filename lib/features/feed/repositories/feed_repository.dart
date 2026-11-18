import '../models/ad_slide_model.dart';
import '../models/post_model.dart';
import '../services/feed_service.dart';

abstract class FeedRepository {
  Future<List<PostModel>> getPosts({String? category, String? query});
  Future<List<AdSlideModel>> getAdSlides();
  List<PostModel> getDefaultPosts();
  List<AdSlideModel> getDefaultAdSlides();
}

class FeedRepositoryImpl implements FeedRepository {
  final FeedService feedService;

  FeedRepositoryImpl({FeedService? service})
    : feedService = service ?? FeedServiceImpl();

  @override
  Future<List<PostModel>> getPosts({String? category, String? query}) async {
    final remote = await feedService.fetchPosts(
      category: category,
      query: query,
    );
    if (remote.isNotEmpty) return remote;
    return getDefaultPosts();
  }

  @override
  Future<List<AdSlideModel>> getAdSlides() async {
    final remote = await feedService.fetchAdSlides();
    if (remote.isNotEmpty) return remote;
    return getDefaultAdSlides();
  }

  @override
  List<PostModel> getDefaultPosts() {
    return const [
      PostModel(
        id: 'post-1',
        schoolName: 'Kendriya Vidyalaya Pangode',
        schoolLogo: 'assets/images/salford-crest.png',
        authorMeta: 'Principal • 2 hours ago',
        category: 'announcements',
        badgeText: 'URGENT NOTICE',
        badgeType: 'urgent',
        title: 'Tomorrow Holiday Declared Due To Heavy Rain Red Alert',
        content: 'As per the official notification issued by the District Collector, a red alert has been sounded across the district. Consequently, tomorrow has been declared a holiday for all classes from LKG through Grade XII. Online assignments will be posted on the student dashboard.',
        attachmentName: 'official_collector_order_rain_holiday.pdf',
        attachmentSize: '1.2 MB',
        likesCount: 142,
        isPinned: true,
      ),
      PostModel(
        id: 'post-2',
        schoolName: 'St. Mary\'s Higher Secondary School',
        schoolLogo: 'assets/images/salford-crest.png',
        authorMeta: 'Mathematics Dept • 4 hours ago',
        category: 'homework',
        badgeText: 'HOMEWORK',
        badgeType: 'homework',
        title: 'Grade X Mathematics - Chapter 7 Trigonometry Exercises',
        content: 'Please complete exercises 7.1, 7.2, and 7.3 from NCERT Part 1. Submit your homework notebook on Wednesday morning before the first period. Late submissions will result in internal mark deductions.',
        attachmentName: 'trigonometry_practice_worksheet.pdf',
        attachmentSize: '850 KB',
        likesCount: 38,
      ),
      PostModel(
        id: 'post-3',
        schoolName: 'Carmel Girls Higher Secondary School',
        schoolLogo: 'assets/images/carmel-crest.png',
        authorMeta: 'Arts & Cultural Committee • 1 day ago',
        category: 'events',
        badgeText: 'ANNUAL SPORTS',
        badgeType: 'events',
        title: 'Annual Sports Meet 2024 - Schedule and Event Registration',
        content: 'The 45th Annual Sports Meet will be held on December 15th at the Central Stadium. House captains must submit participant lists for track and field events to the Physical Education office before Friday.',
        attachmentName: 'sports_meet_event_schedule.pdf',
        attachmentSize: '2.4 MB',
        likesCount: 95,
      ),
      PostModel(
        id: 'post-4',
        schoolName: 'Oxford Model High School',
        schoolLogo: 'assets/images/salford-crest.png',
        authorMeta: 'Accounts Department • 2 days ago',
        category: 'fees',
        badgeText: 'FEES REMINDER',
        badgeType: 'fees',
        title: 'Term II Tuition Fee Payment Deadline - December 10, 2024',
        content: 'Parents are requested to settle the Term II fees on or before December 10th through the parent payment portal or UPI transfer. Receipts will be issued instantly on the dashboard.',
        attachmentName: 'fee_structure_and_payment_links.pdf',
        attachmentSize: '450 KB',
        likesCount: 22,
      ),
    ];
  }

  @override
  List<AdSlideModel> getDefaultAdSlides() {
    return const [
      AdSlideModel(
        id: 1,
        title: 'Premium Oxford Backpacks & Kits',
        description: 'Ergonomic, spine-friendly school bags with 2-year replacement warranty.',
        mediaAsset: 'assets/images/school_books_ad.jpg',
        actionText: 'Explore Collection',
        discountTag: 'UP TO 40% OFF',
      ),
      AdSlideModel(
        id: 2,
        title: 'Complete NCERT & Reference Bundles',
        description: 'Class 1 to 12 CBSE & State syllabus textbooks at exclusive school partner rates.',
        mediaAsset: 'assets/images/ads-stationery.png',
        actionText: 'Buy Textbooks',
        discountTag: 'FLAT 25% OFF',
      ),
      AdSlideModel(
        id: 3,
        title: 'Deluxe Geometry & Artist Color Sets',
        description: 'Faber-Castell, Camlin, and Classmate stationery combos for students.',
        mediaAsset: 'assets/images/ads-stationery.png',
        actionText: 'Order Stationery',
        discountTag: 'BUY 1 GET 1',
      ),
    ];
  }
}
