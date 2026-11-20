import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/feed_provider.dart';

/// Search input pill bar for School Feed exactly matching source_nbi.
class FeedSearchBar extends StatefulWidget {
  final FeedProvider feedProvider;

  const FeedSearchBar({super.key, required this.feedProvider});

  @override
  State<FeedSearchBar> createState() => _FeedSearchBarState();
}

class _FeedSearchBarState extends State<FeedSearchBar> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.feedProvider.searchQuery);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant FeedSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.feedProvider.searchQuery != _controller.text) {
      _controller.text = widget.feedProvider.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = _isFocused ? AppColors.primaryOrange : const Color(0xFF9CA3AF);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: const Cubic(0.16, 1, 0.3, 1),
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _isFocused ? Colors.white : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isFocused ? AppColors.primaryOrange : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: _isFocused
            ? const [
                BoxShadow(
                  color: Color(0x26FF5A00),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          CustomPaint(
            size: const Size(17, 17),
            painter: _SearchIconPainter(color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.feedProvider.setSearchQuery,
              style: GoogleFonts.inter(
                fontSize: 13.8,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF111111),
              ),
              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.transparent,
                hintText: 'Search notices, homework, events...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.8,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          if (widget.feedProvider.searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.feedProvider.clearSearch();
              },
              child: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(left: 6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2E4E8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 12,
                    color: Color(0xFF555555),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchIconPainter extends CustomPainter {
  final Color color;

  _SearchIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Circle cx="11", cy="11", r="8"
    canvas.drawCircle(Offset(11.0 * scale, 11.0 * scale), 8.0 * scale, paint);

    // Line x1="21", y1="21", x2="16.65", y2="16.65"
    canvas.drawLine(
      Offset(16.65 * scale, 16.65 * scale),
      Offset(21.0 * scale, 21.0 * scale),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SearchIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
