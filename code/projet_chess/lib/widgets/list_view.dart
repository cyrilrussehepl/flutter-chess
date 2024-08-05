import 'package:flutter/material.dart';

class ListViewCustom extends StatelessWidget {
  final List<String> list;

  const ListViewCustom({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index]),
          );
        },
      ),
    );
  }
}
