import 'package:flutter/material.dart';

class ButtonGroup extends StatelessWidget {
  final bool isEditMode;
  final String buttonText;
  final bool isToggleable;
  final VoidCallback submitFunction;
  final VoidCallback? cancelFunction;

  const ButtonGroup({
    super.key,
    required this.buttonText,
    required this.submitFunction,
    this.cancelFunction,
    this.isEditMode = false,
    this.isToggleable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: submitFunction,
            child: Row(
              children: [
                isEditMode ? const Icon(Icons.edit) : const Icon(Icons.add),
                Text(buttonText),
              ],
            ),
          ),
          if (isToggleable)
            TextButton(
              onPressed: cancelFunction,
              child: const Text('Cancel'),
            ),
        ],
      ),
    );
  }
}
