import 'package:flutter/material.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

/// Bulk Actions View - Tabbed interface for all bulk operations
class BulkActionsView extends StatefulWidget {
  const BulkActionsView({super.key});

  @override
  State<BulkActionsView> createState() => _BulkActionsViewState();
}

class _BulkActionsViewState extends State<BulkActionsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Actions'),
        backgroundColor: BauhausDesign.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'TIMESHEETS'),
            Tab(text: 'INVOICES'),
            Tab(text: 'ASSIGNMENTS'),
            Tab(text: 'MESSAGES'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _BulkTimesheetTab(),
          _BulkInvoiceTab(),
          _BulkAssignmentTab(),
          _BulkMessagingTab(),
        ],
      ),
    );
  }
}

// ============================================================================
// Bulk Timesheet Tab
// ============================================================================

class _BulkTimesheetTab extends StatefulWidget {
  const _BulkTimesheetTab();

  @override
  State<_BulkTimesheetTab> createState() => _BulkTimesheetTabState();
}

class _BulkTimesheetTabState extends State<_BulkTimesheetTab> {
  final Set<String> _selectedTimesheets = {};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Row(
            children: [
              Text(
                '${_selectedTimesheets.length} selected',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _selectedTimesheets.isEmpty
                    ? null
                    : () => _approveTimesheets(),
                icon: const Icon(Icons.check_circle, size: 20),
                label: const Text('APPROVE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.success,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _selectedTimesheets.isEmpty
                    ? null
                    : () => _rejectTimesheets(),
                icon: const Icon(Icons.cancel, size: 20),
                label: const Text('REJECT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.error,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Timesheet List
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildTimesheetList(),
        ),
      ],
    );
  }

  Widget _buildTimesheetList() {
    // Mock data - replace with actual data from repository
    final timesheets = List.generate(
      10,
      (i) => {
        'id': 'ts_$i',
        'workerName': 'Worker ${i + 1}',
        'date': DateTime.now().subtract(Duration(days: i)),
        'hours': 8.0 + i * 0.5,
        'status': 'pending',
      },
    );

    if (timesheets.isEmpty) {
      return const Center(
        child: Text('No pending timesheets'),
      );
    }

    return ListView.builder(
      itemCount: timesheets.length,
      itemBuilder: (context, index) {
        final timesheet = timesheets[index];
        final id = timesheet['id'] as String;
        final isSelected = _selectedTimesheets.contains(id);

        return CheckboxListTile(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedTimesheets.add(id);
              } else {
                _selectedTimesheets.remove(id);
              }
            });
          },
          title: Text(timesheet['workerName'] as String),
          subtitle: Text(
            '${(timesheet['date'] as DateTime).toString().split(' ')[0]} • ${timesheet['hours']} hours',
          ),
          secondary: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: BauhausDesign.warning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              timesheet['status'] as String,
              style: TextStyle(
                color: BauhausDesign.warning,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _approveTimesheets() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Approved ${_selectedTimesheets.length} timesheets'),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedTimesheets.clear();
        _isLoading = false;
      });
    }
  }

  Future<void> _rejectTimesheets() async {
    final reason = await _showRejectDialog();
    if (reason == null) return;

    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Rejected ${_selectedTimesheets.length} timesheets'),
          backgroundColor: BauhausDesign.error,
        ),
      );
      setState(() {
        _selectedTimesheets.clear();
        _isLoading = false;
      });
    }
  }

  Future<String?> _showRejectDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Timesheets'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Reason for rejection',
            hintText: 'Enter reason...',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: BauhausDesign.error,
            ),
            child: const Text('REJECT'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Bulk Invoice Tab
// ============================================================================

class _BulkInvoiceTab extends StatefulWidget {
  const _BulkInvoiceTab();

  @override
  State<_BulkInvoiceTab> createState() => _BulkInvoiceTabState();
}

class _BulkInvoiceTabState extends State<_BulkInvoiceTab> {
  final Set<String> _selectedAppointments = {};
  bool _groupByClient = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '${_selectedAppointments.length} selected',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: _selectedAppointments.isEmpty
                        ? null
                        : () => _previewInvoices(),
                    icon: const Icon(Icons.preview, size: 20),
                    label: const Text('PREVIEW'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.secondary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: _selectedAppointments.isEmpty
                        ? null
                        : () => _generateInvoices(),
                    icon: const Icon(Icons.receipt_long, size: 20),
                    label: const Text('GENERATE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BauhausDesign.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                value: _groupByClient,
                onChanged: (value) {
                  setState(() => _groupByClient = value ?? true);
                },
                title: const Text('Group by client'),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
        // Appointment List
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildAppointmentList(),
        ),
      ],
    );
  }

  Widget _buildAppointmentList() {
    // Mock data
    final appointments = List.generate(
      8,
      (i) => {
        'id': 'apt_$i',
        'clientName': 'Client ${i + 1}',
        'date': DateTime.now().subtract(Duration(days: i)),
        'service': 'Personal Care',
        'amount': 150.0 + i * 10,
      },
    );

    if (appointments.isEmpty) {
      return const Center(
        child: Text('No completed appointments to invoice'),
      );
    }

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final apt = appointments[index];
        final id = apt['id'] as String;
        final isSelected = _selectedAppointments.contains(id);

        return CheckboxListTile(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedAppointments.add(id);
              } else {
                _selectedAppointments.remove(id);
              }
            });
          },
          title: Text(apt['clientName'] as String),
          subtitle: Text(
            '${(apt['date'] as DateTime).toString().split(' ')[0]} • ${apt['service']}',
          ),
        );
      },
    );
  }

  Future<void> _previewInvoices() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      // Show preview dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invoice Preview'),
          content: const Text('Preview functionality coming soon'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _generateInvoices() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Generated ${_groupByClient ? "grouped" : _selectedAppointments.length} invoices',
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedAppointments.clear();
        _isLoading = false;
      });
    }
  }
}

// ============================================================================
// Bulk Assignment Tab
// ============================================================================

class _BulkAssignmentTab extends StatefulWidget {
  const _BulkAssignmentTab();

  @override
  State<_BulkAssignmentTab> createState() => _BulkAssignmentTabState();
}

class _BulkAssignmentTabState extends State<_BulkAssignmentTab> {
  final Map<String, String?> _assignments = {};
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Action Bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Row(
            children: [
              Text(
                '${_assignments.length} shifts to assign',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _assignments.isEmpty
                    ? null
                    : () => _getSuggestions(),
                icon: const Icon(Icons.lightbulb, size: 20),
                label: const Text('SUGGEST'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _assignments.isEmpty
                    ? null
                    : () => _assignShifts(),
                icon: const Icon(Icons.assignment_turned_in, size: 20),
                label: const Text('ASSIGN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BauhausDesign.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // Shift List
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildShiftList(),
        ),
      ],
    );
  }

  Widget _buildShiftList() {
    // Mock data
    final shifts = List.generate(
      6,
      (i) => {
        'id': 'shift_$i',
        'date': DateTime.now().add(Duration(days: i + 1)),
        'time': '09:00 AM',
        'service': 'Personal Care',
        'client': 'Client ${i + 1}',
      },
    );

    if (shifts.isEmpty) {
      return const Center(
        child: Text('No unassigned shifts'),
      );
    }

    return ListView.builder(
      itemCount: shifts.length,
      itemBuilder: (context, index) {
        final shift = shifts[index];
        final id = shift['id'] as String;

        return ListTile(
          title: Text('${shift['service']} - ${shift['client']}'),
          subtitle: Text(
            '${(shift['date'] as DateTime).toString().split(' ')[0]} at ${shift['time']}',
          ),
        );
      },
    );
  }

  Future<void> _getSuggestions() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Suggestions loaded'),
          backgroundColor: BauhausDesign.success,
        ),
      );
    }
  }

  Future<void> _assignShifts() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Assigned ${_assignments.length} shifts'),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _assignments.clear();
        _isLoading = false;
      });
    }
  }
}

// ============================================================================
// Bulk Messaging Tab
// ============================================================================

class _BulkMessagingTab extends StatefulWidget {
  const _BulkMessagingTab();

  @override
  State<_BulkMessagingTab> createState() => _BulkMessagingTabState();
}

class _BulkMessagingTabState extends State<_BulkMessagingTab> {
  final Set<String> _selectedRecipients = {};
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final Set<String> _selectedChannels = {'push'};
  bool _isLoading = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipients
          const Text(
            'Recipients',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildRecipientSelector(),
          const SizedBox(height: 24),

          // Channels
          const Text(
            'Channels',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Push'),
                selected: _selectedChannels.contains('push'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('push');
                    } else {
                      _selectedChannels.remove('push');
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('SMS'),
                selected: _selectedChannels.contains('sms'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('sms');
                    } else {
                      _selectedChannels.remove('sms');
                    }
                  });
                },
              ),
              FilterChip(
                label: const Text('Email'),
                selected: _selectedChannels.contains('email'),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedChannels.add('email');
                    } else {
                      _selectedChannels.remove('email');
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Subject
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Message
          TextField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 24),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _canSend() ? () => _sendMessages() : null,
                  icon: const Icon(Icons.send),
                  label: const Text('SEND NOW'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BauhausDesign.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _canSend() ? () => _scheduleMessages() : null,
                  icon: const Icon(Icons.schedule),
                  label: const Text('SCHEDULE'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSelector() {
    // Mock data
    final recipients = List.generate(
      5,
      (i) => {
        'id': 'user_$i',
        'name': 'User ${i + 1}',
        'role': i % 2 == 0 ? 'Worker' : 'Client',
      },
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: recipients.map((recipient) {
          final id = recipient['id'] as String;
          final isSelected = _selectedRecipients.contains(id);

          return CheckboxListTile(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _selectedRecipients.add(id);
                } else {
                  _selectedRecipients.remove(id);
                }
              });
            },
            title: Text(recipient['name'] as String),
            subtitle: Text(recipient['role'] as String),
          );
        }).toList(),
      ),
    );
  }

  bool _canSend() {
    return _selectedRecipients.isNotEmpty &&
        _messageController.text.isNotEmpty &&
        _selectedChannels.isNotEmpty;
  }

  Future<void> _sendMessages() async {
    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sent to ${_selectedRecipients.length} recipients'),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedRecipients.clear();
        _subjectController.clear();
        _messageController.clear();
        _isLoading = false;
      });
    }
  }

  Future<void> _scheduleMessages() async {
    final scheduledTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (scheduledTime == null) return;

    setState(() => _isLoading = true);
    // TODO: Call repository method
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Scheduled for ${_selectedRecipients.length} recipients',
          ),
          backgroundColor: BauhausDesign.success,
        ),
      );
      setState(() {
        _selectedRecipients.clear();
        _subjectController.clear();
        _messageController.clear();
        _isLoading = false;
      });
    }
  }
}
