import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/common/next_button.dart';
import '../home/home_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const PinVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final _pinController = TextEditingController();
  bool _isLoading = false;

  void _verifyPin() {
    if (_pinController.text.length == 6) {
      setState(() => _isLoading = true);
      // TODO: Implement actual PIN verification
      print('PIN: ${_pinController.text}');
      
      // Navigate to home screen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false, // This removes all previous routes
      );
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Verification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const SizedBox(height: 170),// Add space from top
                    const Text(
                      'Verify your phone',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please enter the 6-digit code sent to\n${widget.phoneNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _pinController,
                      onChanged: (value) {},
                      // onCompleted: (_) => _verifyPin(),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 64,
                        fieldWidth: 44,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        borderWidth: 1,
                        activeColor: Colors.grey.shade200,
                        selectedColor: Colors.grey.shade200,
                        inactiveColor: Colors.grey.shade200,
                        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.scale,
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ),
              NextButton(
                onPressed: _verifyPin,
                text: 'Verify',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 