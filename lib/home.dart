import 'package:flutter/material.dart';
import 'memo.dart';

class Activity {
  final IconData icon;
  final String title;
  final String start;
  final String end;

  Activity(this.icon, this.title, this.start, this.end);
}

class Weekday {
  final int value;
  final String day;

  Weekday(this.value, this.day);
}


class ActivityType {
  final int value;
  final IconData icon;

  ActivityType(this.value, this.icon);
}

List<List<Activity>> activitiesPerDay = [
  [], [], [], [], [], [], []
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int selectedDay = -1;

  int selectedIcon = -1;

  String activityTitle = "";

  List<Weekday> weekdayList = [
    Weekday(0, "Mon"),
    Weekday(1, "Tue"),
    Weekday(2, "Wed"),
    Weekday(3, "Thu"),
    Weekday(4, "Fri"),
    Weekday(5, "Sat"),
    Weekday(6, "Sun"),
  ];

  // Build activity types list
  List<ActivityType> activityList = [
    ActivityType(0, Icons.people),          // Meeting
    ActivityType(1, Icons.menu_book),       // Study
    ActivityType(2, Icons.work),            // Work
    ActivityType(3, Icons.restaurant),      // Food
    ActivityType(4, Icons.fitness_center),  // Exercise
  ];


  List<String> times = [
    "",
    "08:00 AM", "09:00 AM", "10:00 AM",
    "11:00 AM", "12:00 PM", "01:00 PM",
    "02:00 PM", "03:00 PM", "04:00 PM",
    "05:00 PM",
  ];

  String startTime = "";
  String endTime = "";

  void _openHome(BuildContext context) {}

  void _openMemos(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (c) => const MemosPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Activity", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [



          const SizedBox(height: 20),
          const Text(
            "Activity Title:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          TextField(
            decoration: const InputDecoration(
              hintText: "Enter a title or note",
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              setState(() {
                activityTitle = text;
              });
            },
          ),
          const SizedBox(height: 25),

          const Text(
            "Select a Day:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),





          const SizedBox(height: 25),


          // ⭐🤣 WEEKDAY RADIO ROW (generated from class)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekdayList.map((weekday) {
              return Row(
                children: [
                  Radio(
                    value: weekday.value,
                    groupValue: selectedDay,
                    onChanged: (value) {
                      setState(() {
                        selectedDay = value!;
                      });
                    },
                  ),
                  Text(weekday.day),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          // START TIME
          const Text(
            "Start Time:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          DropdownButton<String>(
            value: startTime,
            items: times.map((time) {
              return DropdownMenuItem(
                value: time,
                child: Text(time == "" ? "Select Start Time" : time),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                startTime = value!;
              });
            },
          ),

          const SizedBox(height: 25),

          // END TIME
          const Text(
            "End Time:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          DropdownButton<String>(
            value: endTime,
            items: times.map((time) {
              return DropdownMenuItem(
                value: time,
                child: Text(time == "" ? "Select End Time" : time),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                endTime = value!;
              });
            },
          ),

          const SizedBox(height: 35),

          // ACTIVITY TYPE (ICONS)
          const Text(
            "Select Activity Type:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // ⭐ ACTIVITY ICONS RADIO ROW (generated from class)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: activityList.map((activity) {
              return Column(
                children: [
                  Radio(
                    value: activity.value,
                    groupValue: selectedIcon,
                    onChanged: (value) {
                      setState(() {
                        selectedIcon = value!;
                      });
                    },
                  ),
                  Icon(activity.icon, size: 28),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 25),

          // CREATE ACTIVITY BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              if (selectedDay == -1 || selectedIcon == -1 || startTime == "" || endTime == "" || activityTitle == "") {
                showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                    title: Text("Missing Information"),
                    content: Text("Please fill all fields."),
                  ),
                );
                return;
              }

              Activity newActivity = Activity(
                activityList[selectedIcon].icon,
                activityTitle,
                startTime,
                endTime,
              );

              activitiesPerDay[selectedDay].add(newActivity);

              showDialog(
                context: context,
                builder: (c) => const AlertDialog(
                  title: Text("Success"),
                  content: Text("Activity Created!"),
                ),
              );
            },
            child: const Text(
              "Create Activity",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

        ],
      ),

      bottomNavigationBar: Container(
        height: 75,
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () => _openHome(context),
            ),
            IconButton(
              icon: const Icon(Icons.list, color: Colors.white),
              onPressed: () => _openMemos(context),
            ),
          ],
        ),
      ),
    );
  }
}
