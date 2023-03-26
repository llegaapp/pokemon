import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'constant_ds.dart';

class ApiConfig {

  static HttpLink httpLink = HttpLink(Cnstds.API_URL);

  static  ValueNotifier<GraphQLClient> graphInit() {
    final Link link = httpLink;
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      ),
    );
    return client;
  }

  GraphQLClient getGraphQLClient({required String apiUrl, accessToken = ''}) {
    var httpLink;
    httpLink = HttpLink(
      apiUrl,
      defaultHeaders: 
      {'appcode': Cnstds.KEY_HEADER_APP_CODE,
       'Authorization': '$accessToken'},
    );

    return GraphQLClient(cache: GraphQLCache(store: InMemoryStore(),),link: httpLink);
  }

}

