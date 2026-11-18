import 'package:flutter/material.dart';
import '../models/class_division_model.dart';
import '../repositories/class_division_repository.dart';

/// Pure Stateless architecture with Provider. Zero setState().
class ClassDivisionProvider extends ChangeNotifier {
  final ClassDivisionRepository _repository;
  ClassDivisionRepository get repository => _repository;
  List<SchoolConfigModel> _schools = [];
  List<SchoolConfigModel> get schools => List.unmodifiable(_schools);

  ClassDivisionProvider({ClassDivisionRepository? repository})
      : _repository = repository ?? ClassDivisionRepositoryImpl() {
    _initDefaults();
  }

  void _initDefaults() {
    _schools = [
      const SchoolConfigModel(
        id: 'inst-st-marys',
        name: "St. Mary's Higher Secondary School",
        crestAsset: 'assets/images/salford-crest.png',
        classes: ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'],
        divisions: ['A', 'B', 'C', 'D', 'E'],
      ),
      const SchoolConfigModel(
        id: 'inst-carmel-girls',
        name: 'Carmel Girls Higher Secondary School',
        crestAsset: 'assets/images/carmel-crest.png',
        classes: ['LKG', 'UKG', '1st', '2nd', '3rd', '4th', '5rd', '6th'],
        divisions: ['A', 'B', 'C', 'D', 'E'],
      ),
    ];
  }

  void syncWithFollowedInstitutions(List<dynamic> followed) {
    if (followed.isEmpty) return;

    final updated = followed.asMap().entries.map((entry) {
      final item = entry.value;
      final String id;
      final String name;
      final String crestAsset;

      if (item is String) {
        id = 'inst-${entry.key + 1}';
        name = item;
        crestAsset = 'assets/images/salford-crest.png';
      } else {
        id = (item as dynamic).id as String;
        name = (item as dynamic).name as String;
        crestAsset = (item as dynamic).crestAsset as String? ?? 'assets/images/salford-crest.png';
      }

      final existing = _schools.cast<SchoolConfigModel?>().firstWhere(
            (s) => s?.id == id || s?.name == name,
            orElse: () => null,
          );

      return SchoolConfigModel(
        id: id,
        name: name,
        crestAsset: crestAsset,
        classes: const ['LKG', 'UKG', '1', '2', '3', '4', '5', '6'],
        divisions: const ['A', 'B', 'C', 'D', 'E'],
        selectedClass: existing?.selectedClass,
        selectedDivision: existing?.selectedDivision,
      );
    }).toList();

    _schools = updated;
    notifyListeners();
  }

  void selectClass(String schoolId, String className) {
    _schools = _schools.map((school) {
      if (school.id == schoolId) {
        if (school.selectedClass == className) {
          return school.copyWith(clearClass: true);
        } else {
          return school.copyWith(selectedClass: className);
        }
      }
      return school;
    }).toList();
    notifyListeners();
  }

  void selectDivision(String schoolId, String divisionName) {
    _schools = _schools.map((school) {
      if (school.id == schoolId) {
        if (school.selectedDivision == divisionName) {
          return school.copyWith(clearDivision: true);
        } else {
          return school.copyWith(selectedDivision: divisionName);
        }
      }
      return school;
    }).toList();
    notifyListeners();
  }

  bool get hasAnySelection {
    return _schools.any((s) => s.selectedClass != null || s.selectedDivision != null);
  }

  bool get isAllConfigured {
    return _schools.isNotEmpty && _schools.every((s) => s.isConfigured);
  }
}
