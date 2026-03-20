import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/assignment/views/enhanced_ndis_item_selection_view.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/invoice/domain/models/ndis_item.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/app/shared/widgets/bauhaus_switch.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:carenest/app/shared/widgets/flushbar_widget.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/features/shift_assignment/views/shift_assignment_success_view.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class ScheduleAssignment extends ConsumerStatefulWidget {
  final String userEmail;
  final String clientEmail;
  final String? clientId;
  final String? organizationId;
  const ScheduleAssignment(
      {super.key,
      required this.userEmail,
      required this.clientEmail,
      this.clientId,
      this.organizationId});

  @override
  ConsumerState<ScheduleAssignment> createState() => _TimeAndDatePickerState();
}

class _TimeAndDatePickerState extends ConsumerState<ScheduleAssignment> {
  late DateTime _focusedDay = DateTime.now();
  TimeOfDay _focusedTime = TimeOfDay.now();
  TimeOfDay _focusedTime1 = TimeOfDay.now();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'time_date_picker_scaffold_key');
  bool _isVisibleDate = true;
  bool _isVisibleTime = true;
  bool _isVisibleTime1 = true;
  String _selectedBreak = "No";
  List<String> breakOptionItems = ["Yes", "No"];

  late final ApiMethod apiMethod;
  List<String> dateList = [];
  List<String> startTimeList = [];
  List<String> endTimeList = [];
  List<String> breakList = [];
  List<bool> highIntensityList = [];
  List<NDISItem?> ndisItemList = [];
  List<bool> customPricingSetList = [];
  List<double?> customPriceList = [];
  List<String?> pricingTypeList = [];
  bool _isSubmitting = false;
  bool _isHighIntensity = false;
  String? _resolvedOrganizationId;
  String? _resolvedClientId;
  String _resolvedUserState = 'NSW';

  // NDIS Item Selection
  NDISItem? _selectedNdisItem;
  String? _selectedNdisItemNumber;
  final TextEditingController _searchController = TextEditingController();

  // Custom pricing variables (for global selection)
  bool _isCustomPriceSet = false;
  double? _customPrice;
  String? _pricingType;

  String? get _effectiveOrganizationId {
    final candidate = (widget.organizationId?.trim().isNotEmpty ?? false)
        ? widget.organizationId
        : _resolvedOrganizationId;
    return (candidate != null && candidate.trim().isNotEmpty)
        ? candidate.trim()
        : null;
  }

  String? get _effectiveClientId {
    final widgetClientId = widget.clientId?.trim();
    if (widgetClientId != null && widgetClientId.isNotEmpty) {
      return widgetClientId;
    }
    final resolvedClientId = _resolvedClientId?.trim();
    if (resolvedClientId != null && resolvedClientId.isNotEmpty) {
      return resolvedClientId;
    }
    final emailFallback = widget.clientEmail.trim();
    return emailFallback.isNotEmpty ? emailFallback : null;
  }

  // Error states
  String? _ndisError;
  String? _scheduleError;
  List<String> _validationErrors = [];

  BoxDecoration _panelDecoration({
    Color color = BauhausDesign.surfaceLight,
    Color borderColor = BauhausDesign.neutral,
    double borderWidth = 2,
  }) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: const [BauhausDesign.shadowHardXs],
    );
  }

  Widget _squareCard({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(BauhausDesign.space4),
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: _panelDecoration(),
      child: child,
    );
  }

  Widget _squareActionButton({
    required String text,
    required IconData icon,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isOutlined = false,
    bool isFullWidth = false,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
  }) {
    final Color bg = backgroundColor ??
        (isOutlined ? BauhausDesign.surfaceLight : BauhausDesign.primary);
    final Color fg = textColor ??
        (isOutlined ? BauhausDesign.primary : BauhausDesign.surfaceLight);
    final Color bd = borderColor ?? (isOutlined ? fg : BauhausDesign.neutral);

    return Container(
      width: isFullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: bd, width: 2),
        boxShadow: (isOutlined || onPressed == null)
            ? const []
            : const [BauhausDesign.shadowHardSm],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space4,
              vertical: BauhausDesign.space3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(fg),
                    ),
                  )
                else
                  Icon(icon, size: 18, color: fg),
                const SizedBox(width: BauhausDesign.space2),
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: BauhausDesign.getTextTheme(context)
                        .labelLarge
                        ?.copyWith(
                          color: fg,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _returnToAdminDashboard() async {
    final sharedPrefs = SharedPreferencesUtils();
    await sharedPrefs.init();

    final userEmail =
        await sharedPrefs.getUserEmailFromSharedPreferences() ?? '';
    final role = sharedPrefs.getRole() ?? UserRole.admin;
    final organizationId = sharedPrefs.getOrganizationId() ?? '';
    final organizationName = sharedPrefs.getString('organizationName') ?? '';
    final organizationCode = sharedPrefs.getOrganizationCode() ?? '';

    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.bottomNavBar,
      (route) => false,
      arguments: {
        'email': userEmail,
        'role': role,
        'organizationId': organizationId,
        'organizationName': organizationName,
        'organizationCode': organizationCode,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    apiMethod = ref.read(app_providers.apiMethodProvider);
    _resolvePricingContext();
  }

  Future<void> _resolvePricingContext() async {
    try {
      final prefs = SharedPreferencesUtils();
      await prefs.init();

      final organizationId =
          widget.organizationId ?? prefs.getOrganizationId() ?? '';
      final userState = prefs.getString('userState') ?? 'NSW';
      String? clientId = widget.clientId;

      if (clientId == null || clientId.trim().isEmpty) {
        final clients = await apiMethod.fetchClientData();
        for (final client in clients) {
          if (client.clientEmail.toLowerCase() ==
              widget.clientEmail.toLowerCase()) {
            clientId = client.id;
            if (client.clientState != null &&
                client.clientState!.trim().isNotEmpty) {
              _resolvedUserState = client.clientState!.trim().toUpperCase();
            }
            break;
          }
        }
      }

      if ((clientId == null || clientId.trim().isEmpty) &&
          organizationId.trim().isNotEmpty) {
        final organizationClients =
            await apiMethod.getClientsByOrganizationId(organizationId);
        for (final client in organizationClients) {
          final email = (client['clientEmail'] ?? '').toString().trim();
          if (email.toLowerCase() == widget.clientEmail.toLowerCase()) {
            final rawId = client['_id'] ?? client['id'] ?? client['clientId'];
            clientId = rawId?.toString();
            final clientState = client['clientState']?.toString().trim();
            if (clientState != null && clientState.isNotEmpty) {
              _resolvedUserState = clientState.toUpperCase();
            }
            break;
          }
        }
      }

      if (clientId == null || clientId.trim().isEmpty) {
        clientId = widget.clientEmail.trim();
      }

      if (!mounted) return;
      setState(() {
        _resolvedOrganizationId =
            organizationId.trim().isEmpty ? null : organizationId;
        _resolvedClientId =
            (clientId != null && clientId.trim().isNotEmpty) ? clientId : null;
        if (_resolvedUserState == 'NSW') {
          _resolvedUserState =
              userState.trim().isEmpty ? 'NSW' : userState.trim().toUpperCase();
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _resolvedOrganizationId =
            _resolvedOrganizationId ?? widget.organizationId;
        _resolvedClientId = _resolvedClientId ?? widget.clientId;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addCardWidget() {
    setState(() {
      _scheduleError = null;
      _validationErrors.clear();
    });

    String? validationError = _validateCurrentSchedule();
    if (validationError != null) {
      setState(() {
        _scheduleError = validationError;
      });
      return;
    }

    setState(() {
      dateList.add(DateFormat("yyyy-MM-dd").format(_focusedDay));
      startTimeList.add(_focusedTime.format(context));
      endTimeList.add(_focusedTime1.format(context));
      breakList.add(_selectedBreak);
      ndisItemList.add(_selectedNdisItem);
      highIntensityList.add(_isHighIntensity);
      customPricingSetList.add(_isCustomPriceSet);
      customPriceList.add(_customPrice);
      pricingTypeList.add(_pricingType);
      _scheduleError = null;
      _validationErrors.clear();
    });
  }

  void _clearValidationErrors() {
    if (_scheduleError != null || _validationErrors.isNotEmpty) {
      setState(() {
        _scheduleError = null;
        _validationErrors.clear();
      });
    }
  }

  String? _validateCurrentSchedule() {
    DateTime selectedDate =
        DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day);
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (selectedDate.isBefore(today)) {
      return AppLocalizations.of(context)!.cannotSchedulePast;
    }

    DateTime startDateTime = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
      _focusedTime.hour,
      _focusedTime.minute,
    );

    DateTime endDateTime = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      _focusedDay.day,
      _focusedTime1.hour,
      _focusedTime1.minute,
    );

    if (startDateTime.isAfter(endDateTime) ||
        startDateTime.isAtSameMomentAs(endDateTime)) {
      return AppLocalizations.of(context)!.startBeforeEnd;
    }

    Duration duration = endDateTime.difference(startDateTime);
    if (duration.inMinutes < 30) {
      return AppLocalizations.of(context)!.minimumDuration30;
    }

    String formattedDate = DateFormat("yyyy-MM-dd").format(_focusedDay);
    for (int i = 0; i < dateList.length; i++) {
      if (dateList[i] == formattedDate) {
        if (_hasTimeConflict(i, startDateTime, endDateTime)) {
          return AppLocalizations.of(context)!.timeConflictExisting;
        }
      }
    }

    return null;
  }

  List<String> _validateAllSchedules() {
    List<String> errors = [];
    if (dateList.isEmpty) {
      errors.add(AppLocalizations.of(context)!.addAtLeastOne);
      return errors;
    }
    if (_selectedNdisItem == null) {
      errors.add(AppLocalizations.of(context)!.selectNdisItem);
    }
    if (!_areListsConsistent()) {
      errors.add(AppLocalizations.of(context)!.scheduleDataInconsistent);
      return errors;
    }
    for (int i = 0; i < dateList.length; i++) {
      String? scheduleError = _validateScheduleAtIndex(i);
      if (scheduleError != null) {
        errors.add(AppLocalizations.of(context)!
            .scheduleError('${i + 1}', scheduleError));
      }
    }
    for (int i = 0; i < dateList.length; i++) {
      for (int j = i + 1; j < dateList.length; j++) {
        if (dateList[i] == dateList[j]) {
          if (_hasTimeConflictBetweenSchedules(i, j)) {
            errors.add(AppLocalizations.of(context)!.timeConflictBetween(
              '${i + 1}',
              '${j + 1}',
              dateList[i],
            ));
          }
        }
      }
    }
    return errors;
  }

  bool _areListsConsistent() {
    int expectedLength = dateList.length;
    return startTimeList.length == expectedLength &&
        endTimeList.length == expectedLength &&
        breakList.length == expectedLength &&
        ndisItemList.length == expectedLength &&
        highIntensityList.length == expectedLength &&
        customPricingSetList.length == expectedLength &&
        customPriceList.length == expectedLength &&
        pricingTypeList.length == expectedLength;
  }

  String? _validateScheduleAtIndex(int index) {
    try {
      DateTime scheduleDate = DateTime.parse(dateList[index]);
      DateTime today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      if (scheduleDate.isBefore(today)) {
        return AppLocalizations.of(context)!.dateCannotBePast;
      }

      String? timeValidation = _validateTimeLogic(index);
      if (timeValidation != null) {
        return timeValidation;
      }

      if (ndisItemList[index] == null) {
        return AppLocalizations.of(context)!.ndisItemRequired;
      }

      return null;
    } catch (e) {
      return AppLocalizations.of(context)!.invalidScheduleData;
    }
  }

  String? _validateTimeLogic(int index) {
    try {
      String startTimeStr = startTimeList[index];
      String endTimeStr = endTimeList[index];
      DateTime scheduleDate = DateTime.parse(dateList[index]);

      DateTime? startDateTime = _parseTimeString(startTimeStr, scheduleDate);
      DateTime? endDateTime = _parseTimeString(endTimeStr, scheduleDate);

      if (startDateTime == null || endDateTime == null) {
        return AppLocalizations.of(context)!.invalidTimeFormat;
      }

      if (startDateTime.isAfter(endDateTime) ||
          startDateTime.isAtSameMomentAs(endDateTime)) {
        return AppLocalizations.of(context)!.startBeforeEnd;
      }

      Duration duration = endDateTime.difference(startDateTime);
      if (duration.inMinutes < 30) {
        return AppLocalizations.of(context)!.minimumDuration;
      }

      return null;
    } catch (e) {
      return AppLocalizations.of(context)!.timeValidationError;
    }
  }

  DateTime? _parseTimeString(String timeStr, DateTime date) {
    try {
      List<String> timeParts = timeStr.split(':');
      if (timeParts.length != 2) return null;

      int hour = int.parse(timeParts[0]);
      String minuteAndPeriod = timeParts[1];

      int minute;
      bool isPM = false;

      if (minuteAndPeriod.toLowerCase().contains('pm')) {
        isPM = true;
        minute = int.parse(minuteAndPeriod.split(' ')[0]);
      } else if (minuteAndPeriod.toLowerCase().contains('am')) {
        minute = int.parse(minuteAndPeriod.split(' ')[0]);
      } else {
        minute = int.parse(minuteAndPeriod);
      }

      if (isPM && hour != 12) {
        hour += 12;
      } else if (!isPM && hour == 12) {
        hour = 0;
      }

      return DateTime(date.year, date.month, date.day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  bool _hasTimeConflict(int existingIndex, DateTime newStart, DateTime newEnd) {
    try {
      String startTimeStr = startTimeList[existingIndex];
      String endTimeStr = endTimeList[existingIndex];

      List<String> startTimeParts = startTimeStr.split(':');
      List<String> endTimeParts = endTimeStr.split(':');

      int existingStartHour = int.parse(startTimeParts[0]);
      final startMinuteParts = startTimeParts[1].split(' ');
      int existingStartMinute = int.parse(startMinuteParts.isNotEmpty
          ? startMinuteParts[0]
          : startTimeParts[1]);

      int existingEndHour = int.parse(endTimeParts[0]);
      final endMinuteParts = endTimeParts[1].split(' ');
      int existingEndMinute = int.parse(
          endMinuteParts.isNotEmpty ? endMinuteParts[0] : endTimeParts[1]);

      if (startTimeParts[1].toLowerCase().contains('pm') &&
          existingStartHour != 12) {
        existingStartHour += 12;
      } else if (startTimeParts[1].toLowerCase().contains('am') &&
          existingStartHour == 12) {
        existingStartHour = 0;
      }

      if (endTimeParts[1].toLowerCase().contains('pm') &&
          existingEndHour != 12) {
        existingEndHour += 12;
      } else if (endTimeParts[1].toLowerCase().contains('am') &&
          existingEndHour == 12) {
        existingEndHour = 0;
      }

      DateTime existingStart = DateTime(
        newStart.year,
        newStart.month,
        newStart.day,
        existingStartHour,
        existingStartMinute,
      );

      DateTime existingEnd = DateTime(
        newEnd.year,
        newEnd.month,
        newEnd.day,
        existingEndHour,
        existingEndMinute,
      );

      return (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart));
    } catch (e) {
      return false;
    }
  }

  bool _hasTimeConflictBetweenSchedules(int index1, int index2) {
    try {
      DateTime? start1 = _parseTimeString(
          startTimeList[index1], DateTime.parse(dateList[index1]));
      DateTime? end1 = _parseTimeString(
          endTimeList[index1], DateTime.parse(dateList[index1]));
      DateTime? start2 = _parseTimeString(
          startTimeList[index2], DateTime.parse(dateList[index2]));
      DateTime? end2 = _parseTimeString(
          endTimeList[index2], DateTime.parse(dateList[index2]));

      if (start1 == null || end1 == null || start2 == null || end2 == null) {
        return false;
      }

      return (start1.isBefore(end2) && start2.isBefore(end1));
    } catch (e) {
      return false;
    }
  }

  Widget _card(int index) {
    return _squareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: BoxDecoration(
                  color: BauhausDesign.secondary.withOpacity(0.1),
                  border: Border.all(color: BauhausDesign.neutral, width: 1),
                ),
                child: Icon(
                  Icons.event_available_outlined,
                  color: BauhausDesign.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.scheduleDetails,
                    style: BauhausDesign.getTextTheme(context)
                        .titleMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.addedOn(
                        DateFormat('MMM d, yyyy').format(DateTime.now())),
                    style: BauhausDesign.getTextTheme(context)
                        .labelSmall
                        ?.copyWith(
                          color: BauhausDesign.textMuted,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  setState(() {
                    if (dateList.length > index) dateList.removeAt(index);
                    if (startTimeList.length > index) {
                      startTimeList.removeAt(index);
                    }
                    if (endTimeList.length > index) endTimeList.removeAt(index);
                    if (breakList.length > index) breakList.removeAt(index);
                    if (ndisItemList.length > index)
                      ndisItemList.removeAt(index);
                    if (highIntensityList.length > index) {
                      highIntensityList.removeAt(index);
                    }
                    if (customPricingSetList.length > index) {
                      customPricingSetList.removeAt(index);
                    }
                    if (customPriceList.length > index) {
                      customPriceList.removeAt(index);
                    }
                    if (pricingTypeList.length > index) {
                      pricingTypeList.removeAt(index);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(BauhausDesign.space2),
                  decoration: BoxDecoration(
                    border: Border.all(color: BauhausDesign.error, width: 1.5),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: BauhausDesign.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildScheduleDetailRow(
            icon: Icons.calendar_today_outlined,
            label: AppLocalizations.of(context)!.appointmentDateLabel,
            value: DateFormat('EEEE, MMMM d, y')
                .format(DateFormat('yyyy-MM-dd').parse(dateList[index])),
            iconColor: BauhausDesign.primary,
            backgroundColor: BauhausDesign.primary.withOpacity(0.1),
          ),
          const SizedBox(height: BauhausDesign.space3),
          Row(
            children: [
              Expanded(
                child: _buildScheduleDetailRow(
                  icon: Icons.access_time_outlined,
                  label: AppLocalizations.of(context)!.startLabel,
                  value: startTimeList[index],
                ),
              ),
              const SizedBox(width: BauhausDesign.space3),
              Expanded(
                child: _buildScheduleDetailRow(
                  icon: Icons.access_time_filled_outlined,
                  label: AppLocalizations.of(context)!.endLabel,
                  value: endTimeList[index],
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildScheduleDetailRow(
            icon: Icons.coffee_outlined,
            label: AppLocalizations.of(context)!.breakDurationLabel,
            value: breakList[index],
          ),
          const SizedBox(height: BauhausDesign.space3),
          _buildScheduleDetailRow(
            icon: Icons.medical_services_outlined,
            label: AppLocalizations.of(context)!.ndisServiceItemLabel,
            value: ndisItemList[index] != null
                ? '${ndisItemList[index]!.itemNumber} - ${ndisItemList[index]!.itemName}'
                : AppLocalizations.of(context)!.selectNdisServiceItem,
            iconColor: _ndisError != null ? BauhausDesign.error : null,
            backgroundColor: _ndisError != null
                ? BauhausDesign.error.withOpacity(0.1)
                : null,
          ),
          if (_ndisError != null)
            Padding(
              padding: const EdgeInsets.only(
                  top: BauhausDesign.space2, left: BauhausDesign.space4),
              child: Text(
                _ndisError!,
                style: BauhausDesign.getTextTheme(context)
                    .labelSmall
                    ?.copyWith(color: BauhausDesign.error),
              ),
            ),
          const SizedBox(height: BauhausDesign.space3),
          SizedBox(
            width: double.infinity,
            child: _squareActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnhancedNdisItemSelectionView(
                      organizationId: _effectiveOrganizationId,
                      clientId: _effectiveClientId,
                      highIntensity: highIntensityList[index],
                      userState: _resolvedUserState,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    ndisItemList[index] = result.ndisItem;
                    if (result.isCustomPriceSet && result.customPrice != null) {
                      customPricingSetList[index] = true;
                      customPriceList[index] = result.customPrice;
                      pricingTypeList[index] = result.pricingType;
                    } else {
                      customPricingSetList[index] = false;
                      customPriceList[index] = null;
                      pricingTypeList[index] = null;
                    }
                  });
                }
              },
              text: ndisItemList[index] != null
                  ? AppLocalizations.of(context)!.changeNdisItem
                  : AppLocalizations.of(context)!.selectNdisItemTitleNormal,
              icon: ndisItemList[index] != null ? Icons.edit : Icons.add,
              isOutlined: true,
              isFullWidth: true,
              textColor: BauhausDesign.primary,
              borderColor: BauhausDesign.primary,
            ),
          ),
          if (customPricingSetList.length > index &&
              customPricingSetList[index] &&
              customPriceList[index] != null)
            Padding(
              padding: const EdgeInsets.only(top: BauhausDesign.space2),
              child: Container(
                padding: const EdgeInsets.all(BauhausDesign.space2),
                decoration: _panelDecoration(
                  color: BauhausDesign.success.withOpacity(0.08),
                  borderColor: BauhausDesign.success,
                  borderWidth: 1.5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: BauhausDesign.success,
                      size: 16,
                    ),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      AppLocalizations.of(context)!.customPrice(
                          '\$${customPriceList[index]!.toStringAsFixed(2)}'),
                      style: BauhausDesign.getTextTheme(context)
                          .labelMedium
                          ?.copyWith(
                            color: BauhausDesign.success,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: BauhausDesign.space3),
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: _panelDecoration(),
            child: Row(
              children: [
                Icon(
                  Icons.fitness_center_outlined,
                  color: BauhausDesign.textDark, // Changed to textDark
                ),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  AppLocalizations.of(context)!.highIntensityCare,
                  style: BauhausDesign.getTextTheme(context)
                      .bodyMedium
                      ?.copyWith(
                        color: BauhausDesign.textDark, // Changed to textDark
                      ),
                ),
                const Spacer(),
                BauhausSwitch(
                  value: highIntensityList[index],
                  variant: BauhausSwitchVariant.primary,
                  onChanged: (value) {
                    setState(() {
                      highIntensityList[index] = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildScheduleDetailRow(
      {required IconData icon,
      required String label,
      required String value,
      Color? iconColor,
      Color? backgroundColor}) {
    final effectiveIconColor = iconColor ?? BauhausDesign.primary;
    final effectiveBackgroundColor =
        backgroundColor ?? BauhausDesign.primary.withOpacity(0.1);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: BauhausDesign.space3, horizontal: BauhausDesign.space4),
      decoration: _panelDecoration(
        color: BauhausDesign.surfaceLight,
        borderColor: BauhausDesign.neutral,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Icon(
              icon,
              color: effectiveIconColor,
              size: 18,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
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

  void _showDatePicker() {
    _clearValidationErrors();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
      locale: const Locale('en', 'AU'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.surfaceWhite,
              surface: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(value);
        setState(() {
          _isVisibleDate = false;
          _focusedDay = dateFormat.parse(formattedDate);
        });
      }
    });
  }

  void _showTimePicker(bool isStartTime) {
    _clearValidationErrors();
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: BauhausDesign.primary,
              onPrimary: BauhausDesign.surfaceWhite,
              surface: BauhausDesign.surfaceWhite,
              onSurface: BauhausDesign.textDark,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          if (isStartTime) {
            _isVisibleTime = false;
            _focusedTime = value;
          } else {
            _isVisibleTime1 = false;
            _focusedTime1 = value;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _returnToAdminDashboard();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: BauhausDesign.backgroundLight,
        appBar: AppBar(
          backgroundColor: BauhausDesign.surfaceWhite,
          foregroundColor: BauhausDesign.textDark,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.scheduleAssignmentTitle,
            style: BauhausDesign.getTextTheme(context).titleLarge?.copyWith(
                  color: BauhausDesign.textDark,
                ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: BauhausDesign.textDark),
            onPressed: _returnToAdminDashboard,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: BauhausDesign.neutral),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusStrip(),
              const SizedBox(height: BauhausDesign.space6),
              _buildHeaderSection(),
              const SizedBox(height: BauhausDesign.space6),
              _buildDateTimeSection(),
              const SizedBox(height: BauhausDesign.space6),
              _buildScheduleList(),
              const SizedBox(height: BauhausDesign.space6),
              _buildActionButtons(),
              const SizedBox(height: BauhausDesign.space4),
            ],
          ),
        ).animate().fadeIn().slideY(begin: 0.1, end: 0),
      ),
    );
  }

  Widget _buildStatusStrip() {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: _panelDecoration(),
      child: Row(
        children: [
          const Icon(Icons.event_note, color: BauhausDesign.secondary),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.addedSchedules,
              style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space2,
              vertical: BauhausDesign.space1,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.warning,
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Text(
              '${dateList.length}',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textDark,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return _squareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: AppLocalizations.of(context)!.assignmentDetails,
            subtitle: AppLocalizations.of(context)!.assignmentDetailsSubtitle,
            action: Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.primary.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: Icon(
                Icons.assignment_ind_rounded,
                color: BauhausDesign.primary,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildEnhancedInfoRow(AppLocalizations.of(context)!.employeeLabel,
              widget.userEmail, Icons.person_rounded),
          const SizedBox(height: BauhausDesign.space3),
          _buildEnhancedInfoRow(AppLocalizations.of(context)!.clientLabel,
              widget.clientEmail, Icons.business_rounded),
        ],
      ),
    );
  }

  Widget _buildEnhancedInfoRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: _panelDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space2),
            decoration: BoxDecoration(
              color: BauhausDesign.primary.withOpacity(0.1),
              border: Border.all(color: BauhausDesign.neutral, width: 1),
            ),
            child: Icon(
              icon,
              color: BauhausDesign.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:
                      BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                            color: BauhausDesign.textMuted,
                          ),
                ),
                Text(
                  value,
                  style:
                      BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: BauhausDesign.textDark,
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeSection() {
    return _squareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BauhausSectionHeader(
            title: AppLocalizations.of(context)!.scheduleConfiguration,
            subtitle:
                AppLocalizations.of(context)!.scheduleConfigurationSubtitle,
            action: Container(
              padding: const EdgeInsets.all(BauhausDesign.space2),
              decoration: BoxDecoration(
                color: BauhausDesign.secondary.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.neutral, width: 1),
              ),
              child: Icon(
                Icons.schedule_rounded,
                color: BauhausDesign.secondary,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildDateSelector(),
          const SizedBox(height: BauhausDesign.space4),
          Row(
            children: [
              Expanded(
                child: _buildTimeSelector(
                  AppLocalizations.of(context)!.startTimeLabel,
                  _focusedTime,
                  _isVisibleTime,
                  () => _showTimePicker(true),
                ),
              ),
              const SizedBox(width: BauhausDesign.space4),
              Expanded(
                child: _buildTimeSelector(
                  AppLocalizations.of(context)!.endTimeLabel,
                  _focusedTime1,
                  _isVisibleTime1,
                  () => _showTimePicker(false),
                ),
              ),
            ],
          ),
          const SizedBox(height: BauhausDesign.space4),
          _buildBreakSelector(),
          const SizedBox(height: BauhausDesign.space4),
          SizedBox(
            width: double.infinity,
            child: _squareActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnhancedNdisItemSelectionView(
                      organizationId: _effectiveOrganizationId,
                      clientId: _effectiveClientId,
                      highIntensity: _isHighIntensity,
                      userState: _resolvedUserState,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _clearValidationErrors();
                    _selectedNdisItem = result.ndisItem;
                    _selectedNdisItemNumber = result.ndisItem.itemNumber;
                    _searchController.text =
                        '${result.ndisItem.itemNumber} - ${result.ndisItem.itemName}';

                    if (result.isCustomPriceSet && result.customPrice != null) {
                      _isCustomPriceSet = true;
                      _customPrice = result.customPrice;
                      _pricingType = result.pricingType;
                    } else {
                      _isCustomPriceSet = false;
                      _customPrice = null;
                      _pricingType = null;
                    }
                  });
                }
              },
              text: _selectedNdisItem != null
                  ? '${_selectedNdisItem!.itemNumber} - ${_selectedNdisItem!.itemName}'
                  : AppLocalizations.of(context)!.selectNdisItemTitleNormal,
              icon: Icons.search,
              isFullWidth: true,
              backgroundColor: BauhausDesign.primary,
              textColor: BauhausDesign.surfaceLight,
            ),
          ),
          if (_selectedNdisItem != null) ...[
            const SizedBox(height: BauhausDesign.space3),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: BauhausDesign.space3,
                vertical: BauhausDesign.space2,
              ),
              decoration: BoxDecoration(
                color: BauhausDesign.primary.withOpacity(0.1),
                border: Border.all(color: BauhausDesign.primary, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: BauhausDesign.primary,
                  ),
                  const SizedBox(width: BauhausDesign.space2),
                  Expanded(
                    child: Text(
                      '${_selectedNdisItem!.itemName} ${_selectedNdisItem!.itemNumber}',
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedNdisItem = null;
                        _selectedNdisItemNumber = null;
                        _searchController.clear();
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: BauhausDesign.textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.all(BauhausDesign.space3),
        decoration: _panelDecoration(),
        child: Row(
          children: [
            Icon(Icons.calendar_today_rounded, color: BauhausDesign.primary),
            const SizedBox(width: BauhausDesign.space3),
            Expanded(
              child: Text(
                _isVisibleDate
                    ? AppLocalizations.of(context)!.selectDate
                    : DateFormat('MMM dd, yyyy').format(_focusedDay),
                style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                      color: BauhausDesign.textDark,
                    ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: BauhausDesign.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector(
      String label, TimeOfDay time, bool isVisible, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: BauhausDesign.getTextTheme(context)
              .labelSmall
              ?.copyWith(color: BauhausDesign.textMuted),
        ),
        const SizedBox(height: BauhausDesign.space2),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: _panelDecoration(),
            child: Row(
              children: [
                Icon(Icons.access_time_rounded, color: BauhausDesign.secondary),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    isVisible
                        ? AppLocalizations.of(context)!.selectTime
                        : time.format(context),
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakSelector() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.breakAllowed,
                style: BauhausDesign.getTextTheme(context)
                    .labelSmall
                    ?.copyWith(color: BauhausDesign.textMuted),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3),
                decoration: _panelDecoration(),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBreak,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down,
                        color: BauhausDesign.textDark),
                    dropdownColor: BauhausDesign.surfaceWhite,
                    style: BauhausDesign.getTextTheme(context)
                        .bodyMedium
                        ?.copyWith(
                          color: BauhausDesign.textDark,
                        ),
                    items: breakOptionItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: BauhausDesign.getTextTheme(context)
                                .bodyMedium
                                ?.copyWith(
                                  color: BauhausDesign.textDark,
                                )),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedBreak = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: BauhausDesign.space4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.highIntensity,
                style: BauhausDesign.getTextTheme(context)
                    .labelSmall
                    ?.copyWith(color: BauhausDesign.textMuted),
              ),
              const SizedBox(height: BauhausDesign.space2),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space3),
                decoration: _panelDecoration(),
                child: Row(
                  children: [
                    Icon(Icons.fitness_center_outlined,
                        color: BauhausDesign.textMuted),
                    const Spacer(),
                    BauhausSwitch(
                      value: _isHighIntensity,
                      variant: BauhausSwitchVariant.primary,
                      onChanged: (value) => setState(() {
                        _clearValidationErrors();
                        _isHighIntensity = value;
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BauhausSectionHeader(
          title: AppLocalizations.of(context)!.addedSchedules,
          subtitle:
              '${dateList.length} schedule${dateList.length != 1 ? 's' : ''}',
        ),
        const SizedBox(height: BauhausDesign.space4),
        if (dateList.isEmpty)
          BauhausEmptyState(
            title: AppLocalizations.of(context)!.noSchedulesAdded,
            message: AppLocalizations.of(context)!.noSchedulesMessage,
            icon: Icons.schedule_outlined,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dateList.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: BauhausDesign.space4),
            itemBuilder: (context, index) => _card(index),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_scheduleError != null || _validationErrors.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: BauhausDesign.space4),
            padding: const EdgeInsets.all(BauhausDesign.space3),
            decoration: _panelDecoration(
              color: BauhausDesign.error.withOpacity(0.08),
              borderColor: BauhausDesign.error,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.error_outline,
                        color: BauhausDesign.error, size: 20),
                    const SizedBox(width: BauhausDesign.space2),
                    Text(
                      AppLocalizations.of(context)!.validationErrors,
                      style: BauhausDesign.getTextTheme(context)
                          .labelMedium
                          ?.copyWith(color: BauhausDesign.error),
                    ),
                  ],
                ),
                const SizedBox(height: BauhausDesign.space2),
                if (_scheduleError != null)
                  Text(_scheduleError!,
                      style: BauhausDesign.getTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: BauhausDesign.error)),
                ..._validationErrors.map((error) => Text('• $error',
                    style: BauhausDesign.getTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: BauhausDesign.error))),
              ],
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: _squareActionButton(
            onPressed: _addCardWidget,
            text: AppLocalizations.of(context)!.addSchedule,
            icon: Icons.add_rounded,
            isOutlined: true,
            isFullWidth: true,
            textColor: BauhausDesign.primary,
            borderColor: BauhausDesign.primary,
          ),
        ),
        const SizedBox(height: BauhausDesign.space3),
        SizedBox(
          width: double.infinity,
          child: _squareActionButton(
            onPressed: () {
              if (_isSubmitting || dateList.isEmpty) return;
              _handleSubmit();
            },
            text: _isSubmitting
                ? AppLocalizations.of(context)!.submitting
                : AppLocalizations.of(context)!.submitAssignment,
            icon: Icons.send_rounded,
            isLoading: _isSubmitting,
            isFullWidth: true,
            backgroundColor: dateList.isEmpty
                ? BauhausDesign.neutral.withOpacity(0.2)
                : BauhausDesign.primary,
            textColor: dateList.isEmpty
                ? BauhausDesign.textMuted
                : BauhausDesign.surfaceWhite,
            borderColor: dateList.isEmpty
                ? BauhausDesign.neutral
                : BauhausDesign.neutral,
          ),
        ),
      ],
    );
  }

  void _handleSubmit() async {
    if (_isSubmitting) return;

    setState(() {
      _ndisError = null;
      _scheduleError = null;
      _validationErrors.clear();
    });

    List<String> validationErrors = _validateAllSchedules();
    if (validationErrors.isNotEmpty) {
      setState(() {
        _validationErrors = validationErrors;
        _scheduleError = validationErrors.first;
      });

      FlushBarWidget fbw = FlushBarWidget();
      fbw.flushBar(
        context: context,
        title: AppLocalizations.of(context)!.validationError,
        message: validationErrors.first,
        backgroundColor: BauhausDesign.error,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      var response = await _submitAssignedAppointment();
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        FlushBarWidget fbw = FlushBarWidget();
        final Map<String, dynamic> responseData =
            response is Map<String, dynamic>
                ? response
                : <String, dynamic>{
                    'success': false,
                    'statusCode': 0,
                    'message': AppLocalizations.of(context)!.requestFailed,
                  };
        final statusCode = responseData['statusCode'] as int?;
        final message =
            (responseData['message']?.toString().trim().isNotEmpty ?? false)
                ? responseData['message'].toString()
                : AppLocalizations.of(context)!.requestFailed;

        if (responseData['success'] == true) {
          Map<String, dynamic> shiftData = {
            'dateList': dateList,
            'startTimeList': startTimeList,
            'endTimeList': endTimeList,
            'breakList': breakList,
            'ndisItem': _selectedNdisItem?.toJson() ?? {},
            'isHighIntensity': highIntensityList,
          };

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ShiftAssignmentSuccessView(
                userEmail: widget.userEmail,
                clientEmail: widget.clientEmail,
                shiftData: shiftData,
                assignmentId: responseData['assignmentId']?.toString(),
              ),
            ),
          );

          fbw.flushBar(
            context: context,
            title: AppLocalizations.of(context)!.successTitle,
            message: message,
            backgroundColor: BauhausDesign.success,
          );
        } else {
          final errorMessage = statusCode == 403
              ? AppLocalizations.of(context)!.adminAccessRequiredMessage
              : message;
          fbw.flushBar(
            context: context,
            title: AppLocalizations.of(context)!.errorTitle,
            message: errorMessage,
            backgroundColor: BauhausDesign.error,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        FlushBarWidget fbw = FlushBarWidget();
        fbw.flushBar(
          context: context,
          title: AppLocalizations.of(context)!.errorTitle,
          message: AppLocalizations.of(context)!.requestFailed,
          backgroundColor: BauhausDesign.error,
        );
      }
    }
  }

  Future<dynamic> _submitAssignedAppointment() async {
    Map<String, dynamic>? ndisItemWithPricing = _selectedNdisItem?.toJson();
    if (ndisItemWithPricing != null &&
        _isCustomPriceSet &&
        _customPrice != null) {
      ndisItemWithPricing['customPricing'] = {
        'price': _customPrice,
        'pricingType': _pricingType,
        'isCustom': true,
      };
    }

    final List<Map<String, dynamic>> scheduleWithNdisItems = [];

    for (int i = 0; i < dateList.length; i++) {
      Map<String, dynamic> scheduleEntry = {
        'date': dateList[i],
        'startTime': startTimeList[i],
        'endTime': endTimeList[i],
        'break': breakList[i],
        'highIntensity': highIntensityList[i],
      };

      NDISItem? scheduleNdisItem;
      if (i < ndisItemList.length && ndisItemList[i] != null) {
        scheduleNdisItem = ndisItemList[i];
      } else {
        scheduleNdisItem = _selectedNdisItem;
      }

      if (scheduleNdisItem != null) {
        scheduleEntry['ndisItem'] = scheduleNdisItem.toJson();

        if (i < customPricingSetList.length &&
            customPricingSetList[i] &&
            customPriceList[i] != null) {
          scheduleEntry['customPricing'] = {
            'price': customPriceList[i],
            'pricingType': pricingTypeList[i],
            'isCustom': true,
          };
        } else if (scheduleNdisItem == _selectedNdisItem &&
            _isCustomPriceSet &&
            _customPrice != null) {
          scheduleEntry['customPricing'] = {
            'price': _customPrice,
            'pricingType': _pricingType,
            'isCustom': true,
          };
        }
      }

      scheduleWithNdisItems.add(scheduleEntry);
    }

    var ins = await apiMethod.assignClientToUserWithScheduleItems(
      widget.userEmail,
      widget.clientEmail,
      dateList,
      startTimeList,
      endTimeList,
      breakList,
      ndisItemWithPricing ?? {},
      highIntensityList,
      scheduleWithNdisItems,
    );
    return ins;
  }
}
