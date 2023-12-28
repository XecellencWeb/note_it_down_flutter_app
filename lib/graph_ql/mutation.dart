import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/graph_ql/config.dart';

class GraphQLMutation {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  //User Mutations

  Future<User> createUser({required Map user}) async {
    try {
      QueryResult result = await client.mutate(
          MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql("""
                mutation createUser(\$user: UsersInput!){
                createUser(user: \$user) {
                  _id,
                  name,
                  title,
                  picture,
                  numberOfTaskCreared,
                  gender
                }
              }
              """), variables: {"user": user}));

      if (result.hasException) {
        throw Exception(result.exception);
      }

      User res = User.fromMap(map: result.data!['createUser']);

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<User> updateUser({required withWhat, required id}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(fetchPolicy: FetchPolicy.noCache, document: gql("""
               mutation updateUser(\$with: UsersInput!, \$updateUserId: String!){
                updateUser(_with: \$with, id: \$updateUserId) {
                  _id,
                  name,
                  title,
                  picture,
                  gender,
                  numberOfTaskCreared
                }
              }
              """), variables: {"with": withWhat, "updateUserId": id}),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      User res = User.fromMap(map: result.data!['updateUser']);

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> requestUserAuthorizing(
      {required Map user, required authorisedBy}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
               mutation requestUserAuthorizing(\$user: UsersInput!, \$authorisedBy: ID!){
                  requestUserAuthorizing(user: \$user, authorisedBy: \$authorisedBy)
                }
              """),
          variables: {
            "user": user,
            "authorisedBy": authorisedBy,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      String res = result.data!['requestUserAuthorizing'];

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> cancelRequestUserAuthorizing(
      {required User user, required authurisedBy}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
               mutation CancelUserAuthorising(\$user: UsersInput!, \$authorisedBy: ID!){
                  cancelRequestUserAuthorizing(user: \$user, authorisedBy: \$authorisedBy)
                }
              """),
          variables: {
            "user": user,
            "authorisedBy": authurisedBy,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      String res = result.data!['cancelRequestUserAuthorizing'];

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> authorizeUser(
      {required userId, required authorisingId}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
               mutation authoriseUser(\$userId: ID!, \$authorisingId: ID!){
                authorizeUser(userId: \$userId, authorisingId: \$authorisingId)
}
              """),
          variables: {
            "userId": userId,
            "authorisingId": authorisingId,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      String res = result.data!['authorizeUser'];

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  //Task Mutations

  Future<Task> createTasks({required Map task, required userId}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
                  mutation createTask(\$task: TasksInput!, \$userId: String!){
                    createTask(task: \$task, userId: \$userId) {
                      _id,
                      name,
                      description,
                      tasks {
                        name,
                        description,
                        picture
                      }
                    }
                  }
        """),
          variables: {"task": task, "userId": userId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      Task res = Task.fromMap(map: result.data!['createTasks']);

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<Task> updateTask({required Map task, required taskId}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
                      mutation updateTask(\$taskId: ID!, \$task: TasksInput!){
                        updateTask(taskId: \$taskId, task: \$task) {
                          _id,
                          name,
                          description,
                          tasks {
                            name,
                            description,
                            picture
                          }
                        }
                      }
        """),
          variables: {
            "taskId": taskId,
            "task": task,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      Task res = Task.fromMap(map: result.data!['updateTask']);

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> deleteTask({required taskId}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
                    mutation deleteTask(\$taskId: ID!){
                      deleteTask(taskId: \$taskId)
                    }
                    """),
          variables: {
            "taskId": taskId,
          },
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      String res =  result.data!['deleteTask'];

      return res;
    } catch (error) {
      throw Exception(error);
    }
  }
}
