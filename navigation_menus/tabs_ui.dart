import 'package:first_app/navigation_menus/bottom_navigation_ui.dart';
import 'package:first_app/views/car_list.dart';
import 'package:first_app/views/create_car_form.dart';
import 'package:flutter/material.dart';

class TabsGui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Menu with tabs"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: "Car List",
              ),
              Tab(
                icon: Icon(Icons.edit),
                text: "Add Car",
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              AppBar(
                title: Text("Choose An Option"),
              ),
              ListTile(
                title: Text("Go To Bottom Navigation"),
                onTap: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return new BottomNavigationGui();
                  //   },
                  // ));
                  Navigator.pushReplacementNamed(context, "/bottom");
                },
              ),
              ListTile(
                title: Text("Second one"),
                onTap: () {},
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [CarList(), CreateFormCar()],
        ),
      ),
    );
  }
}
