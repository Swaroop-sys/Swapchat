import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
  }) : assert(
         text != null || child != null,
         'Either text or child must be provided',
       );

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;

  void _handlePress() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // Simulate loading

    setState(() => _isLoading = false);

    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : widget.child ??
                  Text(
                    widget.text!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      ),
    );
  }
}
