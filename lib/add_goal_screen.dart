import 'package:material_ui/material_ui.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});


  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _subjectController = TextEditingController();
  final _hoursController = TextEditingController();

  final _subjectFocusNode = FocusNode();
  final _hoursFocusNode = FocusNode();

  bool _showSubjectError = false;
bool _showHoursError = false;

  @override
  void initState() {
  super.initState();

  _subjectFocusNode.addListener(() {
    setState(() {});
  });

  _hoursFocusNode.addListener(() {
    setState(() {});
  });
}


  bool get _isInputValid {
  return _errorSubject == null && _errorHours == null;
}
  String? get _errorSubject {
  final text = _subjectController .value.text;
  if (text.isEmpty) {
    return 'subject must not be empty';
  }
  return null;
}
String? get _errorHours {
  final num = int.tryParse(_hoursController.value.text);
  if(num == null || num <= 0) {
    return 'hours must be a number greater than 0';
  }
  return null;
}

  @override
  void dispose() {
    _subjectController.dispose();
    _hoursController.dispose();

  _subjectFocusNode.dispose();
  _hoursFocusNode.dispose();
    super.dispose();
  }

   
void _saveGoal() {
  setState(() {
    _showSubjectError = true;
    _showHoursError = true;
  });

  if (_isInputValid) {
    Navigator.pop(context, {
      "subject": _subjectController.text.trim(),
      "hours": int.parse(_hoursController.text),
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add a goal")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: TextField(
              controller: _subjectController,
              keyboardType: TextInputType.text,
                        onSubmitted: (_) =>  _saveGoal(),
              focusNode: _subjectFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter subject',
            errorText: _showSubjectError ? _errorSubject : null,                
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(height: 16),

          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            
            child: TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
               
              onSubmitted: (_) =>  _saveGoal(),
              focusNode: _hoursFocusNode,
              decoration: InputDecoration(
              hintText: 'Enter hours',
              errorText: _showHoursError ? _errorHours : null,                
            ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: _saveGoal,
            child: Text('Add goal'),

          ),
        ],
      ),
    );
  }
}