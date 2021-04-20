import 'package:first_app/navigation_menus/tabs_ui.dart';
import 'package:first_app/views/car_list.dart';
import 'package:first_app/views/create_car_form.dart';
import 'package:flutter/material.dart';

class BottomNavigationGui extends StatefulWidget {
  @override
  _BottomNavigationGuiState createState() => _BottomNavigationGuiState();
}

class _BottomNavigationGuiState extends State<BottomNavigationGui> {
  int _currentIndex = 0;
  List<Widget> widgets = [CarList(), CreateFormCar()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bottom Navigation Gui"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Choose an option"),
            ),
            ListTile(
              title: Text("Go to tab navigation"),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //   builder: (context) {
                //     return new TabsGui();
                //   },
                // ));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Car list")),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text("Create New Car")),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      body: widgets[_currentIndex],
    );
  }
}
