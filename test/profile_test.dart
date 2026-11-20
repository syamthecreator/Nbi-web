import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:nbi_web/features/profile/providers/profile_provider.dart';
import 'package:nbi_web/features/profile/widgets/profile_content.dart';
import 'package:nbi_web/features/profile/widgets/role_dropdown_button.dart';
import 'package:nbi_web/features/profile/widgets/edit_profile_dialog.dart';

void main() {
  group('Profile Screen & Widgets Tests', () {
    testWidgets('ProfileContent displays initial user info and role button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
          child: const MaterialApp(
            home: Scaffold(body: ProfileContent()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check header name and verified pill
      expect(find.text('Rahul Dev Sharma'), findsAtLeastNWidgets(1));
      expect(find.text('Verified Account'), findsOneWidget);
      expect(find.text('Student'), findsOneWidget);
      expect(find.text('User Details'), findsOneWidget);
      expect(find.text('Following Schools, Class & Division'), findsOneWidget);
    });

    testWidgets('RoleDropdownButton toggles dropdown and selects Parent role', (
      WidgetTester tester,
    ) async {
      String selectedRole = 'Student';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: RoleDropdownButton(
                    selectedRole: selectedRole,
                    onRoleSelected: (newRole) {
                      setState(() {
                        selectedRole = newRole;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initially shows Student
      expect(find.text('Student'), findsOneWidget);

      // Tap on the role dropdown button to open overlay
      await tester.tap(find.byType(RoleDropdownButton));
      await tester.pumpAndSettle();

      // Both Student and Parent should now be in the overlay
      expect(find.text('Parent'), findsOneWidget);

      // Tap 'Parent'
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      // Should now be Parent
      expect(selectedRole, 'Parent');
      expect(find.text('Parent'), findsOneWidget);
    });

    testWidgets('EditProfileDialog validation and save flow', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      late ProfileProvider provider;

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) {
            provider = ProfileProvider();
            return provider;
          },
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const EditProfileDialog(),
                      );
                    },
                    child: const Text('Open Dialog'),
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open Dialog
      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile Information'), findsOneWidget);

      // Find the first TextField (Full Name) and clear it to trigger validation
      final nameFieldFinder = find.byType(TextField).at(0);
      await tester.enterText(nameFieldFinder, '');
      await tester.pumpAndSettle();

      // Click Save Changes with empty name
      await tester.ensureVisible(find.text('Save Changes'));
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();

      // Expect validation error
      expect(find.text('Please fill in all profile fields.'), findsOneWidget);

      // Enter new name and save
      await tester.enterText(nameFieldFinder, 'Rahul Sharma');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Save Changes'));
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 4));

      // Dialog should now be closed and profile updated
      expect(find.text('Edit Profile Information'), findsNothing);
      expect(provider.fullName, 'Rahul Sharma');
    });
  });
}
