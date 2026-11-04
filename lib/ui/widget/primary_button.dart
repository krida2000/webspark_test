import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.onPressed, required this.title});

  final void Function()? onPressed;

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(18),
      ),
      onPressed: onPressed,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(title),
        ),
      ),
    );
  }
}
