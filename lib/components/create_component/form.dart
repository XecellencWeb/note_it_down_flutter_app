import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/constants/names.dart';

class CreateForm extends StatefulWidget {
  //Controllers

  final TextEditingController headingInput;
  final TextEditingController descriptionInput;
  final bool descUnLimited;

  CreateForm({
    super.key,
    required this.headingInput,
    required this.descriptionInput,
    this.descUnLimited = true,
  });

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: widget.headingInput,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter name of Task...'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: TextFormField(
              controller: widget.descriptionInput,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              maxLength: widget.descUnLimited ? null : 500,
              textAlign: TextAlign.start,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Describe the task...'),
            ),
          ),
          
        ],
      ),
    );
  }
}
