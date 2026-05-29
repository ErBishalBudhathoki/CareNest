import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';

const _ink = BauhausDesign.neoInk;
const _paper = BauhausDesign.neoPaper;
const _signal = BauhausDesign.neoSignal;
const _danger = BauhausDesign.neoDanger;
const _highlight = BauhausDesign.neoHighlight;

/// Shows Bauhaus Neo-Brutalist styled time picker dialog.
/// Returns [TimeOfDay] when confirmed, or `null` if cancelled.
Future<TimeOfDay?> showBauhausTimePicker({
  required BuildContext context,
  TimeOfDay? initialTime,
}) async {
  return showDialog<TimeOfDay>(
    context: context,
    barrierColor: _ink.withOpacity(0.55),
    builder: (_) => _BauhausTimePickerDialog(
      initialTime: initialTime ?? TimeOfDay.now(),
    ),
  );
}

class _BauhausTimePickerDialog extends StatefulWidget {
  const _BauhausTimePickerDialog({required this.initialTime});
  final TimeOfDay initialTime;

  @override
  State<_BauhausTimePickerDialog> createState() =>
      _BauhausTimePickerDialogState();
}

class _BauhausTimePickerDialogState
    extends State<_BauhausTimePickerDialog> {
  late int _hour;
  late int _minute;
  late bool _isAm;

  final _hourController = TextEditingController();
  final _minuteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hour = widget.initialTime.hourOfPeriod;
    _minute = widget.initialTime.minute;
    _isAm = widget.initialTime.period == DayPeriod.am;
    _syncControllers();
  }

  void _syncControllers() {
    _hourController.text = _hour.toString().padLeft(2, '0');
    _minuteController.text = _minute.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _togglePeriod() => setState(() => _isAm = !_isAm);

  TimeOfDay get _selectedTime => TimeOfDay(
        hour: _isAm ? _hour : (_hour == 12 ? 12 : _hour + 12),
        minute: _minute,
      );

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final dialogW = (screenW * 0.85).clamp(260.0, 340.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: dialogW,
        decoration: BoxDecoration(
          color: _paper,
          border: Border.all(color: _ink, width: BauhausDesign.neoBorderWidth),
          boxShadow: const [
            BoxShadow(color: _ink, offset: Offset(8, 8), blurRadius: 0),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildTimeDisplay(),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: _ink,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(width: 6, height: 28, color: _highlight),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'SELECT TIME',
              style: GoogleFonts.oswald(
                color: _paper, fontSize: 18, fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(null),
            child: Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: _paper.withOpacity(0.5), width: 1.5),
              ),
              child: const Icon(Icons.close_rounded, color: _paper, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeSegment(_hourController, (v) {
                final h = int.tryParse(v);
                if (h != null) setState(() => _hour = h.clamp(1, 12));
              }),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  ':',
                  style: GoogleFonts.oswald(
                    color: _ink, fontSize: 36, fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildTimeSegment(_minuteController, (v) {
                final m = int.tryParse(v);
                if (m != null) setState(() => _minute = m.clamp(0, 59));
              }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _periodButton('AM', _isAm),
              const SizedBox(width: 8),
              _periodButton('PM', !_isAm),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSegment(TextEditingController ctrl, ValueChanged<String> onChanged) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: _ink, width: BauhausDesign.neoInnerBorderWidth),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: GoogleFonts.oswald(
          color: _ink, fontSize: 36, fontWeight: FontWeight.w700,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _periodButton(String label, bool active) {
    return GestureDetector(
      onTap: active ? null : _togglePeriod,
      child: Container(
        width: 56,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? _signal : _paper,
          border: Border.all(color: _ink, width: BauhausDesign.neoInnerBorderWidth),
          boxShadow: active
              ? const [BoxShadow(color: _ink, offset: Offset(2, 2), blurRadius: 0)]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.oswald(
            color: active ? _paper : _ink,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(null),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: _paper,
                  border: Border.all(color: _ink, width: BauhausDesign.neoInnerBorderWidth),
                  boxShadow: const [
                    BoxShadow(color: _ink, offset: Offset(3, 3), blurRadius: 0),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.oswald(
                    color: _ink, fontSize: 13, fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(_selectedTime),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: _danger,
                  border: Border.all(color: _ink, width: BauhausDesign.neoBorderWidth),
                  boxShadow: const [
                    BoxShadow(color: _ink, offset: Offset(4, 4), blurRadius: 0),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_rounded, color: _paper, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'CONFIRM TIME',
                      style: GoogleFonts.oswald(
                        color: _paper, fontSize: 13, fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
