import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/institution_provider.dart';
import '../widgets/institution_bottom_bar.dart';
import '../widgets/institution_card.dart';
import '../widgets/institution_search_hero.dart';

/// Select Institution Screen
class SelectInstitutionScreen extends StatelessWidget {
  const SelectInstitutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

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
                  // Top Hero Section
                  SliverToBoxAdapter(
                    child: InstitutionSearchHero(
                      instProvider: instProvider,
                      isDesktop: isDesktop,
                    ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Results Meta Counter
                              Text(
                                institutions.isEmpty
                                    ? 'No matching institutions'
                                    : 'Showing ${institutions.length} available institution${institutions.length == 1 ? '' : 's'}',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF777777),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (institutions.isEmpty)
                                const _EmptySearchResults()
                              else
                                // Institution Cards Grid
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final width = constraints.maxWidth;
                                    final int crossAxisCount;
                                    if (width > 1024) {
                                      crossAxisCount = 3;
                                    } else if (width > 640) {
                                      crossAxisCount = 2;
                                    } else {
                                      crossAxisCount = 1;
                                    }

                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            crossAxisSpacing: 24,
                                            mainAxisSpacing: 24,
                                            mainAxisExtent: 200,
                                          ),
                                      itemCount: institutions.length,
                                      itemBuilder: (context, index) {
                                        final inst = institutions[index];
                                        return InstitutionCard(
                                          institution: inst,
                                          onToggleFollow: () => instProvider
                                              .toggleFollow(inst.id),
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

              // Bottom Action Bar
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

/// Empty State
class _EmptySearchResults extends StatelessWidget {
  const _EmptySearchResults();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFDDDDDD),
          width: 1.5,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            'No Institutions Found',
            style: GoogleFonts.montserrat(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111111),
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Text(
              "We couldn't find any school matching your search. Please check the spelling or search by city / pincode.",
              style: GoogleFonts.inter(
                fontSize: 15,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
