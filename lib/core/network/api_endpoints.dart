/// Centralized API endpoint constants for NBI services.
class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://api.noticeboardindia.com/v1';

  // Auth & User
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // Workspaces
  static const String workspaces = '/workspaces';
  static const String createWorkspace = '/workspaces/create';
  static const String checkSubdomain = '/workspaces/check-subdomain';

  // Institutions & Classes
  static const String institutions = '/institutions';
  static const String searchInstitutions = '/institutions/search';
  static const String followInstitution = '/institutions/follow';
  static const String classDivisions = '/institutions/classes';

  // Feed & Posts
  static const String feedPosts = '/feed/posts';
  static const String feedCategories = '/feed/categories';
  static const String sponsoredAds = '/feed/sponsored';
  static const String likePost = '/feed/posts/like';
  static const String bookmarkPost = '/feed/posts/bookmark';
}
