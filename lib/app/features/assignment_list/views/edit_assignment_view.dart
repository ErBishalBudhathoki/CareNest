import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/features/invoice/models/ndis_matcher.dart';
import 'package:carenest/app/features/assignment/views/enhanced_ndis_item_selection_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';

import 'package:carenest/app/core/providers/app_providers.dart' as app_providers;

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
  late final ApiMethod _apiMethod;
  late Map<String, dynamic> editedAssignment;
  bool isLoading = false;
  NDISItem? _selectedNdisItem;
  String? _selectedNdisItemNumber;
  late final NDISMatcher _ndisMatcher;

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
    _apiMethod = ref.read(app_providers.apiMethodProvider);
    _ndisMatcher = NDISMatcher(apiMethod: _apiMethod);
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
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BauhausDesign.surfaceWhite,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            color: BauhausDesign.textDark,
          ),
        ),
        title: Text(
          'Edit Assignment',
          style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                color: BauhausDesign.textDark,
                fontWeight: FontWeight.bold,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: BauhausDesign.neutral, height: 1),
        ),
        actions: [
          if (isLoading)
            Container(
              margin: const EdgeInsets.only(right: BauhausDesign.space4),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(BauhausDesign.primary),
                  ),
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
                  BauhausCard(
                    padding: const EdgeInsets.all(BauhausDesign.space4),
                    backgroundColor: BauhausDesign.primary.withOpacity(0.05),
                    borderColor: BauhausDesign.primary.withOpacity(0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: BauhausDesign.primary,
                              size: 20,
                            ),
                            const SizedBox(width: BauhausDesign.space2),
                            Text(
                              'Employee',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelMedium
                                  ?.copyWith(
                                    color: BauhausDesign.textMuted,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          editedAssignment['userEmail'] ?? 'Unknown',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                        const SizedBox(height: BauhausDesign.space3),
                        Row(
                          children: [
                            Icon(
                              Icons.groups_outlined,
                              color: BauhausDesign.primary,
                              size: 20,
                            ),
                            const SizedBox(width: BauhausDesign.space2),
                            Text(
                              'Client',
                              style: BauhausDesign.getTextTheme(context)
                                  .labelMedium
                                  ?.copyWith(
                                    color: BauhausDesign.textMuted,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: BauhausDesign.space1),
                        Text(
                          editedAssignment['clientEmail'] ?? 'Unknown',
                          style: BauhausDesign.getTextTheme(context)
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: BauhausDesign.textDark,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // NDIS Item Selection
                  Text(
                    'NDIS Item Assignment',
                    style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                  ),
                  const SizedBox(height: BauhausDesign.space3),
                  GestureDetector(
                    onTap: _selectNdisItem,
                    child: BauhausCard(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description_outlined,
                            color: BauhausDesign.textMuted,
                          ),
                          const SizedBox(width: BauhausDesign.space3),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedNdisItem?.itemName ??
                                      'Select NDIS Item',
                                  style: BauhausDesign.getTextTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: _selectedNdisItem != null
                                            ? BauhausDesign.textDark
                                            : BauhausDesign.textMuted,
                                      ),
                                ),
                                if (_selectedNdisItem != null) ...[
                                  const SizedBox(height: BauhausDesign.space1),
                                  Text(
                                    _selectedNdisItem!.itemNumber,
                                    style: BauhausDesign.getTextTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                          color: BauhausDesign.textMuted,
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
                                color: BauhausDesign.error,
                              ),
                            )
                          else
                            const Icon(
                              Icons.chevron_right,
                              color: BauhausDesign.textMuted,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: BauhausDesign.space6),

                  // Shifts Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shifts (${dateList.length})',
                        style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                              color: BauhausDesign.textDark,
                            ),
                      ),
                      BauhausActionButton(
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
                        text: 'Add Shift',
                        icon: Icons.add,
                        variant: BauhausActionVariant.primary,
                        isOutlined: true,
                        isSmall: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: BauhausDesign.space4),

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
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: const BoxDecoration(
              color: BauhausDesign.surfaceWhite,
              border: Border(
                top: BorderSide(
                  color: BauhausDesign.neutral,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: BauhausActionButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    variant: BauhausActionVariant.secondary,
                    isOutlined: true,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space4),
                Expanded(
                  flex: 2,
                  child: BauhausActionButton(
                    text: 'Save Changes',
                    onPressed: isLoading ? null : _saveChanges,
                    isLoading: isLoading,
                    variant: BauhausActionVariant.primary,
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
    return BauhausCard(
      margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
      padding: const EdgeInsets.all(BauhausDesign.space4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shift ${index + 1}',
                style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                      color: BauhausDesign.textDark,
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
                icon: const Icon(Icons.delete),
                color: BauhausDesign.error,
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BauhausDesign.radiusSm),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),

          // Date Field
          TextFormField(
            initialValue: dateList.length > index ? dateList[index] : '',
            decoration: BauhausDesign.defaultInputDecoration.copyWith(
              labelText: 'Date',
              prefixIcon: const Icon(
                Icons.calendar_today,
                color: BauhausDesign.textMuted,
              ),
            ),
            onChanged: (value) {
              if (dateList.length > index) {
                dateList[index] = value;
              }
            },
          ),
          const SizedBox(height: BauhausDesign.space3),

          // Time Fields Row
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue:
                      startTimeList.length > index ? startTimeList[index] : '',
                  decoration: BauhausDesign.defaultInputDecoration.copyWith(
                    labelText: 'Start Time',
                    prefixIcon: const Icon(
                      Icons.access_time,
                      color: BauhausDesign.textMuted,
                    ),
                  ),
                  onChanged: (value) {
                    if (startTimeList.length > index) {
                      startTimeList[index] = value;
                    }
                  },
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: TextFormField(
                  initialValue:
                      endTimeList.length > index ? endTimeList[index] : '',
                  decoration: BauhausDesign.defaultInputDecoration.copyWith(
                    labelText: 'End Time',
                    prefixIcon: const Icon(
                      Icons.access_time,
                      color: BauhausDesign.textMuted,
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
          const SizedBox(height: BauhausDesign.space3),

          // Break Field
          TextFormField(
            initialValue: breakList.length > index ? breakList[index] : '',
            decoration: BauhausDesign.defaultInputDecoration.copyWith(
              labelText: 'Break Duration',
              prefixIcon: const Icon(
                Icons.pause,
                color: BauhausDesign.textMuted,
              ),
            ),
            onChanged: (value) {
              if (breakList.length > index) {
                breakList[index] = value;
              }
            },
          ),
          const SizedBox(height: BauhausDesign.space3),

          // High Intensity Toggle
          Row(
            children: [
              const Icon(
                Icons.flash_on,
                color: BauhausDesign.textMuted,
                size: 20,
              ),
              const SizedBox(width: BauhausDesign.space2),
              Text(
                'High Intensity Support',
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: BauhausDesign.textDark,
                    ),
              ),
              const Spacer(),
              BauhausSwitch(
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
                variant: BauhausSwitchVariant.primary,
              ),
            ],
          ),

          // NDIS Item for this shift
          const SizedBox(height: BauhausDesign.space4),
          GestureDetector(
            onTap: () => _selectScheduleNdisItem(index),
            child: BauhausCard(
              padding: const EdgeInsets.all(BauhausDesign.space3),
              backgroundColor: BauhausDesign.backgroundLight,
              child: Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: BauhausDesign.textMuted,
                    size: 16,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      scheduleNdisItems.length > index &&
                              scheduleNdisItems[index] != null
                          ? scheduleNdisItems[index]!.itemName
                          : 'Select NDIS Item for this shift',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: scheduleNdisItems.length > index &&
                                    scheduleNdisItems[index] != null
                                ? BauhausDesign.textDark
                                : BauhausDesign.textMuted,
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
                      icon: const Icon(
                        Icons.cancel,
                        size: 16,
                      ),
                      color: BauhausDesign.error,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  else
                    const Icon(
                      Icons.chevron_right,
                      color: BauhausDesign.textMuted,
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
