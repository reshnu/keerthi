import 'package:chmm_carpool/Emergency/emergencyScreen.dart';
import 'package:flutter/material.dart';
import 'giveaRide.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  // Bottom navigation bar
  int _currentIndex = 0;

  void onTabTapped(int index) {
    if (index == 1) Navigator.pushNamed(context, '/findaride');
    if (index == 2) Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Emergency Situation'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: const <Widget>[
                              Text('Are you sure?.'),
                              Text(
                                  'Your location will be shared with the local police station and emergency contacts.'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'I Am in Emergency',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Emergency()));
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "I am Safe",
                                style: TextStyle(color: Colors.green),
                              ))
                        ],
                      );
                    });
              },
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "SOS",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Center(
                        child: Icon(
                      Icons.warning_amber,
                      size: 15,
                    )),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Center(child: Text("Car Pool")),
        ),
      ),
      body: FindaRide(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bike), label: "ShareRide"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "FindRide"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: "Profile"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
