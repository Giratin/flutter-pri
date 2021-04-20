import 'package:first_app/entities/car.dart';
import 'package:first_app/views/car_view.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<Car> _cars = [];
  String _baseImageUrl = "http://localhost:9090/img/";

  Future<bool> fetchedCars;

  Future<bool> getCars() async {
    http.Response response = await http.get('http://localhost:9090/car');
    List<dynamic> carsFromServer = json.decode(response.body);
    print("server responded");

    if (carsFromServer.length > 0) {
      for (int i = 0; i < carsFromServer.length; i++) {
        _cars.add(Car(
            id: carsFromServer[i]["_id"],
            make: carsFromServer[i]["make"],
            model: carsFromServer[i]["model"],
            image: _baseImageUrl + carsFromServer[i]["image"]));
      }
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedCars = getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Cars Agency"),
      // ),
      body: FutureBuilder(
        future: fetchedCars,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _cars.length,
              itemBuilder: (BuildContext context, int index) {
                return CarView(
                  _cars[index].image,
                  marque: _cars[index].make,
                  modele: _cars[index].model,
                  id: _cars[index].id,
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
