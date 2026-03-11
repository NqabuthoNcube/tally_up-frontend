/// lib/features/auth/presentation/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/flow/app_flow_state.dart';
import '../../../core/flow/flow_controller.dart';
import '../../../core/utils/phone_utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? error;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void requestOtp() {
    final input = phoneController.text.trim();
    final normalized = PhoneUtils.normalizeZimbabwePhone(input);

    if (normalized == null) {
      setState(() {
        error = "Enter a valid Zimbabwe phone number";
      });
      return;
    }

    setState(() {
      error = null;
    });

    ref.read(flowProvider.notifier).goTo(AppFlowState.authOtp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your phone number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "0771234567",
                border: OutlineInputBorder(),
              ),
            ),

            if (error != null) ...[
              const SizedBox(height: 10),
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: requestOtp,
                child: const Text("Request OTP"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}