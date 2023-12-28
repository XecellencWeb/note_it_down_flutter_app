import 'package:flutter/material.dart';
import 'package:task_manager_app/components/center_text.dart';
import 'package:task_manager_app/components/featured/one_individual.dart';
import 'package:task_manager_app/components/loader.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/graph_ql/queries.dart';
import '../../classes/index.dart';

class Requests extends StatefulWidget {
  final User? ownerInfo;
  const Requests({
    super.key,
    required this.ownerInfo,
  });

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final GraphQLQuery _graphQLQuery = GraphQLQuery();
  bool searching = false;
  List usersList = [];

  @override
  void initState() {
    super.initState();

    _loadRequestingUser();
  }

//loader function to load user requesting authorization
  void _loadRequestingUser() async {
    try {
      searching = true;
      usersList = await _graphQLQuery.getUserResquestingAuthorisation(
          id: widget.ownerInfo!.id);
      searching = false;
      setState(() {});
    } catch (error) {
      searching = false;
      setState(() {});
      print(error);
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: searching
            ? const SizedBox(
                height: 500,
                child: Loader(),
              )
            : usersList.isNotEmpty
                ? Column(
                    children: usersList
                        .map(
                          (user) => OneIndividual(
                            individual: user,
                            isOwnerId: widget.ownerInfo!.id,
                            page: REQUEST,
                          ),
                        )
                        .toList(),
                  )
                : const CenterText(text: 'No Authorization request available'),
      ),
    );
  }
}
