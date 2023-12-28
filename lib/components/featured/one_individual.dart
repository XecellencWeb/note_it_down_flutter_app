import 'package:flutter/material.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/functions/alert/index.dart';
import 'package:task_manager_app/graph_ql/mutation.dart';
import 'package:task_manager_app/pages/individual_task.dart';
import '../../classes/index.dart';

class OneIndividual extends StatefulWidget {
  final User individual;
  final String page;
  final String? isOwnerId;

  const OneIndividual(
      {super.key,
      required this.individual,
      this.page = '',
      required this.isOwnerId});

  @override
  State<OneIndividual> createState() => _OneIndividualState();
}

class _OneIndividualState extends State<OneIndividual> {
  final GraphQLMutation _graphQLMutation = GraphQLMutation();
  void approveFunc() async {
    try {
      String text = await _graphQLMutation.authorizeUser(
        userId: widget.individual.id,
        authorisingId: widget.isOwnerId,
      );
      textDialogLogger(
        text: text,
        body: "You have successfully approve this user to view your tasks",
      );
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  void textDialogLogger({required String text, required String body}) {
    showTextDialog(context, text, body);
  }

  void findFunc() async {
    try {
      String text = await _graphQLMutation.requestUserAuthorizing(
        user: User.toMap(user: widget.individual),
        authorisedBy: widget.isOwnerId,
      );

      textDialogLogger(
        text: text,
        body:
            "Your request to view this user tasks has been sent successfully.",
      );
    } catch (error) {
      print(error);
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              if (widget.page != REQUEST && widget.page != FIND) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IndividualTasks(individual: widget.individual),
                  ),
                );
              }
            },
            child: Row(
              children: [
                const Icon(
                  Icons.person_4_rounded,
                  size: 60,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.individual.name,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 2, 80),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.1,
                            fontSize: 15),
                      ),
                      Text(
                        widget.individual.title,
                        style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (widget.page == REQUEST)
            OutlinedButton(
              onPressed: () {
                showConfirmDialog(
                    context,
                    'Approve User',
                    'Do you want to approve ${widget.individual.name} to view your tasks?',
                    approveFunc);
              },
              child: const Text('Approve User'),
            ),
          if (widget.page == FIND)
            OutlinedButton(
              onPressed: () {
                showConfirmDialog(
                    context,
                    'Find User',
                    'This will send a request to ${widget.individual.name} requesting him to authorize you to view your his tasks. Do you want to Continue?',
                    findFunc);
              },
              child: const Text('Request Approval'),
            ),
        ],
      ),
    );
  }
}
