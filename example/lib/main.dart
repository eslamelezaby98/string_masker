import 'package:flutter/material.dart';
import 'package:string_masker/string_masker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Masker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MaskerDemo(),
    );
  }
}

class MaskerDemo extends StatefulWidget {
  const MaskerDemo({super.key});

  @override
  State<MaskerDemo> createState() => _MaskerDemoState();
}

class _MaskerDemoState extends State<MaskerDemo> {
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final _cardController = TextEditingController(text: '4532715337901241');
  final _customController = TextEditingController(text: 'Hello World');

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _cardController.dispose();
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('String Masker Examples'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInputCard(
            title: 'Email Masking & Validation',
            controller: _emailController,
            onValidate: () =>
                StringValidator.isValidEmail(_emailController.text),
            onMask: () => StringMasker.mask(
              _emailController.text,
              type: MaskType.email,
            ),
          ),
          _buildInputCard(
            title: 'Phone Masking & Validation',
            controller: _phoneController,
            onValidate: () =>
                StringValidator.isValidPhone(_phoneController.text),
            onMask: () => StringMasker.mask(
              _phoneController.text,
              type: MaskType.phone,
            ),
          ),
          _buildInputCard(
            title: 'Credit Card Masking & Validation',
            controller: _cardController,
            onValidate: () => StringValidator.isValidCard(_cardController.text),
            onMask: () => StringMasker.mask(
              _cardController.text,
              type: MaskType.card,
            ),
          ),
          _buildInputCard(
            title: 'Custom Masking',
            controller: _customController,
            onValidate: () => _customController.text.isNotEmpty,
            onMask: () => StringMasker.mask(
              _customController.text,
              type: MaskType.custom,
              start: 2,
              end: 3,
              maskChar: '#',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard({
    required String title,
    required TextEditingController controller,
    required bool Function() onValidate,
    required String? Function() onMask,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter value',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      bool isValid = onValidate();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isValid ? 'Valid input!' : 'Invalid input!',
                          ),
                          backgroundColor: isValid ? Colors.green : Colors.red,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('Validate'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      String? masked = onMask();
                      if (masked != null) {
                        controller.text = masked;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid input! Cannot mask.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.masks_outlined),
                    label: const Text('Mask'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
