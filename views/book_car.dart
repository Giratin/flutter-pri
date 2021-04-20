import 'package:first_app/entities/car.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BookCar extends StatefulWidget {
  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {
  Car car;
  String _baseImageUrl = "http://localhost:9090/img/";
  Future<bool> carFetched;
  SharedPreferences prefs;

  Future<bool> fetchCar() async {
    prefs = await SharedPreferences.getInstance();
    http.Response response =
        await http.get("http://localhost:9090/car/" + prefs.getString("carId"));
    Map<String, dynamic> carFromServer = json.decode(response.body);
    car = Car(
        id: carFromServer["_id"],
        make: carFromServer["make"],
        model: carFromServer["model"],
        image: carFromServer["image"],
        description: carFromServer["description"],
        quantity: carFromServer["quantity"]);

    return true;
  }

  @override
  void initState() {
    super.initState();
    // print("id is " + this.widget.id);
    carFetched = fetchCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book a car")),
      body: FutureBuilder(
        future: carFetched,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(_baseImageUrl + car.image),
                SizedBox(height: 10),
                Text("Model : " + car.make + " " + car.model),
                SizedBox(height: 10),
                Text("Description :"),
                Text(car.description),
                SizedBox(height: 10),
                Text("Quantity : " + car.quantity.toString()),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Book this car"),
                    onPressed: () {
                      http
                          .patch("http://localhost:9090/car/" +
                              prefs.getString("carId"))
                          .then((http.Response response) {
                        http
                            .get("http://localhost:9090/car/" +
                                prefs.getString("carId"))
                            .then((http.Response response2) {
                          Map<String, dynamic> carFromServer =
                              json.decode(response2.body);
                          car = Car(
                              id: carFromServer["_id"],
                              make: carFromServer["make"],
                              model: carFromServer["model"],
                              image: carFromServer["image"],
                              description: carFromServer["description"],
                              quantity: carFromServer["quantity"]);
                          setState(() {});
                        });
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add car to favorites"),
        onPressed: null,
      ),
    );
  }
}
