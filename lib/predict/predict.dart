import 'package:ecomm/screen/home/home.dart';
import 'package:flutter/material.dart';

class PredictPage extends StatefulWidget {
  final String userId;
  final String token;

  const PredictPage({Key? key, required this.userId, required this.token}) : super(key: key);

  @override
  _PredictPageState createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController fromController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predict Add'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>  Home(userId: widget.userId, token: widget.token,))); // Navigate back to the previous screen
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 13),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: fromController,
              decoration: InputDecoration(labelText: 'From'),
            ),
            SizedBox(height: 13),
            ElevatedButton(
              onPressed: (){},
              child: Text('Predict Add'),
            ),
          ],
        ),
      ),
    );
  }


}
