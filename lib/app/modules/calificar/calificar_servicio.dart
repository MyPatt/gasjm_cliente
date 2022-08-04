import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CalificarServicio extends StatefulWidget {
  @override
  _CalificarServicioState createState() => _CalificarServicioState();
}

class _CalificarServicioState extends State<CalificarServicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: ElevatedButton(
          child: Text('Rating Dialog',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              elevation: 5,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              padding: EdgeInsets.all(12)),
          onPressed: showRatingDialog,
        ),
      ),
    ));
  }

  void showRatingDialog() {
    final ratingDialog = RatingDialog(
        starColor: Colors.amber,
        title: const Text("Calificar servicio"),
        message: const Text(
            "If you enjoy using this app, would you mind taking a moment to rate it? Thank you for your support!"),
        submitButtonText: 'Submit',
        // ignore: avoid_print
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          // ignore: avoid_print
          print('rating: ${response.rating}, comment: ${response.comment}');
         
        });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ratingDialog,
    );
  }
}
