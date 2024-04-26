import 'dart:convert';
import 'package:ecomm/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';

class CreateAddPage extends StatefulWidget {
  const CreateAddPage({Key? key, required  this.userId,required  this.token}) : super(key: key);

  final String userId;
  final String token;

  @override
  _CreateAddPageState createState() => _CreateAddPageState( userId: userId, token :token);
}

class _CreateAddPageState extends State<CreateAddPage> {

  final String userId;
  final String token;
  XFile? _imageFile;
  _CreateAddPageState({required this.userId,required  this.token});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController fromController = TextEditingController();


  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> createAdd() async {
    try {
      var imagePicker = ImagePicker();
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://10.0.2.2:3002/api/user/create-add/$userId'),
        );
        request.headers['Authorization'] = 'Bearer $token';

        request.fields['name'] = nameController.text;
        request.fields['description'] = descriptionController.text;
        request.fields['price'] = priceController.text;
        request.fields['from'] = fromController.text;

        var file = await http.MultipartFile.fromPath('image', pickedFile.path);
        request.files.add(file);

        var response = await request.send();

        if (response.statusCode == 200) {
          // Ad created successfully
          final responseData = await response.stream.bytesToString();
          final String adId = jsonDecode(responseData)['id'];
          print('Success to create ad: ${response.statusCode}');

          showSnackBar(context, 'Ad created successfully');
          // Handle successful creation, such as showing a success message or navigating to a new page
        } else {
          // Handle creation failure
          print('Failed to create ad: ${response.statusCode}');
        }
      } else {
        // No image selected
      }
    } catch (error) {
      // Handle error
      print('Error creating ad: $error');
    }
  }







  // Future<void> createAdd() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://10.0.2.2:3002/api/user/create-add/$userId'), // Replace with your API URL and user ID
  //       headers: {
  //         'Authorization': 'Bearer $token', // Attach the token to the request
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'name': nameController.text,
  //         'description': descriptionController.text,
  //         'price': priceController.text,
  //         'from': fromController.text,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Ad created successfully
  //       final responseData = jsonDecode(response.body);
  //       final String adId = responseData['id'];
  //       print('Success to create ad: ${response.statusCode}');
  //
  //       showSnackBar(context, 'Ad created successfully');
  //       // Handle successful creation, such as showing a success message or navigating to a new page
  //     } else {
  //       // Handle creation failure
  //       print('Failed to create ad: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     // Handle error
  //     print('Error creating ad: $error');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Add'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>  Home(userId: userId, token: widget.token,))); // Navigate back to the previous screen
            });
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () async {
                var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile = pickedFile;
                });
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _imageFile == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : Image.file(File(_imageFile!.path), fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: createAdd,
              child: Text('Create Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
