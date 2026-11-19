import 'package:flutter_test/flutter_test.dart';
import 'package:nbi_web/features/institution/providers/institution_provider.dart';

void main() {
  group('InstitutionProvider Tests', () {
    late InstitutionProvider provider;

    setUp(() {
      provider = InstitutionProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('Initial state has 8 institutions and 0 followed', () {
      expect(provider.institutions.length, 8);
      expect(provider.hasSelection, false);
      expect(provider.selectedCount, 0);
      expect(provider.searchQuery, '');
    });

    test('toggleFollow adds and removes institution from selection', () {
      provider.toggleFollow('inst-1');
      expect(provider.hasSelection, true);
      expect(provider.selectedCount, 1);
      expect(provider.institutions.firstWhere((i) => i.id == 'inst-1').isFollowing, true);

      provider.toggleFollow('inst-1');
      expect(provider.hasSelection, false);
      expect(provider.selectedCount, 0);
      expect(provider.institutions.firstWhere((i) => i.id == 'inst-1').isFollowing, false);
    });

    test('Search filters institutions correctly', () {
      provider.updateSearch('Kendriya');
      expect(provider.institutions.length, 1);
      expect(provider.institutions.first.name, 'Kendriya Vidyalaya Pangode');

      // Clear search restores all 8 institutions
      provider.clearSearch();
      expect(provider.institutions.length, 8);
      expect(provider.searchQuery, '');
    });

    test('Search with no matching terms returns empty list', () {
      provider.updateSearch('NonExistentSchoolXYZ123');
      expect(provider.institutions.isEmpty, true);
    });
  });
}
