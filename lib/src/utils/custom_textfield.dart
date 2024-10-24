import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
      required this.icon,
      required this.hintText,
      required this.isPassword});

  final IconData icon;
  final String hintText;
  final bool isPassword;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool showText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          border: Border.all(color: Colors.grey)),
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                obscureText: showText,
                decoration: InputDecoration.collapsed(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            if (widget.isPassword)
              InkWell(
                onTap: () {
                  setState(() {
                    showText = !showText;
                  });
                },
                child: Icon(
                  !showText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }
}
