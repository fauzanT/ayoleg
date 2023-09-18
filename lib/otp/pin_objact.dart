
import 'package:ayoleg/component/colors/colors.dart';
import 'package:flutter/material.dart';

class PinCodeTextField extends StatelessWidget {
  final TextEditingController? controller;

  const PinCodeTextField({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.5,
      height: size.height * 0.09,
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: TextFormField(
          obscureText: true,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0) {
              FocusScope.of(context).previousFocus();
            }
          },
          maxLength: 1,
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            //  fillColor: Colors.white,
            counterText: "",
//              border: InputBorder.none
            // border: new OutlineInputBorder(
            // borderRadius: const BorderRadius.all(
            //   const Radius.circular(15.0),
            // ))
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: greenPrimary),
                borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return null;
            }

            return null;
          },
        ),
      ),
    );
  }
}
