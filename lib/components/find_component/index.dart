import 'package:flutter/material.dart';
import 'package:task_manager_app/components/featured/one_individual.dart';
import 'package:task_manager_app/components/loader.dart';
import 'package:task_manager_app/constants/names.dart';
import 'package:task_manager_app/graph_ql/queries.dart';
import '../../classes/index.dart';

class FindComponent extends StatefulWidget {
  final User? userInfo;
  const FindComponent({super.key, required this.userInfo});

  @override
  State<FindComponent> createState() => _FindComponentState();
}

class _FindComponentState extends State<FindComponent> {
  final GraphQLQuery _graphQLQuery = GraphQLQuery();
  final TextEditingController _searchString = TextEditingController();
  bool searching = false;

  List usersList = [];

  void _searchRequestedUser() async {
    setState(() {
      
    searching = true;
    });
    try {
      usersList =
          await _graphQLQuery.getUserSearch(searchString: _searchString.text);

      print(usersList);

      setState(() {
        searching = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        searching = false;
      });
      throw Exception(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: _searchString,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        label: Container(
                          padding: const EdgeInsets.all(20),
                          child: const Text('Search User'),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _searchRequestedUser,
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: !searching
                    ? Column(
                        children: usersList
                            .map(
                              (user) => OneIndividual(
                                individual: user,
                                isOwnerId: widget.userInfo!.id,
                                page: FIND,
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(
                        height: 300,
                        child: Loader(),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
