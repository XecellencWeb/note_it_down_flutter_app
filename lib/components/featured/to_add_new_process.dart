import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/components/create_component/create_button.dart';
import 'package:task_manager_app/components/create_component/form.dart';

class NewProcessAdder extends StatefulWidget {
  final TaskInstance? instance;
  final TextEditingController nameController;
  final TextEditingController descController;
  final VoidCallback submitFunction;

  const NewProcessAdder({
    super.key,
    this.instance,
    required this.nameController,
    required this.descController,
    required this.submitFunction,
    
  });

  @override
  State<NewProcessAdder> createState() => _NewProcessAdderState();
}

class _NewProcessAdderState extends State<NewProcessAdder> {

void _initInputs() {
    if (widget.instance != null) {
      widget.nameController.text = widget.instance!.name.toString();
      widget.descController.text = widget.instance!.description.toString();
    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    _initInputs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreateForm(
          headingInput: widget.nameController,
          descriptionInput: widget.descController,
        ),
        ButtonGroup(
          buttonText: "Edit",
          submitFunction: widget.submitFunction,
          isEditMode: true,
        )
      ],
    );
  }
}
