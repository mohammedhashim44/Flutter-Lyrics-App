import 'package:flutter/material.dart';

class SongsSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0,
            ));
  }

  // This will be called when user press enter
  @override
  void showResults(BuildContext context) {
    super.showResults(context);
    Navigator.pop(context, query);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.trim().isEmpty) {
            Navigator.pop(context);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
