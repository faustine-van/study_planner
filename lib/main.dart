
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // LOGIC: store study goals
  List<Map<String, dynamic>> goalsList = [
    {"subject": "Math", "hours": 8, "done": true},
    {"subject": "Mobile application","hours": 8, "done": false},
    {"subject": "DCF", "hours": 8, "done": false},
    {"subject": "Statistics", "hours": 8, "done": false},
  ];

  int sum(){
    return goalsList.fold(0, (sum, goal) => sum + (goal['hours'] as int));
  }
  int count(bool value){
    return goalsList.where((goal) => goal['done'] == value).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STATIC: appbar with title heading
      appBar: AppBar(
        title: const Text('My Study Planner'),
        elevation: 8.0,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      // STATIC: body with list of goals
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Add summary rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                      
                        children: [
                          Text('Total hours'),
                          Text(sum().toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Completed goals"),
                          Text(count(true).toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Remaining goals"),
                          Text(count(false).toString()),
                        ],
                      ),
                    ),
                  ),
                ),
            
              ],
            ),

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
                          // CONNECTION: checkbox triggers the toggle function
                          Checkbox(
                            value: goalsList[index]["done"] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                // LOGIC: toggle goal as done
                                goalsList[index]["done"] = value ?? false;
                              });
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                // LOGIC: delete a study goal
                                goalsList.removeAt(index);
                              });
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

      // CONNECTION: button triggers the add function
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // LOGIC: add a new samples study goal
            goalsList.add({
              "subject": "New Subject",
              "hours": "8 hours",
              "done": false,
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
