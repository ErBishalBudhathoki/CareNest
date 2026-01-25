import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

class BusinessNameDropdown extends ConsumerStatefulWidget {
  final Function(String) onChanged;

  const BusinessNameDropdown({super.key, required this.onChanged});

  @override
  _BusinessNameDropdownState createState() => _BusinessNameDropdownState();
}

class _BusinessNameDropdownState extends ConsumerState<BusinessNameDropdown> {
  List<dynamic> _businessNameList = [];
  String _selectedBusinessName = 'Select Business Name';

  @override
  void initState() {
    super.initState();
    _loadBusinessNames();
  }

  Future<void> _loadBusinessNames() async {
    final apiMethod = ref.read(apiMethodProvider);
    final businessNameList = await apiMethod.getBusinessNameList();

    if (businessNameList != null) {
      setState(() {
        _businessNameList = businessNameList;
        _businessNameList.insert(0, {'businessName': 'Select Business Name'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        borderRadius: BorderRadius.circular(BauhausDesign.radiusMd),
        border: Border.all(
          color: BauhausDesign.neutral,
          width: BauhausDesign.borderThin,
        ),
        boxShadow: BauhausDesign.shadowSm,
      ),
      padding: EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: BauhausDesign.surfaceWhite,
            value: _businessNameList
                    .any((e) => e['businessName'] == _selectedBusinessName)
                ? _selectedBusinessName
                : _businessNameList.isNotEmpty
                    ? _businessNameList[0]['businessName']
                    : null,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: BauhausDesign.textDark),
            iconSize: 24,
            elevation: 4,
            style: BauhausDesign.getTextTheme(context).bodyMedium?.copyWith(
                  color: BauhausDesign.textDark,
                ),
            onChanged: (String? selectedValue) {
              if (selectedValue != null) {
                setState(() {
                  _selectedBusinessName = selectedValue;
                });
                widget.onChanged(selectedValue);
              }
            },
            items: _businessNameList
                .map<DropdownMenuItem<String>>(
                  (dynamic businessName) => DropdownMenuItem<String>(
                    value: businessName['businessName'],
                    child: Text(
                      businessName['businessName'],
                      style: BauhausDesign.getTextTheme(context)
                          .bodyMedium
                          ?.copyWith(
                            color: BauhausDesign.textDark,
                          ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
