import 'package:flutter/material.dart';
import 'package:task_manager_app/components/center_text.dart';
import 'package:task_manager_app/graph_ql/queries.dart';
import '../featured/one_individual.dart';

class AuthorizedIndividuals extends StatefulWidget {
  final String? userId;
  const AuthorizedIndividuals({super.key, required this.userId});

  @override
  State<AuthorizedIndividuals> createState() => _AuthorizedIndividualsState();
}

class _AuthorizedIndividualsState extends State<AuthorizedIndividuals> {
  final GraphQLQuery _graphQLQuery = GraphQLQuery();

  @override
  void initState() {
    super.initState();

    loadAuthorised();
  }

  List usersList = [];

  void loadAuthorised() async {
    try {
      usersList = await _graphQLQuery.getAuthorisedUser(id: widget.userId);
      setState(() {});
    } catch (error) {
      print(error);
      setState(() {});
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: usersList.isNotEmpty
            ? Column(
                children: usersList
                    .map(
                      (user) => OneIndividual(
                        individual: user,
                        isOwnerId: widget.userId,
                      ),
                    )
                    .toList(),
              )
            : const CenterText(
                text: 'No User yet Authorised',
              ),
      ),
    );
  }
}
