import 'package:first_app/views/book_car.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateFormCar extends StatefulWidget {
  @override
  _CreateCarState createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateFormCar> {
  String _make, _model, _description;
  int _quantity;

  GlobalKey<FormState> _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Add New Car"),
      // ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Image.asset(
                "assets/car-shadow.png",
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Make"),
                onSaved: (value) {
                  setState(() {
                    _make = value;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Model"),
                onSaved: (value) => {
                  setState(() {
                    _model = value;
                  })
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Description"),
                onSaved: (value) => {
                  setState(() {
                    _description = value;
                  })
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Quantity"),
                onSaved: (value) => {
                  setState(() {
                    _quantity = int.parse(value);
                  })
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  int q = int.tryParse(value);
                  if (q == null) {
                    return "Must be a number";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (!this._key.currentState.validate()) {
                        return;
                      }
                      _key.currentState.save();

                      Map<String, dynamic> carData = {
                        "make": _make,
                        "model": _model,
                        "description": _description,
                        "quantity": _quantity
                      };

                      Map<String, String> headers = {
                        'content-type': 'application/json; charset=UTF-8'
                      };

                      http
                          .post("http://localhost:9090/car",
                              headers: headers, body: json.encode(carData))
                          .then((http.Response value) {
                        print(value);
                        String res = value.statusCode == 201 ? "ok" : "error";
                        if (res == "ok") {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(" Dialog "),
                                  actions: [
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close Dialog'),
                                    )
                                  ],
                                  content: Text(
                                      "Model : $_model,\nMake: $_make,\nDescription: $_description,\nquantity: $_quantity"),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(" Error Dialog "),
                                  actions: [
                                    RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close Dialog'),
                                    )
                                  ],
                                  content: Text("An error has occured"),
                                );
                              });
                        }
                      });

                      print(
                          "Model : $_model, Make: $_make, Description: $_description, quantity: $_quantity");
                    },
                    child: Text("Add"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      this._key.currentState.reset();
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
