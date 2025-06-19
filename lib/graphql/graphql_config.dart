import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'http://192.168.1.16:4000/',
  );

  static GraphQLClient clientToQuery({String? token}) {
    Link link = httpLink;

    if (token != null) {
      link = AuthLink(getToken: () async => 'Bearer $token').concat(httpLink);
    }

    return GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}
