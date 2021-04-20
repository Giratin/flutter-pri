import 'package:first_app/views/book_car.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarView extends StatelessWidget {
  final String id;
  final String image;
  final String marque;
  final String modele;

  CarView(this.image, {this.marque, this.modele, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("carId", this.id);

        Navigator.pushNamed(context, "/book");
        // Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        //   return BookCar();
        // }));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Image.network(
                this.image,
                width: 150,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(this.marque),
                  Text(this.modele),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
