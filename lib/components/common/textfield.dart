import 'package:flutter/material.dart';
import 'package:memory_mate/const.dart';

// ignore: must_be_immutable
class Mytextfield extends StatelessWidget {
  Mytextfield(
      {super.key,
      required this.name,
      required this.fieldicon,
      this.password = false,
      this.onchanged,
      this.maxliness = 1});
  int maxliness;
  String name;
  IconData fieldicon;
  bool password;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        maxLines: maxliness,
        validator: (data) {
          if (data?.isEmpty ?? true) {
            return 'Required';
          }
          return null;
        },
        onChanged: onchanged,
        obscureText: password,
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenHeight * 0.03),
          prefixIcon: Icon(
            fieldicon,
            color: KPrimaryColor.withOpacity(0.7),
            size: screenHeight * 0.04,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              width: 5,
              color: KPrimaryColor.withOpacity(0.5),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: KPrimaryColor.withOpacity(0.7),
            ),
          ),
        ),
        style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.03),
      ),
    );
  }
}
