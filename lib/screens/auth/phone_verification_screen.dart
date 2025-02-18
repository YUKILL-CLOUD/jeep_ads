import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/common/next_button.dart';
import 'pin_verification_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _proceedToOTP() {
    if (_formKey.currentState?.validate() ?? false) {
      // Format phone number for display with +63 prefix
      final formattedNumber = '${_phoneController.text.substring(0, 3)} '
          '${_phoneController.text.substring(3, 6)} '
          '${_phoneController.text.substring(6)}';
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PinVerificationScreen(
            phoneNumber: formattedNumber,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Verification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 20/20,
          ),
        ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                      const SizedBox(height: 170),
                      const Text(
                        'Verify your number',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          height: 22/33,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Please Enter your Number Here",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '906 012 6528',
                          border: const OutlineInputBorder(),
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.flag),
                                const SizedBox(width: 8),
                                const Text(
                                  '+63',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              NextButton(
                onPressed: _proceedToOTP,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 