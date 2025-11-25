import 'package:flutter/material.dart';
import 'home.dart';   // to access activitiesPerDay and weekdays

class MemosPage extends StatefulWidget {
  const MemosPage({super.key});

  @override
  State<MemosPage> createState() => _MemosPageState();
}

class _MemosPageState extends State<MemosPage> {

  // weekdays list (same order as activitiesPerDay)
  List<String> weekdays = [
    "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday", "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memo List"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ⭐ BLUE BUBBLE WITH DAY NAME
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6, horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    weekdays[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ⭐ ACTIVITIES OF THIS DAY
                ...activitiesPerDay[index].map((act) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(act.icon, size: 26),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            "${act.title}   ${act.start} - ${act.end}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // ⭐ If no activities
                // if (activitiesPerDay[index].isEmpty)
                //   const Text(
                //     "No activities",
                //     style: TextStyle(color: Colors.black54),
                //   ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
        height: 75,
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.list, color: Colors.white),
              onPressed: () {},  // already here
            ),
          ],
        ),
      ),
    );
  }
}
