import 'package:flutter/material.dart';

class CreateCar extends StatefulWidget {
  @override
  _CreateCarState createState() => _CreateCarState();
}

class _CreateCarState extends State<CreateCar> {
  String _make, _model, _description;
  int _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Car"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Image.asset(
              "assets/car-shadow.png",
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Make"),
              onChanged: (value) {
                setState(() {
                  _make = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Model"),
                onChanged: (value) => {
                      setState(() {
                        _model = value;
                      })
                    }),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Description"),
              onChanged: (value) => {_description = value},
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Quantity"),
              onChanged: (value) => {
                setState(() {
                  _quantity = int.parse(value);
                })
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(" Dialog "),
                            content: Text(
                                "Model : $_model,\nMake: $_make,\nDescription: $_description,\nquantity: $_quantity"),
                          );
                        });
                    print(
                        "Model : $_model, Make: $_make, Description: $_description, quantity: $_quantity");
                  },
                  child: Text("Add"),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text("Cancel"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
