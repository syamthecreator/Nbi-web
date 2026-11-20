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
        authorMeta: 'Admin • Just now',
        category: 'announcements',
        badgeText: '📌 URGENT',
        badgeType: 'urgent',
        title: 'School Closed Tomorrow Due to Weather',
        content:
            'Dear Parents, due to the severe weather warnings for tomorrow, the school will remain closed for all classes. Online assignments have been uploaded to the portal. Please ensure students complete them by Friday. Stay safe.',
        likesCount: 124,
      ),
      PostModel(
        id: 'post-2',
        schoolName: 'Carmel Girls Higher Secondary School',
        schoolLogo: 'assets/images/carmel-crest.png',
        authorMeta: 'Tr-maths-001 • 07:05 PM',
        category: 'homework',
        badgeText: 'HOMEWORK',
        badgeType: 'homework',
        title: 'Fractions Worksheet - Chapter 4',
        content:
            'Please have students complete pages 45-47 in their math workbooks. Focus on mixed numbers and improper fractions. We will review this in class on Thursday.',
        attachmentName: 'Ch4_Fractions_Guide.pdf',
        attachmentSize: '1.2 MB',
        likesCount: 124,
      ),
      PostModel(
        id: 'post-3',
        schoolName: "St. Joseph's Higher Secondary School",
        schoolLogo: 'assets/images/joseph-crest.png',
        authorMeta: 'Sports-Dept • Yesterday',
        category: 'events',
        badgeText: '🏆 EVENTS',
        badgeType: 'events',
        title: 'Annual Sports Day 2026 Registration Open',
        content:
            'We are excited to announce our Annual Sports Meet scheduled for September 25th. Registration for track events, basketball, relay, and chess is now open for classes 5 to 12. Students can submit their entries to house captains by Friday.',
        likesCount: 98,
      ),
      PostModel(
        id: 'post-4',
        schoolName: 'Loyola School Thiruvananthapuram',
        schoolLogo: 'assets/images/loyola-crest.png',
        authorMeta: 'Accounts • 2 days ago',
        category: 'fees',
        badgeText: '💳 FEES',
        badgeType: 'fees',
        title: 'Term 2 Fee Payment Due Date Reminder',
        content:
            'Dear Parents, this is a reminder that the Term 2 tuition and transportation fee payment deadline is September 15th. You can make payments online via the NBI Parent Portal or directly at the school accounts counter.',
        attachmentName: 'Term2_Fee_Structure_2026.pdf',
        attachmentSize: '850 KB',
        likesCount: 156,
      ),
      PostModel(
        id: 'post-5',
        schoolName: "St. Mary's Higher Secondary School",
        schoolLogo: 'assets/images/salford-crest.png',
        authorMeta: 'Vice-Principal • 3 days ago',
        category: 'announcements',
        badgeText: '📢 ANNOUNCEMENT',
        badgeType: 'announcement',
        title: 'Parent-Teacher Meeting (PTM) Schedule - Mid Term',
        content:
            'Mid-term progress report PTM will be conducted on Saturday, September 12th from 9:00 AM to 1:00 PM. Parents are requested to adhere to the time slots shared with students via their class handbooks.',
        likesCount: 210,
      ),
      PostModel(
        id: 'post-6',
        schoolName: 'Carmel Girls Higher Secondary School',
        schoolLogo: 'assets/images/carmel-crest.png',
        authorMeta: 'Tr-science-004 • 4 days ago',
        category: 'homework',
        badgeText: 'HOMEWORK',
        badgeType: 'homework',
        title: 'Science Fair Project Proposal Submission',
        content:
            'All 8th and 9th grade students are required to submit their Science Fair project proposal outlines by Monday. Please include hypothesis, list of materials, and safety guidelines.',
        attachmentName: 'Science_Fair_Project_Guidelines.pdf',
        attachmentSize: '1.5 MB',
        likesCount: 89,
      ),
    ];
  }

  @override
  List<AdSlideModel> getDefaultAdSlides() {
    return const [
      AdSlideModel(
        id: 1,
        title: '🎬 Student Life & Sports Highlights',
        description:
            'Explore sports meets, science exhibitions, robotics clubs & annual cultural fest moments.',
        mediaAsset: 'assets/video/vid2.mp4',
        actionText: 'Watch Highlights',
        discountTag: 'UP TO 40% OFF',
        isVideo: true,
      ),
      AdSlideModel(
        id: 2,
        title: '📚 School Textbooks & Exam Guides',
        description:
            'Order CBSE, ICSE & State Board textbooks, lab manuals & sample papers delivered to your doorstep.',
        mediaAsset: 'assets/images/school_books_ad.jpg',
        actionText: 'Shop Books Now',
        discountTag: 'UP TO 40% OFF',
        isVideo: false,
      ),
      AdSlideModel(
        id: 3,
        title: '🎥 Smart Learning & Campus Tour',
        description:
            'Discover interactive digital learning tools, lab resources & smart classrooms in action.',
        mediaAsset: 'assets/video/vid.mp4',
        actionText: 'Watch Campus Tour',
        discountTag: 'UP TO 40% OFF',
        isVideo: true,
      ),
    ];
  }
}
