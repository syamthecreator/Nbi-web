import 'package:flutter_test/flutter_test.dart';
import 'package:nbi_web/features/class_division/providers/class_division_provider.dart';

void main() {
  group('ClassDivisionProvider Tests', () {
    late ClassDivisionProvider provider;

    setUp(() {
      provider = ClassDivisionProvider();
    });

    test('Initial state has default schools and no selection', () {
      expect(provider.schools.length, 2);
      expect(provider.hasAnySelection, false);
      expect(provider.isAllConfigured, false);
    });

    test('selectClass sets and deselects class', () {
      final schoolId = provider.schools.first.id;
      provider.selectClass(schoolId, '1');
      expect(provider.schools.first.selectedClass, '1');
      expect(provider.hasAnySelection, true);

      // Tapping same class deselects it
      provider.selectClass(schoolId, '1');
      expect(provider.schools.first.selectedClass, null);
      expect(provider.hasAnySelection, false);
    });

    test('selectDivision sets and deselects division', () {
      final schoolId = provider.schools.first.id;
      provider.selectDivision(schoolId, 'A');
      expect(provider.schools.first.selectedDivision, 'A');
      expect(provider.hasAnySelection, true);

      // Tapping same division deselects it
      provider.selectDivision(schoolId, 'A');
      expect(provider.schools.first.selectedDivision, null);
      expect(provider.hasAnySelection, false);
    });

    test('isAllConfigured is true only when all schools have class and division selected', () {
      final id1 = provider.schools[0].id;
      final id2 = provider.schools[1].id;

      provider.selectClass(id1, '1');
      provider.selectDivision(id1, 'A');
      expect(provider.schools[0].isConfigured, true);
      expect(provider.isAllConfigured, false);

      provider.selectClass(id2, '2nd');
      provider.selectDivision(id2, 'B');
      expect(provider.schools[1].isConfigured, true);
      expect(provider.isAllConfigured, true);
    });
  });
}
