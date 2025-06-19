import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_config.dart';

class AuthService {
  static Future<String?> login(String email, String password) async {
    final client = GraphQLConfig.clientToQuery();

    const String loginQuery = r'''
      mutation Login($email: String!, $password: String!) {
        login(email: $email, password: $password)
      }
    ''';

    final result = await client.mutate(MutationOptions(
      document: gql(loginQuery),
      variables: {
        'email': email,
        'password': password,
      },
    ));

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    return result.data?['login']; // return JWT
  }

  static Future<bool> register(String username, String email, String password) async {
    final client = GraphQLConfig.clientToQuery();

    const String registerMutation = r'''
      mutation Register($username: String!, $email: String!, $password: String!) {
        register(username: $username, email: $email, password: $password)
      }
    ''';

    final result = await client.mutate(MutationOptions(
      document: gql(registerMutation),
      variables: {
        'username': username,
        'email': email,
        'password': password,
      },
    ));

    if (result.hasException) {
      print(result.exception.toString());
      return false;
    }

    return true;
  }
}
