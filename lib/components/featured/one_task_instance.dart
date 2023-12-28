import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/pages/describe_task.dart';

class OneTaskInstance extends StatelessWidget {
  final int instanceIndex;
  final int maxLength;
  final TaskInstance instance;
  final bool isEditMode;
  final VoidCallback? editFunc;
  final VoidCallback? addOnTop;
  final VoidCallback? addUnder;
  final VoidCallback? removeFunc;

  const OneTaskInstance({
    super.key,
    required this.instanceIndex,
    required this.maxLength,
    required this.instance,
    this.isEditMode = false,
    this.editFunc,
    //Adding functions references
    this.addOnTop,
    this.addUnder,
    this.removeFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      child: GestureDetector(
        onTap: isEditMode
            ? editFunc
            : () {
                if (!isEditMode) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProcedureDesc(procedure: instance),
                    ),
                  );
                  return;
                }
              },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.blue,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      instance.name.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            if (isEditMode)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (instanceIndex == 0)
                      GestureDetector(
                        onTap: addOnTop,
                        child: const Row(
                          children: [
                            Text(
                              'Add',
                              style: TextStyle(
                                color: Color.fromARGB(255, 72, 5, 83),
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_upward_sharp,
                              size: 15,
                              color: Color.fromARGB(255, 72, 5, 83),
                            )
                          ],
                        ),
                      ),
                    if (instanceIndex != maxLength - 1)
                      GestureDetector(
                        onTap: addUnder,
                        child: const Row(
                          children: [
                            Text(
                              'Add',
                              style: TextStyle(
                                color: Color.fromARGB(255, 72, 5, 83),
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward_sharp,
                              size: 15,
                              color: Color.fromARGB(255, 72, 5, 83),
                            )
                          ],
                        ),
                      ),
                    GestureDetector(
                      onTap: removeFunc,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: const Icon(
                          Icons.remove_circle_outline,
                          size: 15,
                          color: Color.fromARGB(255, 72, 5, 83),
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
    ;
  }
}
