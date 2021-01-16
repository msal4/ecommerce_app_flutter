import 'package:flutter/material.dart';

import '../constants.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
];

class ProfilePage extends StatelessWidget {
  final title = "PROFILE";
  final appBarColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: horizontalGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ABOUT US',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'lorem ipsum khaltaklorem ipsum khalt klorem ipsum khaltaklorem ipsum khaltak lorem ipsum khaltak lorem ipsum khaltak',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTACT US',
                textAlign: TextAlign.start,
                style: TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 25),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  Icons.phone,
                  color: secondaryColor,
                ),
                title: Text(
                  '+964 770 880 2238',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(Icons.mail, color: secondaryColor),
                title: Text(
                  'smart.resources@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
