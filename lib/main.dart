import 'package:flutter/material.dart';

void main() {
  List loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua".split(" ");
  List people = ["Ivan", "Ihor", "Maria", "Roman", "Anthony", "Olga", "Illya", "Alexandra", "Mikita"];
  int x = 0;
  
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(
        items: List<ListItem>.generate(
        8, (i) => i % 6 == 0
            ? HeadingItem('Section $i')
            : MessageItem(people[i], loremIpsum[x++] + " " + loremIpsum[x++]),
        ),
      ),
    },
  ));
}

class SecondRoute extends StatelessWidget {
  final Widget data;

  SecondRoute({ required this.data });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: Colors.green,
      ),
      body: Center (
        child: data
      )
    );
  }
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  const MyApp({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Tap to any chat';

    return MaterialApp (
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute (
                    builder: (context) => SecondRoute(data: item.buildSubtitle(context))
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);  
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}