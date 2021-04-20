import 'package:first_app/navigation_menus/bottom_navigation_ui.dart';
import 'package:first_app/navigation_menus/tabs_ui.dart';
import 'package:first_app/views/book_car.dart';
import 'package:first_app/views/car_list.dart';
import 'package:first_app/views/car_view.dart';
import 'package:first_app/entities/car.dart';
import 'package:first_app/views/create_car_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Application',
      debugShowCheckedModeBanner: false,
      // home: BookCar(),
      // home: CreateCar(),
      // home: CreateFormCar(),
      // home: TabsGui()
      // home: CarList()
      routes: {
        "/": (context) {
          return TabsGui();
        },
        "/book": (context) {
          return BookCar();
        },
        "/create": (context) {
          return CreateFormCar();
        },
        "/list": (context) {
          return CarList();
        },
        "/bottom": (context) {
          return BottomNavigationGui();
        }
      },
    );
  }
}
