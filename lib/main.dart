import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Flutter Tutorial';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Steps(),
      ),
    );
  }
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);

  String title;
  Widget body;
  bool isExpanded;

}

Future<List<Step>> getSteps() async {
  var _items = [
    Step('Step 0: Install Flutter', ListView(
      children: [
        Text("lklkj1"),
      ],
    )),
    Step('Step 1: Create a project', ListView(
      children: [
        Text("lklkj1"),
      ],
    )),
    Step('Step 2: Run the app', ListView(
      children: [
        Text("lklkj1"),
      ],
    )),
  ];
  return Future<List<Step>>.delayed(const Duration(seconds: 2), () => _items);
}

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder<List<Step>>(
            future: getSteps(),
            builder: (BuildContext context, AsyncSnapshot<List<Step>> snapshot) {
              if(snapshot.hasData) {
                return StepList(steps: snapshot.data ?? []);
              }
              else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
        ),
      ),
    );
  }
}

class StepList extends StatefulWidget {
  final List<Step> steps;
  const StepList({Key? key, required this.steps}) : super(key: key);
  @override
  State<StepList> createState() => _StepListState(steps: steps);
}

class _StepListState extends State<StepList> {
  final List<Step> _steps;
  _StepListState({required List<Step> steps}) : _steps = steps;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        print("lkajdlkajd ${isExpanded}");
        setState(() {
          _steps[index].isExpanded = !isExpanded==false?true:false;
          print("dlkajsdlka ${_steps[index].isExpanded}");
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        print("lksjdlks ${step.isExpanded}");
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: step.body,
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}