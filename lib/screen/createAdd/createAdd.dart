import 'dart:convert';
import 'package:ecomm/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

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
  String? _imageUrl;

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

  Future<void> pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageUrl = pickedFile.path!;
        });
      } else {
        showSnackBar(context, 'No image selected.');
      }
    } catch (error) {
      print('Error picking image: $error');
      showSnackBar(context, 'An error occurred while picking an image.');
    }
  }

  // Future<void> createAdd() async {
  //   try {
  //     final imagePicker = ImagePicker();
  //     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
  //
  //     if (pickedFile != null) {
  //       final url = Uri.parse('http://localhost:3002/api/user/create-add/$userId');
  //       final request = http.MultipartRequest('POST', url);
  //       Uint8List bytes = await pickedFile.readAsBytes(); // Read file as bytes
  //       Stream<List<int>> stream = Stream.fromIterable([bytes]); // Create a stream from bytes
  //       request.files.add(http.MultipartFile('image', stream, bytes.length, filename: pickedFile.name));
  //
  //
  //       request.fields['name'] = nameController.text;
  //       request.fields['description'] = descriptionController.text;
  //       request.fields['price'] = priceController.text;
  //       request.fields['from'] = fromController.text;
  //
  //       final response = await request.send();
  //
  //       print(response);
  //       print(response.statusCode);
  //       if (response.statusCode == 200) {
  //         final responseData = await response.stream.bytesToString();
  //         final String adId = jsonDecode(responseData)['id'];
  //         print('Success to create ad: ${response.statusCode}');
  //
  //         showSnackBar(context, 'Ad created successfully');
  //       } else {
  //         if (response.statusCode >= 400) {
  //           print('Error creating add');
  //           showSnackBar(context, 'Failed to create ad. Check server logs for details.');
  //         } else {
  //           print('Failed to create ad: ${response.statusCode}');
  //           showSnackBar(context, 'Failed to create ad. Network error.');
  //         }
  //       }
  //     } else {
  //       showSnackBar(context, 'No image selected.');
  //     }
  //   } catch (error) {
  //     print('Error creating ad: $error');
  //     showSnackBar(context, 'An error occurred while creating ad.');
  //   }
  // }






  Future<void> createAdd() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3002/api/user/create-add/$userId'), // Replace with your API URL and user ID
        headers: {
          'Authorization': 'Bearer $token', // Attach the token to the request
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameController.text,
          'description': descriptionController.text,
          'price': priceController.text,
          'from': fromController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Ad created successfully
        final responseData = jsonDecode(response.body);
        final String adId = responseData['id'];
        print('Success to create ad: ${response.statusCode}');

        showSnackBar(context, 'Ad created successfully');
        // Handle successful creation, such as showing a success message or navigating to a new page
      } else {
        // Handle creation failure
        print('Failed to create ad: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error creating ad: $error');
    }
  }





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
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 95,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile == null
                      ? Image.asset("asset/icon/IslandHomesLogo.png", fit: BoxFit.cover)
                      : Image.file(File(_imageFile!.path), fit: BoxFit.cover),

                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: createAdd,
                child: Text('Create Add'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
