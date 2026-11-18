import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/class_division_provider.dart';
import '../widgets/class_division_bottom_bar.dart';
import '../widgets/class_division_hero.dart';
import '../widgets/school_class_card.dart';

/// Select Class & Division Screen - Production architecture using Provider.
/// Pure Stateless architecture with Provider. Zero setState().
class SelectClassDivisionScreen extends StatelessWidget {
  const SelectClassDivisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 860;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ClassDivisionProvider>(
        builder: (context, cdProvider, _) {
          final schools = cdProvider.schools;
          final hasSelection = cdProvider.hasAnySelection;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Top Hero Section (Background: #FEF8F5)
                  SliverToBoxAdapter(
                    child: ClassDivisionHero(isDesktop: isDesktop),
                  ),

                  // Bottom Cards Section
                  SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1140),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            isDesktop ? 48 : 20,
                            28,
                            isDesktop ? 48 : 20,
                            110,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Class & Division',
                                style: AppTypography.heading2(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Personalize which notifications you receive by configuring enrolled classes.',
                                style: AppTypography.subtitle(
                                  fontSize: 14,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Grid of School Cards
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final isTwoCol = constraints.maxWidth > 780;
                                  if (isTwoCol) {
                                    return Wrap(
                                      spacing: 24,
                                      runSpacing: 24,
                                      children: schools.map((school) {
                                        return SizedBox(
                                          width: (constraints.maxWidth - 24) / 2,
                                          child: SchoolClassCard(
                                            school: school,
                                            onSelectClass: (cls) => cdProvider.selectClass(school.id, cls),
                                            onSelectDivision: (div) => cdProvider.selectDivision(school.id, div),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else {
                                    return Column(
                                      children: schools.map((school) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: SchoolClassCard(
                                            school: school,
                                            onSelectClass: (cls) => cdProvider.selectClass(school.id, cls),
                                            onSelectDivision: (div) => cdProvider.selectDivision(school.id, div),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Sticky Bottom Action Bar
              if (hasSelection)
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClassDivisionBottomBar(),
                ),
            ],
          );
        },
      ),
    );
  }
}
