// // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DropdownButtons extends StatelessWidget {
  final String Sign;
  String initialValue;
  List<String> list;
  IconData icon;
  //final VoidCallback onTap;
  final ValueChanged<DropdownButtonModle> NewDropdownValue;
  //final ValueChanged<int> IndexValue;
  DropdownButtons({
    Key? key,
    required this.Sign,
    required this.initialValue,
    required this.list,
    required this.icon,
    required this.NewDropdownValue,
    //required this.IndexValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   return const Placeholder();

    // }

    // @override
    // Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width - 20,
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 1, color: Colors.black.withOpacity(0.4))
          // borderSide: BorderSide(width: 1),
          ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 27),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: initialValue,
            onChanged: (Object? value) {
              NewDropdownValue(DropdownButtonModle(
                  Sign: Sign,
                  NewValue: value.toString(),
                  IndexValue: list.indexOf(value.toString()) + 1));

              // IndexValue(list.indexOf(value.toString()) + 1);
            },
            // onChanged: (Object? value) {
            //   setState(() {
            //     NewValue = value.toString();
            //     IndexNewValue = list.indexOf(value.toString()) + 1;
            //   });
            // },
            selectedItemBuilder: (BuildContext context) {
              return list.map<Widget>((String item) {
                return Container(
                    alignment: Alignment.center,
                    //  color: Colors.amber,
                    width: width - 126,
                    child: Text(item, textAlign: TextAlign.start));
              }).toList();
            },
            items: list.map((String item) {
              return DropdownMenuItem<String>(
                alignment: Alignment.center,
                child: Text(item),
                value: item,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DropdownButtonModle {
  final String Sign;
  final String NewValue;
  final int IndexValue;

  DropdownButtonModle({
    required this.Sign,
    required this.NewValue,
    required this.IndexValue,
  });
}
