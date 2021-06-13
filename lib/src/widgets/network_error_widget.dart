import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lottie/lottie.dart';

class NetworkErrorWidget extends StatelessWidget {
  final Function onRetryClicked;

  const NetworkErrorWidget({ this.onRetryClicked}) :
      assert(onRetryClicked != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: FlareActor(
                "assets/flare_animations/network_error.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "no_network",
              ),
            ),
            Opacity(
              opacity: 0.8,
              child: Text(
                "Error :(",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 10,),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Text("Try Again"),
              onPressed: () {
                onRetryClicked.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
