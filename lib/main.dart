import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: appbar with title heading
      appBar: AppBar(
        title: const Text('My Study Planner'),
        elevation: 8.0,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        backgroundColor: Colors.blue, // Or Color(0xFF673AB7)
      foregroundColor: Colors.white, 
        ),
      // STATIC: body with list of goals
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // STATIC: title
            const Text(
              'My Goals',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Divider(height: 0),

            const SizedBox(height: 16),
            // STATIC: list of goals
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Math'),
                      subtitle: const Text('8 hours'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          IconButton(
                            onPressed: () {
                              debugPrint('Deleted');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Mobile application'),
                      subtitle: const Text('8 hours'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          IconButton(
                            onPressed: () {
                              debugPrint('Deleted');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      title: const Text('DCF'),
                      subtitle: const Text('8 hours'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          IconButton(
                            onPressed: () {
                              debugPrint('Deleted');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Statistics'),
                      subtitle: const Text('8 hours'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          IconButton(
                            onPressed: () {
                              debugPrint('Deleted');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // STATIC: floating action button to add goal
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
