import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';

class ProcedureDesc extends StatelessWidget {
  final TaskInstance procedure;
  const ProcedureDesc({super.key,required this.procedure});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(procedure.name.toString()),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Text(procedure.description.toString()),
        ),
      ),
    );
  }
}
