import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/app/routes/app_pages.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final api = ref.read(apiMethodProvider);
      // We assume user is logged in and token is set
      final response = await api.post('api/client-portal/auth/change-password', body: {
        'currentPassword': _currentController.text,
        'newPassword': _newController.text,
      });

      if (response['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully!')),
          );
          Navigator.pushNamedAndRemoveUntil(context, Routes.clientDashboard, (route) => false);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Failed to change password')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BauhausDesign.background,
      appBar: AppBar(
        title: const Text('Change Password'),
        automaticallyImplyLeading: false, // Force change
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BauhausDesign.space4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Security Update Required',
                style: BauhausDesign.getTextTheme(context).headlineMedium,
              ),
              const SizedBox(height: BauhausDesign.space2),
              const Text('Please update your password to continue using the application.'),
              const SizedBox(height: BauhausDesign.space6),
              
              BauhausTextField(
                controller: _currentController,
                label: 'Current (Temporary) Password',
                obscureText: true,
                validator: (v) => v?.isEmpty == true ? 'Required' : null,
              ),
              const SizedBox(height: BauhausDesign.space4),
              
              BauhausTextField(
                controller: _newController,
                label: 'New Password',
                obscureText: true,
                validator: (v) => (v?.length ?? 0) < 8 ? 'Must be at least 8 characters' : null,
              ),
              const SizedBox(height: BauhausDesign.space4),
              
              BauhausTextField(
                controller: _confirmController,
                label: 'Confirm New Password',
                obscureText: true,
                validator: (v) {
                  if (v != _newController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              const SizedBox(height: BauhausDesign.space6),
              
              BauhausActionButton(
                text: 'Update Password',
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Provider for ApiMethod
final apiMethodProvider = Provider<ApiMethod>((ref) => ApiMethod());
