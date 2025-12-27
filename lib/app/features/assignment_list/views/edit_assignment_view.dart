import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/features/assignment/views/enhanced_ndis_item_selection_view.dart';
import '../viewmodels/assignment_list_viewmodel.dart';

class EditAssignmentView extends ConsumerStatefulWidget {
  final Map<String, dynamic> assignment;
  final String organizationId;

  const EditAssignmentView({
    super.key,
    required this.assignment,
    required this.organizationId,
  });

  @override
  ConsumerState<EditAssignmentView> createState() => _EditAssignmentViewState();
}

class _EditAssignmentViewState extends ConsumerState<EditAssignmentView> {
  final ApiMethod _apiMethod = ApiMethod();
  late Map<String, dynamic> editedAssignment;
  bool isLoading = false;
  NDISItem? _selectedNdisItem;
  String? _selectedNdisItemNumber;
  final NDISMatcher _ndisMatcher = NDISMatcher();

  late List<dynamic> dateList;
  late List<dynamic> startTimeList;
  late List<dynamic> endTimeList;
  late List<dynamic> breakList;
  late List<bool> highIntensityList;

  // Support for individual NDIS items per schedule entry
  late List<NDISItem?> scheduleNdisItems;
  late List<Map<String, dynamic>?> scheduleCustomPricing;

  @override
  void initState() {
    super.initState();
    editedAssignment = Map<String, dynamic>.from(widget.assignment);
    _selectedNdisItemNumber = editedAssignment['assignedNdisItemNumber'];
    _loadInitialNdisItem();

    final List<dynamic> scheduleArray = editedAssignment['schedule'] ?? [];
    dateList = scheduleArray.map((item) => item['date'] ?? '').toList();
    startTimeList =
        scheduleArray.map((item) => item['startTime'] ?? '').toList();
    endTimeList = scheduleArray.map((item) => item['endTime'] ?? '').toList();
    breakList = scheduleArray.map((item) => item['break'] ?? '').toList();
    highIntensityList = scheduleArray
        .map((item) => item['highIntensity'] as bool? ?? false)
        .toList();

    // Initialize NDIS items and custom pricing for each schedule entry
    scheduleNdisItems = List<NDISItem?>.filled(scheduleArray.length, null);
    scheduleCustomPricing =
        List<Map<String, dynamic>?>.filled(scheduleArray.length, null);
  }

  Future<void> _loadInitialNdisItem() async {
    await _ndisMatcher.loadItems();
    if (_selectedNdisItemNumber != null && mounted) {
      setState(() {
        _selectedNdisItem =
            _ndisMatcher.getItemByNumber(_selectedNdisItemNumber!);
      });
    }

    // Load NDIS items for each schedule entry
    final List<dynamic> scheduleArray = editedAssignment['schedule'] ?? [];
    for (int i = 0; i < scheduleArray.length; i++) {
      final scheduleItem = scheduleArray[i];
      if (scheduleItem['ndisItem'] != null) {
        _loadScheduleNdisItem(i, scheduleItem['ndisItem']);
      }
    }
  }

  Future<void> _loadScheduleNdisItem(
      int index, Map<String, dynamic> ndisItemData) async {
    await _ndisMatcher.loadItems();
    if (mounted) {
      setState(() {
        final itemNumber = ndisItemData['itemNumber'];
        if (itemNumber != null) {
          scheduleNdisItems[index] = _ndisMatcher.getItemByNumber(itemNumber);
        }
      });
    }
  }

  void _selectScheduleNdisItem(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnhancedNdisItemSelectionView(
          organizationId: widget.organizationId,
          clientId: editedAssignment['clientId'],
          highIntensity:
              highIntensityList.isNotEmpty && index < highIntensityList.length
                  ? highIntensityList[index]
                  : false,
          userState: 'NSW', // You can get this from SharedPreferences if needed
        ),
      ),
    );

    if (result != null && result is EnhancedNdisItemSelectionResult) {
      setState(() {
        editedAssignment['scheduleItems'][index]['assignedNdisItem'] =
            result.ndisItem;
      });
    }
  }

  void _selectNdisItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnhancedNdisItemSelectionView(
          organizationId: widget.organizationId,
          clientId: editedAssignment['clientId'],
          highIntensity:
              highIntensityList.isNotEmpty ? highIntensityList.first : false,
          userState: 'NSW', // You can get this from SharedPreferences if needed
        ),
      ),
    );

    if (result != null && result is EnhancedNdisItemSelectionResult) {
      setState(() {
        _selectedNdisItem = result.ndisItem;
      });
    }
  }

  Future<void> _saveChanges() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Prepare the updated schedule array
      List<Map<String, dynamic>> updatedSchedule = [];
      for (int i = 0; i < dateList.length; i++) {
        Map<String, dynamic> scheduleItem = {
          'date': dateList[i],
          'startTime': startTimeList[i],
          'endTime': endTimeList[i],
          'break': breakList[i],
          'highIntensity': highIntensityList[i],
        };

        // Add NDIS item if selected for this schedule entry
        if (scheduleNdisItems[i] != null) {
          scheduleItem['ndisItem'] = scheduleNdisItems[i]!.itemNumber;
        }

        // Add custom pricing if available
        if (scheduleCustomPricing[i] != null) {
          scheduleItem['customPricing'] = scheduleCustomPricing[i];
        }

        updatedSchedule.add(scheduleItem);
      }

      // Update the assignment with new data
      editedAssignment['schedule'] = updatedSchedule;
      editedAssignment['assignedNdisItem'] = _selectedNdisItem;

      // Call API to update assignment using assignClientToUser method
      final response = await _apiMethod.assignClientToUser(
        editedAssignment['userEmail'] ?? '',
        editedAssignment['clientEmail'] ?? '',
        dateList.map((date) => date.toString()).toList(),
        startTimeList.map((time) => time.toString()).toList(),
        endTimeList.map((time) => time.toString()).toList(),
        breakList.map((breakTime) => breakTime.toString()).toList(),
        _selectedNdisItem?.toJson(),
        highIntensityList,
      );

      if (response['success'] == true) {
        // Refresh the assignment list
        ref
            .read(assignmentListViewModelProvider.notifier)
            .loadOrganizationAssignments(widget.organizationId);

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Assignment updated successfully'),
            ),
          );
        }
      } else {
        throw Exception(response['message'] ?? 'Failed to update assignment');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating assignment: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1F2937),
          ),
        ),
        title: Text(
          'Edit Assignment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        actions: [
          if (isLoading)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Assignment Info Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF667EEA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF667EEA).withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: const Color(0xFF667EEA),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Employee',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          editedAssignment['userEmail'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              color: const Color(0xFF667EEA),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Client',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          editedAssignment['clientEmail'] ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // NDIS Item Selection
                  Text(
                    'NDIS Item Assignment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _selectNdisItem,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFD4D4D4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: const Color(0xFF6B7280),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedNdisItem?.itemName ??
                                      'Select NDIS Item',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: _selectedNdisItem != null
                                        ? const Color(0xFF1F2937)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                if (_selectedNdisItem != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    _selectedNdisItem!.itemNumber,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (_selectedNdisItem != null)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedNdisItem = null;
                                  _selectedNdisItemNumber = null;
                                });
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            )
                          else
                            Icon(
                              Icons.chevron_right,
                              color: const Color(0xFF6B7280),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Shifts Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shifts (${dateList.length})',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            dateList.add('');
                            startTimeList.add('');
                            endTimeList.add('');
                            breakList.add('');
                            highIntensityList.add(false);
                            scheduleNdisItems.add(null);
                            scheduleCustomPricing.add(null);
                          });
                        },
                        icon: Icon(
                          Icons.add,
                          size: 16,
                          color: const Color(0xFF667EEA),
                        ),
                        label: Text(
                          'Add Shift',
                          style: TextStyle(
                            color: const Color(0xFF667EEA),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: const Color(0xFF667EEA)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Shifts List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dateList.length,
                    itemBuilder: (context, index) {
                      return _buildEditableShiftCard(
                        index,
                        dateList,
                        startTimeList,
                        endTimeList,
                        breakList,
                        highIntensityList,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFE5E5E5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: const Color(0xFFD4D4D4)),
                      foregroundColor: const Color(0xFF6B7280),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _saveChanges,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableShiftCard(
    int index,
    List<dynamic> dateList,
    List<dynamic> startTimeList,
    List<dynamic> endTimeList,
    List<dynamic> breakList,
    List<bool> highIntensityList,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E5E5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shift ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (dateList.length > index) dateList.removeAt(index);
                    if (startTimeList.length > index) {
                      startTimeList.removeAt(index);
                    }
                    if (endTimeList.length > index) endTimeList.removeAt(index);
                    if (breakList.length > index) breakList.removeAt(index);
                    if (highIntensityList.length > index) {
                      highIntensityList.removeAt(index);
                    }
                    if (scheduleNdisItems.length > index) {
                      scheduleNdisItems.removeAt(index);
                    }
                    if (scheduleCustomPricing.length > index) {
                      scheduleCustomPricing.removeAt(index);
                    }
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date Field
          TextFormField(
            initialValue: dateList.length > index ? dateList[index] : '',
            decoration: InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: const Color(0xFF6B7280),
              ),
            ),
            onChanged: (value) {
              if (dateList.length > index) {
                dateList[index] = value;
              }
            },
          ),
          const SizedBox(height: 12),

          // Time Fields Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue:
                      startTimeList.length > index ? startTimeList[index] : '',
                  decoration: InputDecoration(
                    labelText: 'Start Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  onChanged: (value) {
                    if (startTimeList.length > index) {
                      startTimeList[index] = value;
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  initialValue:
                      endTimeList.length > index ? endTimeList[index] : '',
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  onChanged: (value) {
                    if (endTimeList.length > index) {
                      endTimeList[index] = value;
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Break Field
          TextFormField(
            initialValue: breakList.length > index ? breakList[index] : '',
            decoration: InputDecoration(
              labelText: 'Break Duration',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(
                Icons.pause,
                color: const Color(0xFF6B7280),
              ),
            ),
            onChanged: (value) {
              if (breakList.length > index) {
                breakList[index] = value;
              }
            },
          ),
          const SizedBox(height: 12),

          // High Intensity Toggle
          Row(
            children: [
              Icon(
                Icons.flash_on,
                color: const Color(0xFF6B7280),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'High Intensity Support',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1F2937),
                ),
              ),
              const Spacer(),
              Switch(
                value: highIntensityList.length > index
                    ? highIntensityList[index]
                    : false,
                onChanged: (value) {
                  setState(() {
                    if (highIntensityList.length > index) {
                      highIntensityList[index] = value;
                    }
                  });
                },
                activeThumbColor: const Color(0xFF667EEA),
              ),
            ],
          ),

          // NDIS Item for this shift
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _selectScheduleNdisItem(index),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: const Color(0xFF6B7280),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      scheduleNdisItems.length > index &&
                              scheduleNdisItems[index] != null
                          ? scheduleNdisItems[index]!.itemName
                          : 'Select NDIS Item for this shift',
                      style: TextStyle(
                        fontSize: 14,
                        color: scheduleNdisItems.length > index &&
                                scheduleNdisItems[index] != null
                            ? const Color(0xFF1F2937)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                  if (scheduleNdisItems.length > index &&
                      scheduleNdisItems[index] != null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          scheduleNdisItems[index] = null;
                        });
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 16,
                      ),
                    )
                  else
                    Icon(
                      Icons.chevron_right,
                      color: const Color(0xFF6B7280),
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
