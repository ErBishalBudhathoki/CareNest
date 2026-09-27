import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String currentUserEmail;
  final String currentClientEmail;

  final IconData iconData;
  final String label;
  final String text;

  final IconData iconData1;
  final String label1;
  final String text1;

  final IconData iconData2;
  final String label2;
  final String text2;

  final IconData iconData3;
  final String label3;
  final String text3;

  const AppointmentCard({
    super.key,
    required this.currentClientEmail,
    required this.currentUserEmail,
    required this.title,
    required this.iconData,
    required this.label,
    required this.text,
    required this.iconData1,
    required this.label1,
    required this.text1,
    required this.iconData2,
    required this.label2,
    required this.text2,
    required this.iconData3,
    required this.label3,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Container(
      height: screenSize.height * 0.42,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.surface, colorScheme.surfaceContainer],
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Modern header with icon
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: colorScheme.onPrimary,
                      size: isSmallScreen ? 16 : 20,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    title,
                    style:
                        (isSmallScreen
                                ? const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  )
                                : const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ))
                            .copyWith(
                              color: colorScheme.primary,
                              letterSpacing: 0.5,
                            ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            _buildModernCardItem(context, iconData, label, text, isSmallScreen),
            const SizedBox(height: 8.0),
            _buildModernCardItem(
              context,
              iconData1,
              label1,
              text1,
              isSmallScreen,
            ),
            const SizedBox(height: 8.0),
            _buildModernCardItem(
              context,
              iconData2,
              label2,
              text2,
              isSmallScreen,
            ),
            const SizedBox(height: 8.0),
            _buildModernCardItem(
              context,
              iconData3,
              label3,
              text3,
              isSmallScreen,
            ),
            const SizedBox(height: 12.0),
            Consumer(
              builder: (context, ref, _) {
                return Container(
                  height: isSmallScreen ? 48 : 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.07),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientAndAppointmentDetails(
                              userEmail: currentUserEmail,
                              clientEmail: currentClientEmail,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.visibility_outlined,
                              color: colorScheme.onPrimary,
                              size: isSmallScreen ? 18 : 20,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'View Details',
                              style:
                                  (isSmallScreen
                                          ? const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            )
                                          : const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ))
                                      .copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: colorScheme.onPrimary,
                              size: isSmallScreen ? 16 : 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Modern card item with improved design
  Widget _buildModernCardItem(
    BuildContext context,
    IconData icon,
    String label,
    String text,
    bool isSmallScreen,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: isSmallScreen ? 16 : 18,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:
                      (isSmallScreen
                              ? const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )
                              : const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))
                          .copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style:
                      (isSmallScreen
                              ? const TextStyle(fontSize: 14)
                              : const TextStyle(fontSize: 16))
                          .copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
