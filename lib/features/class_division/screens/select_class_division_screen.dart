import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/class_division_provider.dart';
import '../widgets/class_division_bottom_bar.dart';
import '../widgets/class_division_hero.dart';
import '../widgets/school_class_card.dart';

/// Select Class & Division Screen - Step 2 of 2
class SelectClassDivisionScreen extends StatelessWidget {
  const SelectClassDivisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Consumer<ClassDivisionProvider>(
        builder: (context, cdProvider, _) {
          final schools = cdProvider.schools;
          final hasSelection = cdProvider.hasAnySelection;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Top Hero Section
                  SliverToBoxAdapter(
                    child: ClassDivisionHero(isDesktop: isDesktop),
                  ),

                  // Bottom Cards Section
                  SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1380),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            isDesktop ? 40 : 18,
                            24,
                            isDesktop ? 40 : 18,
                            hasSelection ? 120 : 40,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final isTwoCol = constraints.maxWidth > 768;
                              if (isTwoCol) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (
                                      int i = 0;
                                      i < schools.length;
                                      i++
                                    ) ...[
                                      if (i > 0) const SizedBox(width: 24),
                                      Expanded(
                                        child: SchoolClassCard(
                                          school: schools[i],
                                          onSelectClass: (cls) => cdProvider
                                              .selectClass(schools[i].id, cls),
                                          onSelectDivision: (div) =>
                                              cdProvider.selectDivision(
                                                schools[i].id,
                                                div,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    for (
                                      int i = 0;
                                      i < schools.length;
                                      i++
                                    ) ...[
                                      if (i > 0) const SizedBox(height: 16),
                                      SchoolClassCard(
                                        school: schools[i],
                                        onSelectClass: (cls) => cdProvider
                                            .selectClass(schools[i].id, cls),
                                        onSelectDivision: (div) => cdProvider
                                            .selectDivision(schools[i].id, div),
                                      ),
                                    ],
                                  ],
                                );
                              }
                            },
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
