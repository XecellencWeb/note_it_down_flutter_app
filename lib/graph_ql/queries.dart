import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/graph_ql/config.dart';

class GraphQLQuery {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  //User Queries

  Future<User> getUser({required String name, required String password}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
      query getUsers(\$name: String!, \$password: String!){
        getUser(name: \$name, password: \$password) {
          _id,
          name,
          title,
          picture,
          gender,
          numberOfTaskCreared
        }
      }"""),
          variables: {
            "name": name,
            "password": password,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      User res = User.fromMap(map: result.data!['getUser']);

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List> getAuthorisedUser({required id}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
      query getAuthorisedUser(\$id: ID!){
        getAuthorisedUsers(_id: \$id) {
          _id,
          name,
          title,
        }
      }"""),
          variables: {"id": id},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List res = result.data!['getAuthorisedUsers']
          .map((user) => User.fromMap(map: user))
          .toList();

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List> getUserResquestingAuthorisation({required id}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
      query getUserResquestingAuthorisation(\$id: ID!){
        getUserResquestingAuthorisation(_id: \$id) {
          _id,
          name,
          title,
        }
      }"""),
          variables: {"id": id},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List res = result.data!['getUserResquestingAuthorisation']
          .map((user) => User.fromMap(map: user))
          .toList();

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List> getUserSearch({required String searchString}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
      query getUserSearch(\$searchString: String!){
        getUserSearch(searchString: \$searchString) {
          _id,
          name,
          title,
          picture
        }
      }"""),
          variables: {
            "searchString": searchString,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      print(result.data!['getUserSearch']);
      List res = result.data!['getUserSearch']
          .map((user) => User.fromMap(map: user))
          .toList();

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  //Task Queries

  Future<List> getTasks({required String createdBy}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
      query getTasks(\$createdBy: ID!){
        getTasks(createdBy: \$createdBy) {
          _id,
          name,
          description,
          tasks {
            name,
            description,
            picture
          }
        }
      }"""),
          variables: {
            "createdBy": createdBy,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List res = result.data!['getTasks']
          .map((task) => Task.fromMap(map: task))
          .toList();

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }
}
