import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../providers/institution_provider.dart';
import '../widgets/institution_bottom_bar.dart';
import '../widgets/institution_card.dart';
import '../widgets/institution_search_hero.dart';

/// Select Institution Screen - Production architecture using Provider.
/// Pure Stateless architecture with Provider. Zero setState().
class SelectInstitutionScreen extends StatelessWidget {
  const SelectInstitutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Consumer<InstitutionProvider>(
        builder: (context, instProvider, _) {
          final institutions = instProvider.institutions;
          final hasSelection = instProvider.hasSelection;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // Top Hero Section (Background: #FEF8F5)
                  SliverToBoxAdapter(
                    child: InstitutionSearchHero(
                      instProvider: instProvider,
                      isDesktop: isDesktop,
                    ),
                  ),

                  // Bottom Cards Section (Background: White)
                  SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            isDesktop ? 48 : 20,
                            24,
                            isDesktop ? 48 : 20,
                            120,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Counter Label (.search-results-meta)
                              Text(
                                'Showing ${institutions.length} available institution${institutions.length == 1 ? '' : 's'}',
                                style: AppTypography.subtitle(
                                  fontSize: 14.1,
                                  color: const Color(0xFF777777),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (institutions.isEmpty)
                                const _EmptySearchResults()
                              else
                                // Grid of Institutions (3 columns on desktop, 2 on tablet, 1 on mobile)
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final width = constraints.maxWidth;
                                    final int crossAxisCount;
                                    if (width > 960) {
                                      crossAxisCount = 3;
                                    } else if (width > 620) {
                                      crossAxisCount = 2;
                                    } else {
                                      crossAxisCount = 1;
                                    }

                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 24,
                                        mainAxisSpacing: 24,
                                        mainAxisExtent: 184,
                                      ),
                                      itemCount: institutions.length,
                                      itemBuilder: (context, index) {
                                        final inst = institutions[index];
                                        return InstitutionCard(
                                          institution: inst,
                                          onToggleFollow: () => instProvider.toggleFollow(inst.id),
                                        );
                                      },
                                    );
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

              // Bottom Action Bar (Shown when at least 1 institution followed)
              if (hasSelection)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InstitutionBottomBar(instProvider: instProvider),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptySearchResults extends StatelessWidget {
  const _EmptySearchResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            const Text('🔍', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 14),
            Text(
              'No Institutions Found',
              style: AppTypography.heading2(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "We couldn't find any school matching your search. Please check the spelling or search by city / pincode.",
              style: AppTypography.subtitle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
