import 'package:flutter/material.dart';

class ListViewCustom extends StatelessWidget {
  final List<String> list;
  final List<Widget> actions;

  const ListViewCustom({super.key, required this.list, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.green.withOpacity(0.4), width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(list[index]), Row(children: actions)],
                )),
          );
        },
      ),
    ));
  }
}
