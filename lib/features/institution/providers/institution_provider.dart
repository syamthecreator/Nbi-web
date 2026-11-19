import 'package:flutter/material.dart';

import '../models/institution_model.dart';
import '../repositories/institution_repository.dart';

class InstitutionProvider extends ChangeNotifier {
  final InstitutionRepository _repository;
  InstitutionRepository get repository => _repository;

  final List<InstitutionModel> _allInstitutions = [
    const InstitutionModel(
      id: 'inst-1',
      name: 'Kendriya Vidyalaya Pangode',
      location: 'Pangode, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695006',
      badgeColor: Color(0xFF1E3A8A),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-2',
      name: 'Arya Central School',
      location: 'Pattom, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695004',
      badgeColor: Color(0xFFD97706),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-3',
      name: 'St. Joseph\'s Higher Secondary School',
      location: 'General Hospital Jn, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695001',
      badgeColor: Color(0xFF991B1B),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-4',
      name: 'Loyola School Thiruvananthapuram',
      location: 'Sreekariyam, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695017',
      badgeColor: Color(0xFF065F46),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-5',
      name: 'Holy Angels\' Convent HSS',
      location: 'Vanchiyoor, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695035',
      badgeColor: Color(0xFF7C3AED),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-6',
      name: 'Saraswathi Vidyalaya',
      location: 'Vattiyoorkavu, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695013',
      badgeColor: Color(0xFF0284C7),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-7',
      name: 'Chinmaya Vidyalaya',
      location: 'Attukal, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695009',
      badgeColor: Color(0xFFEA580C),
      crestAsset: 'assets/images/salford-crest.png',
    ),
    const InstitutionModel(
      id: 'inst-8',
      name: 'Army Public School Pangode',
      location: 'Cantonment, Thiruvananthapuram',
      city: 'Thiruvananthapuram',
      pincode: '695006',
      badgeColor: Color(0xFF15803D),
      crestAsset: 'assets/images/salford-crest.png',
    ),
  ];

  final Set<String> _selectedInstitutionIds = {};
  Set<String> get selectedInstitutionIds =>
      Set.unmodifiable(_selectedInstitutionIds);

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  bool get isSearchFocused => _isSearchFocused;

  bool get hasSelection => _selectedInstitutionIds.isNotEmpty;
  int get selectedCount => _selectedInstitutionIds.length;

  List<InstitutionModel> get institutions => filteredInstitutions;
  List<InstitutionModel> get followedInstitutions => _allInstitutions
      .where((i) => _selectedInstitutionIds.contains(i.id))
      .toList();

  List<InstitutionModel> get filteredInstitutions {
    if (_searchQuery.trim().isEmpty) {
      return _allInstitutions.map((inst) {
        return inst.copyWith(
          isFollowing: _selectedInstitutionIds.contains(inst.id),
        );
      }).toList();
    }
    final q = _searchQuery.toLowerCase().trim();
    return _allInstitutions
        .where((inst) {
          return inst.name.toLowerCase().contains(q) ||
              inst.location.toLowerCase().contains(q) ||
              inst.city.toLowerCase().contains(q) ||
              inst.pincode.contains(q);
        })
        .map((inst) {
          return inst.copyWith(
            isFollowing: _selectedInstitutionIds.contains(inst.id),
          );
        })
        .toList();
  }

  InstitutionProvider({InstitutionRepository? repository})
    : _repository = repository ?? InstitutionRepositoryImpl() {
    searchFocusNode.addListener(_onSearchFocusChanged);
  }

  void _onSearchFocusChanged() {
    if (_isSearchFocused != searchFocusNode.hasFocus) {
      _isSearchFocused = searchFocusNode.hasFocus;
      notifyListeners();
    }
  }

  void updateSearch(String query) {
    _searchQuery = query;
    if (searchController.text != query) {
      searchController.value = TextEditingValue(
        text: query,
        selection: TextSelection.collapsed(offset: query.length),
      );
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    searchFocusNode.removeListener(_onSearchFocusChanged);
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void toggleFollow(String id) {
    if (_selectedInstitutionIds.contains(id)) {
      _selectedInstitutionIds.remove(id);
    } else {
      _selectedInstitutionIds.add(id);
    }
    notifyListeners();
  }

  void selectAll() {
    for (final inst in _allInstitutions) {
      _selectedInstitutionIds.add(inst.id);
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedInstitutionIds.clear();
    notifyListeners();
  }
}
