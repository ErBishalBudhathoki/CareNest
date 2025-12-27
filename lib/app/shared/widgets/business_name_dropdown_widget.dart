import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/core/providers/app_providers.dart';

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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFD4D4D4),
          width: 1,
        ),
      ),
      child: Center(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFFD4D4D4),
          value: _selectedBusinessName,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(fontSize: 16).copyWith(
            color: const Color(0xFF1F2937),
          ),
          underline: Container(
            height: 2,
            color: Colors.transparent,
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
                    style: const TextStyle(fontSize: 16).copyWith(
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
