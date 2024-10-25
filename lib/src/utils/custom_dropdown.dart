import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final List<UserModel> options;
  final UserModel? initialValue;
  final UserModel? Function(UserModel?)? onChanged;

  const CustomDropdownFormField(
      {super.key, required this.options, this.initialValue, this.onChanged});
  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  UserModel? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<UserModel>(
      value: widget.initialValue ?? widget.initialValue,
      hint: const Text('Select a mechanic'),
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null) {
          return 'Please select a mechanic to assign to the job';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Mechanics',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (UserModel? newValue) {
        widget.onChanged!(newValue);
        setState(() {
          selectedValue = newValue;
        });
      },
      items: widget.options.map<DropdownMenuItem<UserModel>>((UserModel value) {
        return DropdownMenuItem<UserModel>(
          value: value,
          child: Text(value.name!),
        );
      }).toList(),
    );
  }
}
