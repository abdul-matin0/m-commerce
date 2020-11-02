import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  CustomBtn({this.text, this.onPressed, this.outlineBtn, this.isLoading});

  // text?? "value";  // - means if text is null assign "value" to it
  @override
  Widget build(BuildContext context) {

    bool _outlineBtn = outlineBtn ?? false; // if outlineBtn is null, assign false to variable

    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),

        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),

        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,

              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: _outlineBtn ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),

            Visibility(
              visible: _isLoading ? true : false,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
