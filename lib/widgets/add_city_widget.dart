import 'package:flutter/material.dart';
import 'package:weather/constants/routes.dart';

class AddCityWidget extends StatelessWidget {
  final VoidCallback? onReturn;
  const AddCityWidget({super.key, this.onReturn});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Color.fromARGB(255, 20, 20, 20),
            ),
            padding: const EdgeInsets.all(25),
            child: Center(child: Icon(Icons.add_circle, size: 64)),
          ),
          Positioned.fill(
            child: Material(
              borderRadius: BorderRadius.circular(32),
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, searchRoute).then((_) {
                    onReturn?.call();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
