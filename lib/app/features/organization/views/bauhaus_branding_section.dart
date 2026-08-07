import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/features/organization/models/organization_model.dart';
import 'package:carenest/app/features/organization/viewmodels/organization_viewmodel.dart';

// Brand Identity Section with Bauhaus Color Theory
class BauhausBrandingSection extends ConsumerStatefulWidget {
  final Organization organization;
  final Function(String, Map<String, dynamic>) onSave;

  const BauhausBrandingSection({
    super.key,
    required this.organization,
    required this.onSave,
  });

  @override
  ConsumerState<BauhausBrandingSection> createState() =>
      _BauhausBrandingSectionState();
}

class _BauhausBrandingSectionState
    extends ConsumerState<BauhausBrandingSection> {
  late Color _primaryColor;
  late Color _secondaryColor;
  String? _logoUrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final branding = widget.organization.branding;
    _primaryColor = branding?.primaryColor != null
        ? Color(int.parse(branding!.primaryColor!.replaceFirst('#', '0xff')))
        : BauhausDesign.primary;
    _secondaryColor = branding?.secondaryColor != null
        ? Color(int.parse(branding!.secondaryColor!.replaceFirst('#', '0xff')))
        : BauhausDesign.secondary;
    _logoUrl = widget.organization.logoUrl;
  }

  bool _isValidHex(String hex) {
    final hexRegex = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
    return hexRegex.hasMatch(hex);
  }

  Future<void> _saveBrandSettings() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final primaryHex =
          '#${_primaryColor.value.toRadixString(16).substring(2)}';
      final secondaryHex =
          '#${_secondaryColor.value.toRadixString(16).substring(2)}';

      if (!_isValidHex(primaryHex) || !_isValidHex(secondaryHex)) {
        throw Exception('Invalid color format');
      }

      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving brand settings...'),
          backgroundColor: BauhausDesign.info,
        ),
      );

      String? finalLogoUrl = _logoUrl;

      // Check if logo is a local file (upload needed)
      if (_logoUrl != null &&
          !(_logoUrl!.startsWith('http') || _logoUrl!.startsWith('https'))) {
        final file = File(_logoUrl!);
        if (file.existsSync()) {
          final viewModel = ref.read(organizationViewModelProvider.notifier);
          finalLogoUrl = await viewModel.uploadLogo(file);
        }
      }

      final brandingData = {
        'primaryColor': primaryHex,
        'secondaryColor': secondaryHex,
        if (finalLogoUrl != null) 'logoUrl': finalLogoUrl,
      };

      // Call parent onSave
      await widget.onSave(widget.organization.id, brandingData);

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Brand settings saved successfully!'),
            backgroundColor: BauhausDesign.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save brand settings: ${e.toString()}'),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: isMobile
              ? EdgeInsets.zero
              : const EdgeInsets.all(BauhausDesign.space8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Bauhaus Typography
              _BauhausSectionHeader(
                title: 'Brand Identity',
                subtitle: 'Define your organization\'s visual language',
                icon: Icons.palette_outlined,
              ),

              const SizedBox(height: BauhausDesign.space8),

              // Color Theory Visualization
              if (isMobile) ...[
                // Mobile Layout (Stacked)
                Column(
                  children: [
                    _BauhausColorField(
                      title: 'Primary Color',
                      color: _primaryColor,
                      onColorChanged: (color) {
                        setState(() {
                          _primaryColor = color;
                        });
                      },
                      description:
                          'Primary brand color - used for main actions and highlights',
                    ),
                    const SizedBox(height: BauhausDesign.space6),
                    _BauhausColorField(
                      title: 'Secondary Color',
                      color: _secondaryColor,
                      onColorChanged: (color) {
                        setState(() {
                          _secondaryColor = color;
                        });
                      },
                      description:
                          'Secondary brand color - used for supporting elements',
                    ),
                    const SizedBox(height: BauhausDesign.space6),
                    _BauhausColorHarmonyCard(
                      primaryColor: _primaryColor,
                      secondaryColor: _secondaryColor,
                    ),
                  ],
                ),
              ] else ...[
                // Desktop Layout (Row)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Primary Color Section
                    Expanded(
                      flex: 2,
                      child: _BauhausColorField(
                        title: 'Primary Color',
                        color: _primaryColor,
                        onColorChanged: (color) {
                          setState(() {
                            _primaryColor = color;
                          });
                        },
                        description:
                            'Primary brand color - used for main actions and highlights',
                      ),
                    ),

                    const SizedBox(width: BauhausDesign.space6),

                    // Secondary Color Section
                    Expanded(
                      flex: 2,
                      child: _BauhausColorField(
                        title: 'Secondary Color',
                        color: _secondaryColor,
                        onColorChanged: (color) {
                          setState(() {
                            _secondaryColor = color;
                          });
                        },
                        description:
                            'Secondary brand color - used for supporting elements',
                      ),
                    ),

                    const SizedBox(width: BauhausDesign.space6),

                    // Color Harmony Visualization
                    Expanded(
                      flex: 3,
                      child: _BauhausColorHarmonyCard(
                        primaryColor: _primaryColor,
                        secondaryColor: _secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: BauhausDesign.space8),

              // Logo Section with Geometric Design
              _BauhausLogoSection(
                organization: widget.organization,
                onLogoChanged: (logoUrl) {
                  setState(() {
                    _logoUrl = logoUrl;
                  });
                },
                isMobile: isMobile,
              ),

              const SizedBox(height: BauhausDesign.space8),

              // Brand Preview Card
              _BauhausBrandPreviewCard(
                organization: widget.organization,
                primaryColor: _primaryColor,
                secondaryColor: _secondaryColor,
                logoUrl: _logoUrl,
              ),

              const SizedBox(height: BauhausDesign.space8),

              // Action Buttons
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _BauhausSecondaryButton(
                          text: 'Reset to Default',
                          onPressed: () {
                            setState(() {
                              _primaryColor = BauhausDesign.primary;
                              _secondaryColor = BauhausDesign.secondary;
                            });
                          },
                        ),
                        const SizedBox(height: BauhausDesign.space4),
                        _BauhausPrimaryButton(
                          text: 'Save Brand Settings',
                          onPressed: () {
                            _saveBrandSettings();
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _BauhausSecondaryButton(
                          text: 'Reset to Default',
                          onPressed: () {
                            setState(() {
                              _primaryColor = BauhausDesign.primary;
                              _secondaryColor = BauhausDesign.secondary;
                            });
                          },
                        ),
                        const SizedBox(width: BauhausDesign.space4),
                        _BauhausPrimaryButton(
                          text: 'Save Brand Settings',
                          onPressed: () {
                            _saveBrandSettings();
                          },
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _BauhausColorField extends StatefulWidget {
  final String title;
  final Color color;
  final Function(Color) onColorChanged;
  final String description;

  const _BauhausColorField({
    required this.title,
    required this.color,
    required this.onColorChanged,
    required this.description,
  });

  @override
  State<_BauhausColorField> createState() => _BauhausColorFieldState();
}

class _BauhausColorFieldState extends State<_BauhausColorField> {
  void _showColorPickerDialog() {
    final List<Color> bauhausColors = [
      BauhausDesign.primary,
      BauhausDesign.secondary,
      BauhausDesign.accent,
      BauhausDesign.success,
      BauhausDesign.warning,
      BauhausDesign.error,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.cyan,
      Colors.lime,
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Color',
            style: GoogleFonts.oswald(
              fontSize: BauhausDesign.fontLg,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textDark,
            ),
          ),
          content: SizedBox(
            width: 300,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: bauhausColors.length,
              itemBuilder: (context, index) {
                final color = bauhausColors[index];
                return GestureDetector(
                  onTap: () {
                    widget.onColorChanged(color);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: widget.color == color
                            ? BauhausDesign.textDark
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: widget.color == color
                        ? const Icon(Icons.check, color: Colors.white, size: 24)
                        : null,
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: BauhausDesign.textMuted),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color Display with Geometric Shape
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: widget.color,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 15,
                    height: 15,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: GoogleFonts.oswald(
                          fontSize: BauhausDesign.fontLg,
                          fontWeight: FontWeight.w600,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: BauhausDesign.space2,
                        vertical: BauhausDesign.space1,
                      ),
                      decoration: BoxDecoration(
                        color: BauhausDesign.surfaceOffWhite,
                        border: Border.all(
                          color: BauhausDesign.neutral,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '#${widget.color.value.toRadixString(16).substring(2).toUpperCase()}',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontXs,
                          fontWeight: FontWeight.w500,
                          color: BauhausDesign.textDark,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: BauhausDesign.space2),

                Text(
                  widget.description,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    color: BauhausDesign.textMuted,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: BauhausDesign.space3),

                // Color Picker Button
                SizedBox(
                  width: double.infinity,
                  child: _BauhausSecondaryButton(
                    text: 'Choose Color',
                    onPressed: () {
                      _showColorPickerDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausColorHarmonyCard extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const _BauhausColorHarmonyCard({
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: primaryColor,
                  child: const Icon(
                    Icons.color_lens_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  'Color Harmony',
                  style: GoogleFonts.oswald(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                // Primary Color Variations
                _BauhausColorVariationRow(
                  baseColor: primaryColor,
                  title: 'Primary Variations',
                ),

                const SizedBox(height: BauhausDesign.space3),

                // Secondary Color Variations
                _BauhausColorVariationRow(
                  baseColor: secondaryColor,
                  title: 'Secondary Variations',
                ),

                const SizedBox(height: BauhausDesign.space4),

                // Contrast Ratio Display
                _BauhausContrastRatioDisplay(
                  color1: primaryColor,
                  color2: secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausColorVariationRow extends StatelessWidget {
  final Color baseColor;
  final String title;

  const _BauhausColorVariationRow({
    required this.baseColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontSm,
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),

        const SizedBox(height: BauhausDesign.space2),

        Row(
          children: [
            _BauhausColorSwatch(
              color: baseColor.withOpacity(0.8),
              label: '80%',
            ),
            const SizedBox(width: BauhausDesign.space2),
            _BauhausColorSwatch(
              color: baseColor.withOpacity(0.6),
              label: '60%',
            ),
            const SizedBox(width: BauhausDesign.space2),
            _BauhausColorSwatch(
              color: baseColor.withOpacity(0.4),
              label: '40%',
            ),
            const SizedBox(width: BauhausDesign.space2),
            _BauhausColorSwatch(
              color: baseColor.withOpacity(0.2),
              label: '20%',
            ),
          ],
        ),
      ],
    );
  }
}

class _BauhausColorSwatch extends StatelessWidget {
  final Color color;
  final String label;

  const _BauhausColorSwatch({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: BauhausDesign.neutral, width: 1),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontXs,
            color: BauhausDesign.textMuted,
          ),
        ),
      ],
    );
  }
}

class _BauhausContrastRatioDisplay extends StatelessWidget {
  final Color color1;
  final Color color2;

  const _BauhausContrastRatioDisplay({
    required this.color1,
    required this.color2,
  });

  double _calculateContrastRatio(Color color1, Color color2) {
    double luminance1 = color1.computeLuminance();
    double luminance2 = color2.computeLuminance();
    double lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    double darker = luminance1 > luminance2 ? luminance2 : luminance1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  @override
  Widget build(BuildContext context) {
    double contrastRatio = _calculateContrastRatio(color1, color2);
    bool isAccessible = contrastRatio >= 4.5;

    return Container(
      padding: const EdgeInsets.all(BauhausDesign.space3),
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceOffWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            color: isAccessible ? BauhausDesign.success : BauhausDesign.warning,
            child: Icon(
              isAccessible
                  ? Icons.check_circle_outline
                  : Icons.warning_amber_outlined,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: BauhausDesign.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contrast Ratio: ${contrastRatio.toStringAsFixed(2)}:1',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontSm,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
                Text(
                  isAccessible
                      ? 'WCAG AA Compliant'
                      : 'Below WCAG AA Standard (4.5:1)',
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontXs,
                    color: isAccessible
                        ? BauhausDesign.success
                        : BauhausDesign.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausLogoSection extends StatefulWidget {
  final Organization organization;
  final Function(String?) onLogoChanged;
  final bool isMobile;

  const _BauhausLogoSection({
    required this.organization,
    required this.onLogoChanged,
    this.isMobile = false,
  });

  @override
  State<_BauhausLogoSection> createState() => _BauhausLogoSectionState();
}

class _BauhausLogoSectionState extends State<_BauhausLogoSection> {
  String? _logoUrl;
  File? _localImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _logoUrl = widget.organization.logoUrl;
  }

  Future<void> _handleLogoUpload() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _localImageFile = File(pickedFile.path);
        });

        widget.onLogoChanged(pickedFile.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: BauhausDesign.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Text(
                  'Logo & Visual Identity',
                  style: GoogleFonts.oswald(
                    fontSize: BauhausDesign.fontLg,
                    fontWeight: FontWeight.w600,
                    color: BauhausDesign.textDark,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: widget.isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLogoPreview(),
                      const SizedBox(height: BauhausDesign.space6),
                      _buildUploadSection(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: _buildLogoPreview()),
                      const SizedBox(width: BauhausDesign.space6),
                      Expanded(flex: 3, child: _buildUploadSection()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoPreview() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Current Logo',
            style: GoogleFonts.inter(
              fontSize: BauhausDesign.fontMd,
              fontWeight: FontWeight.w600,
              color: BauhausDesign.textDark,
            ),
          ),

          const SizedBox(height: BauhausDesign.space3),

          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: BauhausDesign.surfaceOffWhite,
              border: Border.all(color: BauhausDesign.neutral, width: 2),
            ),
            child: _localImageFile != null
                ? Image.file(_localImageFile!, fit: BoxFit.contain)
                : _logoUrl != null
                ? Image.network(
                    _logoUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: BauhausDesign.textMuted,
                          ),
                          Text(
                            'Error loading',
                            style: TextStyle(
                              color: BauhausDesign.textMuted,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business,
                        size: 40,
                        color: BauhausDesign.textMuted,
                      ),
                      const SizedBox(height: BauhausDesign.space2),
                      Text(
                        'No Logo',
                        style: GoogleFonts.inter(
                          fontSize: BauhausDesign.fontSm,
                          color: BauhausDesign.textMuted,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload New Logo',
          style: GoogleFonts.inter(
            fontSize: BauhausDesign.fontMd,
            fontWeight: FontWeight.w600,
            color: BauhausDesign.textDark,
          ),
        ),

        const SizedBox(height: BauhausDesign.space3),

        Container(
          padding: const EdgeInsets.all(BauhausDesign.space6),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceOffWhite,
            border: Border.all(
              color: BauhausDesign.textMuted.withOpacity(0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 48,
                color: BauhausDesign.textMuted,
              ),
              const SizedBox(height: BauhausDesign.space3),
              Text(
                'Drag & drop or click to upload',
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontMd,
                  color: BauhausDesign.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: BauhausDesign.space1),
              Text(
                'PNG, JPG, SVG up to 5MB',
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontSm,
                  color: BauhausDesign.textMuted,
                ),
              ),
              const SizedBox(height: BauhausDesign.space4),
              SizedBox(
                width: double.infinity,
                child: _BauhausSecondaryButton(
                  text: 'Choose File',
                  onPressed: () {
                    _handleLogoUpload();
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: BauhausDesign.space4),

        // Logo Guidelines
        Container(
          padding: const EdgeInsets.all(BauhausDesign.space3),
          decoration: BoxDecoration(
            color: BauhausDesign.surfaceWhite,
            border: Border.all(color: BauhausDesign.neutral, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: BauhausDesign.info),
                  const SizedBox(width: BauhausDesign.space2),
                  Text(
                    'Logo Guidelines',
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontSm,
                      fontWeight: FontWeight.w600,
                      color: BauhausDesign.textDark,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: BauhausDesign.space2),
              Text(
                '• Recommended size: 200x200px minimum\n'
                '• Transparent background preferred\n'
                '• High contrast for accessibility\n'
                '• Simple, recognizable design',
                style: GoogleFonts.inter(
                  fontSize: BauhausDesign.fontXs,
                  color: BauhausDesign.textMuted,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BauhausBrandPreviewCard extends StatelessWidget {
  final Organization organization;
  final Color primaryColor;
  final Color secondaryColor;
  final String? logoUrl;

  const _BauhausBrandPreviewCard({
    required this.organization,
    required this.primaryColor,
    required this.secondaryColor,
    this.logoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(color: BauhausDesign.neutral, width: 2),
        boxShadow: [BauhausDesign.shadowHard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border(
                bottom: BorderSide(color: BauhausDesign.neutral, width: 2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.white.withOpacity(0.3),
                  child: logoUrl != null
                      ? Image.network(logoUrl!, fit: BoxFit.contain)
                      : Icon(
                          Icons.business,
                          size: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                ),
                const SizedBox(width: BauhausDesign.space3),
                Expanded(
                  child: Text(
                    organization.name,
                    style: GoogleFonts.inter(
                      fontSize: BauhausDesign.fontMd,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(BauhausDesign.space4),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _BauhausPreviewButton(
                        text: 'Primary Action',
                        color: primaryColor,
                        isPrimary: true,
                      ),
                    ),
                    const SizedBox(width: BauhausDesign.space3),
                    Expanded(
                      child: _BauhausPreviewButton(
                        text: 'Secondary',
                        color: secondaryColor,
                        isPrimary: false,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: BauhausDesign.space4),

                Container(
                  padding: const EdgeInsets.all(BauhausDesign.space3),
                  decoration: BoxDecoration(
                    color: BauhausDesign.surfaceOffWhite,
                    border: Border.all(color: BauhausDesign.neutral, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(width: 16, height: 16, color: primaryColor),
                      const SizedBox(width: BauhausDesign.space2),
                      Expanded(
                        child: Text(
                          'Primary Color Applied',
                          style: GoogleFonts.inter(
                            fontSize: BauhausDesign.fontSm,
                            color: BauhausDesign.textDark,
                          ),
                        ),
                      ),
                      Container(width: 16, height: 16, color: secondaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BauhausPreviewButton extends StatelessWidget {
  final String text;
  final Color color;
  final bool isPrimary;

  const _BauhausPreviewButton({
    required this.text,
    required this.color,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BauhausDesign.space4,
        vertical: BauhausDesign.space3,
      ),
      decoration: BoxDecoration(
        color: isPrimary ? color : Colors.transparent,
        border: Border.all(
          color: isPrimary ? BauhausDesign.neutral : color,
          width: 2,
        ),
        boxShadow: isPrimary ? [BauhausDesign.shadowHardSm] : [],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: BauhausDesign.fontSm,
          fontWeight: FontWeight.w600,
          color: isPrimary ? Colors.white : color,
        ),
      ),
    );
  }
}

// Common Button Components
class _BauhausPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _BauhausPrimaryButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: isEnabled
            ? theme.primaryColor
            : BauhausDesign.neutral.withOpacity(0.1),
        border: Border.all(
          color: isEnabled
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: isEnabled ? [BauhausDesign.shadowHard] : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                fontWeight: FontWeight.w600,
                color: isEnabled
                    ? Colors.white
                    : BauhausDesign.textDark.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _BauhausSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _BauhausSecondaryButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: BauhausDesign.surfaceWhite,
        border: Border.all(
          color: isEnabled
              ? BauhausDesign.neutral
              : BauhausDesign.neutral.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: theme.colorScheme.secondary,
                  offset: const Offset(2, 2),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BauhausDesign.space6,
              vertical: BauhausDesign.space3,
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: BauhausDesign.fontMd,
                fontWeight: FontWeight.w600,
                color: isEnabled
                    ? BauhausDesign.textDark
                    : BauhausDesign.textDark.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Section Header Component
class _BauhausSectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _BauhausSectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: BauhausDesign.space4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            color: Theme.of(context).primaryColor,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: BauhausDesign.space4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: BauhausDesign.textDark,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: BauhausDesign.fontMd,
                    color: BauhausDesign.textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
