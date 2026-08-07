import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
// import 'package:carenest/app/features/analytics/widgets/bauhaus_container.dart'; // Unused

class SharedEmployeePoolView extends ConsumerWidget {
  const SharedEmployeePoolView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: const Text('Shared Employee Pool'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Employees',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BauhausDesign.primaryBlue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    // Add shared employee
                  },
                  child: const Text('Add Employee'),
                ),
              ],
            ),
            const SizedBox(height: BauhausDesign.space4),
            Expanded(
              child: ListView.separated(
                itemCount: 0, // TODO: Fetch from provider
                separatorBuilder: (_, __) =>
                    const SizedBox(height: BauhausDesign.space3),
                itemBuilder: (context, index) {
                  return const SizedBox();
                },
              ),
            ),
            const Center(child: Text('No shared employees yet.')),
          ],
        ),
      ),
    );
  }
}
