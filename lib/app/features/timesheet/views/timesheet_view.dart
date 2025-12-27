import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/values/colors/app_colors.dart';
import 'package:intl/intl.dart';

class TimesheetView extends StatefulWidget {
  final String email;

  const TimesheetView({super.key, required this.email});

  @override
  State<TimesheetView> createState() => _TimesheetViewState();
}

class _TimesheetViewState extends State<TimesheetView> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 14));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.colorBlue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Timesheet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: AppColors.colorBlue),
            onPressed: () {
              // Add menu options
            },
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Date Range Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(startDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('to', style: TextStyle(fontSize: 16)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    DateFormat('MM/dd/yyyy').format(endDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Time Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeColumn('Regular', '8:00'),
                _buildTimeColumn('OT', '--'),
                _buildTimeColumn('Total', '8:00'),
                _buildTimeColumn('Absence', '--'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Requests Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: const Text('Requests'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.colorOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () {
                  // Navigate to requests
                },
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Week Total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Week total 8:00',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Show more details
                  },
                  child: const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daily Time List
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                final date = DateTime.now().subtract(Duration(days: index));
                return _buildDayTimeCard(date);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDayTimeCard(DateTime date) {
    final isToday = date.day == DateTime.now().day;
    final dayFormat = DateFormat('dd');
    final weekdayFormat = DateFormat('EEE');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Date Column
              Container(
                width: 50,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: isToday
                          ? AppColors.colorBlue
                          : AppColors.colorTransparent,
                      width: 4,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    Text(
                      dayFormat.format(date),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isToday
                            ? AppColors.colorBlue
                            : AppColors.colorGrey500,
                      ),
                    ),
                    Text(
                      weekdayFormat.format(date),
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            isToday ? AppColors.colorBlue : AppColors.colorGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Time Details
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeDetail('Regular', isToday ? '8:00' : '--'),
                    _buildTimeDetail('OT', '--'),
                    _buildTimeDetail('Total', isToday ? '8:00' : '--'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeDetail(String label, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            color: time == '--' ? AppColors.colorBlue : AppColors.colorBlack,
          ),
        ),
      ],
    );
  }
}
