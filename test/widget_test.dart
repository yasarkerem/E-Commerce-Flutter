import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cs310_week5_app/Product.dart';

main(){

  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Create the Finders.
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });



  testWidgets('MyWidget has a very long title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'HVEWHVOIWHVOWHVOIWHVWIHVWIOHVA', message: 'MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF'));

    // Create the Finders.
    final titleFinder = find.text('HVEWHVOIWHVOWHVOIWHVWIHVWIOHVA');
    final messageFinder = find.text('MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });


  testWidgets('MyWidget does not have a title and but has a message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: '', message: 'MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF'));

    // Create the Finders.
    final titleFinder = find.text('');
    final messageFinder = find.text('MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('MyWidget does have a title and but does not have a message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF', message: ''));

    // Create the Finders.
    final titleFinder = find.text('MKSADOJPFIWEHOVLWDFWHVWOHVVUEVWIEHFQEPIFWHEFWŞOQHEHVŞHSHWŞF');
    final messageFinder = find.text('');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('MyWidget does have a title nor a message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: '', message: ''));

    // Create the Finders.
    final titleFinder = find.text('');
    final messageFinder = find.text('');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });


  testWidgets('finds a Text widget', (WidgetTester tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Find a widget that displays the letter 'H'.
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    const testKey = Key('K');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('finds a specific instance', (WidgetTester tester) async {
    const childWidget = Padding(padding: EdgeInsets.zero);

    // Provide the childWidget to the Container.
    await tester.pumpWidget(Container(child: childWidget));

    // Search for the childWidget in the tree and verify it exists.
    expect(find.byWidget(childWidget), findsOneWidget);
  });

  testWidgets('finds a widget using a Key', (WidgetTester tester) async {
    // Define the test key.
    const testKey = Key('A');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });
  testWidgets('MyWidget has a very long title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'Hello There', message: 'General Kenobi'));

    // Create the Finders.
    final titleFinder = find.text('Hello There');
    final messageFinder = find.text('General Kenobi');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(const TodoList());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    // Tap the add button.
    await tester.tap(find.byType(FloatingActionButton));

    // Rebuild the widget with the new item.
    await tester.pump();

    // Expect to find the item on screen.
    expect(find.text('hi'), findsOneWidget);

    // Swipe the item to dismiss it.
    await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));

    // Build the widget until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Ensure that the item is no longer on screen.
    expect(find.text('hi'), findsNothing);
  });

  testWidgets("A widget test",  (WidgetTester tester) async {
    await tester.pumpWidget(TodoList());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'This test works properly');
    expect(find.text('This test works properly'), findsOneWidget);
    print('This test works properly');
  });

  testWidgets("Another Widget Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'OWOFNWOFMWGPFPSVNWVNWLNFQPOEQP');
    expect(find.text('This test works properly'), findsOneWidget);
    print('This test should not properly, as it is planned by');
  });

  testWidgets("Widget Test",  (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, Hermonia);
    expect(find.text('Hermonia is the best e-commerce App'), findsOneWidget);
    print('This test should not properly, as it is planned by');
  });


  testWidgets('MyWidget has a very short title and but has a long, meaningful message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'What does the fox say', message: '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', ));

    // Create the Finders.
    final titleFinder = find.text('What does the fox say');
    final messageFinder = find.text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });


  testWidgets('MyWidget has a very long title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'Hello There', message: 'General Kenobi'));

    // Create the Finders.
    final titleFinder = find.text('Hello There');
    final messageFinder = find.text('General Kenobi');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });






}


class TodoList extends StatefulWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }


}

var Hermonia = "Hermonia is the best e-commerce App";

