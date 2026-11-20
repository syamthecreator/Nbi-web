import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

/// Role Option data model matching source_nbi role dropdown options.
class RoleOption {
  final String label;
  final String emoji;

  const RoleOption({required this.label, required this.emoji});
}

/// Custom Select2-Style Role Dropdown Button matching source_nbi
/// (.custom-role-dropdown, .role-dropdown-btn, .role-dropdown-menu, .role-dropdown-item)
class RoleDropdownButton extends StatefulWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleSelected;

  const RoleDropdownButton({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  static const List<RoleOption> roleOptions = [
    RoleOption(label: 'Student', emoji: '🎓'),
    RoleOption(label: 'Parent', emoji: '👨‍👩‍👧'),
  ];

  @override
  State<RoleDropdownButton> createState() => _RoleDropdownButtonState();
}

class _RoleDropdownButtonState extends State<RoleDropdownButton> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  bool _isButtonHovered = false;

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _closeDropdown();
    setState(() => _isOpen = true);
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (_isOpen) {
      setState(() => _isOpen = false);
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? const Size(120, 36);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Full-screen transparent barrier to dismiss dropdown on outside click
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.expand(),
              ),
            ),

            // Popover Menu matching source_nbi (.role-dropdown-menu)
            Positioned(
              width: 170,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + 8),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0x14000000), // rgba(0, 0, 0, 0.08)
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000), // rgba(0, 0, 0, 0.16)
                          blurRadius: 36,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: RoleDropdownButton.roleOptions.map((opt) {
                        final isSelected = opt.label == widget.selectedRole;
                        return _RoleDropdownItemTile(
                          option: opt,
                          isSelected: isSelected,
                          onTap: () {
                            widget.onRoleSelected(opt.label);
                            _closeDropdown();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentOption = RoleDropdownButton.roleOptions.firstWhere(
      (opt) => opt.label == widget.selectedRole,
      orElse: () => RoleDropdownButton.roleOptions.first,
    );

    final isHighlighted = _isButtonHovered || _isOpen;

    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isButtonHovered = true),
        onExit: (_) => setState(() => _isButtonHovered = false),
        child: GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              // .role-dropdown-btn background & hover background (#FFF0E6 -> #FFE8D6)
              color: isHighlighted
                  ? const Color(0xFFFFE8D6)
                  : const Color(0xFFFFF0E6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHighlighted
                    ? AppColors.primaryOrange
                    : const Color(0x40FF6000), // rgba(255, 96, 0, 0.25)
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHighlighted
                      ? const Color(0x29FF6000) // rgba(255, 96, 0, 0.16)
                      : const Color(0x14FF6000), // rgba(255, 96, 0, 0.08)
                  blurRadius: isHighlighted ? 12 : 8,
                  offset: Offset(0, isHighlighted ? 4 : 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Emoji Icon (.role-icon)
                Text(currentOption.emoji, style: const TextStyle(fontSize: 15)),
                const SizedBox(width: 8),

                // Role Text (.role-text)
                Text(
                  currentOption.label,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.6,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryOrange,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 8),

                // Role Chevron (.role-chevron with 180° rotation on open)
                AnimatedRotation(
                  turns: _isOpen ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 15,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Single item tile inside the Role Dropdown menu matching source_nbi (.role-dropdown-item)
class _RoleDropdownItemTile extends StatefulWidget {
  final RoleOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleDropdownItemTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_RoleDropdownItemTile> createState() => _RoleDropdownItemTileState();
}

class _RoleDropdownItemTileState extends State<_RoleDropdownItemTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final active = _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFFFF0E6) : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Item Emoji (.item-icon)
              Text(widget.option.emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 10),

              // Item Text (.item-text)
              Expanded(
                child: Text(
                  widget.option.label,
                  style: GoogleFonts.montserrat(
                    fontSize: 13.8,
                    fontWeight: FontWeight.w700,
                    color: active
                        ? AppColors.primaryOrange
                        : const Color(0xFF374151),
                  ),
                ),
              ),

              // Item Checkmark (.item-check: visible when active/selected)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: widget.isSelected ? 1.0 : 0.0,
                child: const Icon(
                  Icons.check,
                  size: 16,
                  color: AppColors.primaryOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
