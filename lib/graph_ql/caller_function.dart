//caller function

Future callGraphql(
    {required bool loadingIndicator, required Function graphQlFunction}) async {
  loadingIndicator = true;

  dynamic result = await graphQlFunction();

  loadingIndicator = false;
  return result;
}
