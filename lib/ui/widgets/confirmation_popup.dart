import 'package:flutter/material.dart';
import 'elred_button.dart';

Future<dynamic> buildConfirmationPopup(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 250,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: 115,
                  height: 6,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFCFCFCF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text(
                    'Changes Not Saved. Are you sure you want to go back?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF101010),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElRedButton(
                          text: 'Cancel',
                          invert: true,
                          onTap: Navigator.of(context).pop,
                        ),
                      ),
                      Expanded(
                        child: ElRedButton(
                          text: 'Ok',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
