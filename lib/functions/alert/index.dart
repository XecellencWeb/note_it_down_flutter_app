import 'package:flutter/material.dart';

void showTextDialog(
  BuildContext context,
  String heading,
  String confirmText,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          content: Text(confirmText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        );
      });
}

void showConfirmDialog(BuildContext context, String heading, String confirmText,
    Function callback) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          content: Text(confirmText),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                callback();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            )
          ],
        );
      });
}

void showPromptDialog(BuildContext context, String heading, String promptText,
    Function callback) {
  String enteredText = '';
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          content: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(promptText),
                TextField(
                  onChanged: (text) {
                    enteredText = text;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(), labelText: heading),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                callback(enteredText);
              },
              child: const Text('Okay'),
            )
          ],
        );
      });
}
