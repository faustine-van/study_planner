import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:study_planner/add_goal_screen.dart';
import 'package:study_planner/firebase_options.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> goalsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  Future<void> loadGoals() async {
    final goals = await getGoals();

    if (!mounted) return;

    setState(() {
      goalsList = goals;
      isLoading = false;
    });
  }

  int sum() {
    return goalsList.fold(0, (sum, goal) => sum + (goal['hours'] as int));
  }

  int count(bool value) {
    return goalsList.where((goal) => goal['done'] == value).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Study Planner'),
        elevation: 8.0,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardStatistics(title: "Total hours", data: sum()),
                CardStatistics(title: "Completed goals", data: count(true)),
                CardStatistics(title: "Remaining goals", data: count(false)),
              ],
            ),

            const Text(
              'My Goals',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Divider(height: 0),

            const SizedBox(height: 16),
            if (isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (goalsList.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("List is empty. Add your first goal"),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: goalsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(goalsList[index]["subject"]),
                        subtitle: Text(goalsList[index]["hours"].toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (goalsList[index]["done"] == true)
                              const Badge(
                                label: Text("Done"),
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              ),
                            const SizedBox(width: 4),
                            Checkbox(
                              value: goalsList[index]["done"] ?? false,
                              onChanged: (bool? value) async {
                                await updateGoal(
                                  goalsList[index]['id'],
                                  value ?? false,
                                );
                                await loadGoals();
                              },
                            ),
                            IconButton(
                              onPressed: () async {
                                await deleteGoal(goalsList[index]['id']);
                                await loadGoals();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalScreen()),
          );
          if (result != null) {
            await insertGoal(result);
            await loadGoals();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CardStatistics extends StatelessWidget {
  final String title;
  final int data;
  const CardStatistics({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(title), Divider(height: 2), Text(data.toString())],
          ),
        ),
      ),
    );
  }
}
