import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/realtime_portal/models/realtime_portal_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Message Bubble Widget
/// Displays a single message in the chat following Bauhaus Neo-Brutalist guidelines
class MessageBubble extends StatelessWidget {
  final SecureMessage message;
  final bool isMe;

  const MessageBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: BauhausDesign.space4),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            // Square avatar with thick black borders (Neo-Brutalist style)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: BauhausDesign.secondary,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: BauhausDesign.borderThick,
                ),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 16),
            ),
            const SizedBox(width: BauhausDesign.space2),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(BauhausDesign.space4),
              decoration: BoxDecoration(
                // Me: Tangerine Yellow; Partner: Pure White
                color: isMe ? BauhausDesign.accent : Colors.white,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: BauhausDesign.borderThick,
                ),
                boxShadow: const [BauhausDesign.shadowHardSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: BauhausDesign.space1,
                      ),
                      child: Text(
                        message.senderName,
                        style: BauhausDesign.neoHeadingStyle(
                          context,
                          color: BauhausDesign.secondary,
                          fontSize: BauhausDesign.fontSm,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  Text(
                    message.message,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w500,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space2),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Monospace fonts for timestamps
                      Text(
                        _formatTime(message.timestamp),
                        style: BauhausDesign.neoMonoStyle(
                          context,
                          color: BauhausDesign.textMuted,
                          fontSize: BauhausDesign.fontXxs,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: BauhausDesign.space1),
                        Icon(
                          message.read ? Icons.done_all : Icons.done,
                          size: 14,
                          color: message.read
                              ? BauhausDesign.success
                              : BauhausDesign.textMuted,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: BauhausDesign.space2),
            // Square avatar with thick black borders for me
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: BauhausDesign.primary,
                border: Border.all(
                  color: BauhausDesign.neutral,
                  width: BauhausDesign.borderThick,
                ),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return DateFormat('HH:mm').format(time);
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday ${DateFormat('HH:mm').format(time)}';
    } else {
      return DateFormat('MMM d, HH:mm').format(time);
    }
  }
}
