import 'package:flutter/material.dart';
import 'package:grade_calculator/model/lesson.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var formKey = GlobalKey<FormState>();
  int selectedCourseCredit = 1;
  double selectedCourseGrade = 4;
  double average = 0;
  int uniqID = 1;
  List<Lesson> createdLessons;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createdLessons = [
      Lesson("Matematik", 4, 1, Colors.red),
      Lesson("Matematik", 3, 1, Colors.orange)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grade Calculator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fact_check),
                      hintText: "Enter your score",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: selectedCourseCredit,
                            items: courseCredits(),
                            onChanged: (value) {
                              setState(() {
                                selectedCourseCredit = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            value: selectedCourseGrade,
                            items: courseGrades(),
                            onChanged: (value) {
                              setState(() {
                                selectedCourseGrade = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                      color: Colors.blue.shade500),
                  margin: EdgeInsets.only(top: 15),
                  height: 50,
                  child: Center(
                    child: average != 0
                        ? Text(
                            "Your average is : $average",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        : Text(
                            "Please enter your scores",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: createdLessons.length,
                itemBuilder: _myListBuilder,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("onPressed:floatingActionButton");
        },
        child: Icon(Icons.add),
        elevation: 12,
      ),
    );
  }

  courseCredits() {
    List<DropdownMenuItem<int>> data = [];
    for (int i = 1; i <= 10; i++) {
      data.add(
        DropdownMenuItem(
          value: i,
          child: Text("$i Credit"),
        ),
      );
    }
    return data;
  }

  courseGrades() {
    List<DropdownMenuItem<double>> data = [];
    var grades = [
      ["AA", 4],
      ["BA", 3.5],
      ["BB", 3],
      ["CB", 2.5],
      ["CC", 2],
      ["DC", 1.5],
      ["DD", 1],
      ["FF", 0]
    ];

    for (var item in grades) {
      data.add(
        DropdownMenuItem(
          child: Text(item[0]),
          value: double.parse(item[1].toString()),
        ),
      );
    }
    return data;
  }

  Widget _myListBuilder(BuildContext context, int index) {
    uniqID++;
    return Dismissible(
      key: Key(uniqID.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          createdLessons.removeAt(index);
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        elevation: 8,
        color: createdLessons[index].color,
        child: ListTile(
          title: Text(createdLessons[index].name),
          subtitle: Text(
              "Course credit: ${createdLessons[index].courseCredit.toString()}"),
          leading: CircleAvatar(
            child: Text(createdLessons[index].name[0]),
          ),
          trailing: Text(checkCourseGrade(createdLessons[index].courseGrade)),
        ),
      ),
    );
  }

  checkCourseGrade(grade) {
    var data = {
      4: "AA",
      3.5: "BA",
      3: "BB",
      2.5: "CB",
      2: "CC",
      1.5: "DC",
      1: "DD",
      0: "FF"
    };
    return data[grade];
  }
}
