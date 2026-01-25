import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import '../viewmodels/client_appointment_viewmodel.dart';

class ClientAppointmentView extends ConsumerWidget {
  const ClientAppointmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsState = ref.watch(clientAppointmentsProvider);

    return Scaffold(
      backgroundColor: BauhausDesign.background,
      body: appointmentsState.when(
        data: (appointments) {
          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No upcoming appointments', style: BauhausDesign.getTextTheme(context).bodyLarge),
                  const SizedBox(height: BauhausDesign.space4),
                  BauhausButton(
                    text: 'REQUEST APPOINTMENT',
                    onPressed: () => _showRequestDialog(context),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            itemCount: appointments.length,
            separatorBuilder: (_, __) => const SizedBox(height: BauhausDesign.space4),
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return Container(
                padding: const EdgeInsets.all(BauhausDesign.space4),
                decoration: BauhausDesign.cardDecoration,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(BauhausDesign.space3),
                      decoration: BoxDecoration(
                        color: BauhausDesign.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                      ),
                      child: const Icon(Icons.calendar_today, color: BauhausDesign.primary),
                    ),
                    const SizedBox(width: BauhausDesign.space4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(appt.date, style: BauhausDesign.getTextTheme(context).labelLarge),
                          Text('${appt.startTime} - ${appt.endTime}', style: BauhausDesign.getTextTheme(context).displayMedium!.copyWith(fontSize: 20)),
                          if (appt.userEmail != null)
                            Text('With: ${appt.userEmail}', style: BauhausDesign.getTextTheme(context).bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BauhausDesign.primary,
        onPressed: () => _showRequestDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    // Implement request dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Appointment'),
        content: const Text('Please contact support to request appointments (Feature coming soon).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }
}
