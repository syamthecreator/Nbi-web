import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? selectedValue;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final bool isRequired;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final Color? asteriskColor;
  final TextStyle? labelStyle;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.isRequired = false,
    this.height = 48.0,
    this.borderRadius = 10.0,
    this.borderColor,
    this.asteriskColor,
    this.labelStyle,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final LayerLink _layerLink = LayerLink();
  final ValueNotifier<bool> _isOpen = ValueNotifier<bool>(false);
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _closeDropdown();
    _isOpen.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen.value) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _closeDropdown();
    _isOpen.value = true;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    if (_isOpen.value) {
      _isOpen.value = false;
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final size = renderBox?.size ?? const Size(300, 48);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Barrier to catch taps outside and close dropdown
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _closeDropdown,
                child: const SizedBox.expand(),
              ),
            ),

            // Dropdown Menu positioned directly below the trigger box
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, widget.height + 6),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 240),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFE4D6),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1FFF5A00),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.options.map((opt) {
                          final isSelected = opt == widget.selectedValue;
                          return _DropdownOptionTile(
                            option: opt,
                            isSelected: isSelected,
                            onTap: () {
                              widget.onChanged(opt);
                              _closeDropdown();
                            },
                          );
                        }).toList(),
                      ),
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
    final effectiveBorderColor = widget.borderColor ?? const Color(0xFFCBD5E1);
    final effectiveAsteriskColor =
        widget.asteriskColor ?? const Color(0xFFEF4444);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style:
                  widget.labelStyle ??
                  GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
            ),
            if (widget.isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: effectiveAsteriskColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: _layerLink,
          child: ValueListenableBuilder<bool>(
            valueListenable: _isOpen,
            builder: (context, isOpen, _) {
              final hasValue = widget.selectedValue?.isNotEmpty == true;

              return InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                onTap: _toggleDropdown,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: widget.height,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(
                      color: isOpen
                          ? AppColors.primaryOrange
                          : effectiveBorderColor,
                      width: 1.5,
                    ),
                    boxShadow: isOpen
                        ? const [
                            BoxShadow(
                              color: Color(0x26FF5A00),
                              spreadRadius: 3,
                              blurRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          hasValue ? widget.selectedValue! : widget.placeholder,
                          style: GoogleFonts.inter(
                            fontSize: 14.5,
                            fontWeight: hasValue
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: hasValue
                                ? const Color(0xFF0F172A)
                                : const Color(0xFF94A3B8),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AnimatedRotation(
                        turns: isOpen ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: isOpen
                              ? AppColors.primaryOrange
                              : const Color(0xFF64748B),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DropdownOptionTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const _DropdownOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHovered = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isHovered,
      builder: (context, hovered, _) {
        final active = isSelected || hovered;

        return MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFFEAE0)
                    : (hovered ? const Color(0xFFFFF3EB) : Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : (hovered ? FontWeight.w600 : FontWeight.w500),
                        color: active
                            ? AppColors.primaryOrange
                            : const Color(0xFF334155),
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.primaryOrange,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
