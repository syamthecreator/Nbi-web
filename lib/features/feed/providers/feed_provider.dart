import 'dart:async';

import 'package:flutter/material.dart';

import '../models/ad_slide_model.dart';
import '../models/post_model.dart';
import '../repositories/feed_repository.dart';

class FeedProvider extends ChangeNotifier {
  final FeedRepository _repository;

  String _selectedCategory = 'all';
  String get selectedCategory => _selectedCategory;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String? _toastMessage;
  String? get toastMessage => _toastMessage;

  // Active Sponsored Slideshow
  int _currentAdSlide = 0;
  int get currentAdSlide => _currentAdSlide;
  Timer? _adSlideTimer;

  List<AdSlideModel> _adSlides = [];
  List<AdSlideModel> get adSlides => List.unmodifiable(_adSlides);

  List<PostModel> _posts = [];
  List<PostModel> get posts => List.unmodifiable(_posts);

  FeedProvider({FeedRepository? repository})
    : _repository = repository ?? FeedRepositoryImpl() {
    _initData();
  }

  void _initData() {
    _adSlides = _repository.getDefaultAdSlides();
    _posts = _repository.getDefaultPosts();
  }

  void startSlideshow() {
    _startAdSlideshow();
  }

  void stopSlideshow() {
    _adSlideTimer?.cancel();
    _adSlideTimer = null;
  }

  List<PostModel> get filteredPosts {
    return _posts.where((post) {
      final matchesCategory =
          _selectedCategory == 'all' || post.category == _selectedCategory;
      if (!matchesCategory) return false;

      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.toLowerCase().trim();
      return post.title.toLowerCase().contains(q) ||
          post.content.toLowerCase().contains(q) ||
          post.schoolName.toLowerCase().contains(q);
    }).toList();
  }

  void setCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void toggleLike(String postId) {
    _posts = _posts.map((post) {
      if (post.id == postId) {
        final newLiked = !post.isLiked;
        final newCount = newLiked ? post.likesCount + 1 : post.likesCount - 1;
        return post.copyWith(isLiked: newLiked, likesCount: newCount);
      }
      return post;
    }).toList();
    notifyListeners();
  }

  void toggleBookmark(String postId) {
    _posts = _posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(isBookmarked: !post.isBookmarked);
      }
      return post;
    }).toList();
    notifyListeners();
  }

  void togglePin(String postId) {
    PostModel? targetPost;
    _posts = _posts.map((post) {
      if (post.id == postId) {
        final newPinned = !post.isPinned;
        targetPost = post.copyWith(isPinned: newPinned);
        return targetPost!;
      }
      return post;
    }).toList();

    if (targetPost != null && targetPost!.isPinned) {
      _posts.removeWhere((p) => p.id == postId);
      _posts.insert(0, targetPost!);
      showToast('📌 Announcement pinned to the top of your feed!');
    } else {
      showToast('📍 Announcement unpinned.');
    }

    notifyListeners();
  }

  void toggleMute(String schoolName) {
    bool nowMuted = false;
    _posts = _posts.map((post) {
      if (post.schoolName == schoolName) {
        nowMuted = !post.isMuted;
        return post.copyWith(isMuted: nowMuted);
      }
      return post;
    }).toList();

    if (nowMuted) {
      showToast('🔕 Alerts muted for $schoolName.');
    } else {
      showToast('🔔 Alerts unmuted for $schoolName.');
    }
    notifyListeners();
  }

  void reportPost(String postId) {
    showToast('🚩 Announcement reported to school administrators for review.');
  }

  void copyPostLink(String postTitle) {
    showToast('🔗 Direct notice link copied to clipboard!');
  }

  void sharePost(String postTitle) {
    showToast('🔗 Post link copied to clipboard!');
  }

  void showToast(String msg) {
    _toastMessage = msg;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      if (_toastMessage == msg) {
        _toastMessage = null;
        notifyListeners();
      }
    });
  }

  void clearToast() {
    _toastMessage = null;
    notifyListeners();
  }

  // Ad Carousel Controls
  void _startAdSlideshow() {
    _adSlideTimer?.cancel();
    if (_adSlides.isEmpty) return;
    _adSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _currentAdSlide = (_currentAdSlide + 1) % _adSlides.length;
      notifyListeners();
    });
  }

  void setAdSlide(int index) {
    if (index >= 0 && index < _adSlides.length) {
      _currentAdSlide = index;
      _startAdSlideshow();
      notifyListeners();
    }
  }

  void nextAdSlide() {
    if (_adSlides.isEmpty) return;
    _currentAdSlide = (_currentAdSlide + 1) % _adSlides.length;
    _startAdSlideshow();
    notifyListeners();
  }

  void prevAdSlide() {
    if (_adSlides.isEmpty) return;
    _currentAdSlide =
        (_currentAdSlide - 1 + _adSlides.length) % _adSlides.length;
    _startAdSlideshow();
    notifyListeners();
  }

  @override
  void dispose() {
    _adSlideTimer?.cancel();
    super.dispose();
  }
}
