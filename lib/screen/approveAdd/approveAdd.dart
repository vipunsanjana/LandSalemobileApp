import 'dart:convert';
import 'package:ecomm/screen/adminHome/adminHome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApproveAdd extends StatefulWidget {
  const ApproveAdd({Key? key, required this.userId, required this.token}) : super(key: key);

  final String userId;
  final String token;

  @override
  _ApproveAddState createState() => _ApproveAddState(userId: userId,token: token);
}

class _ApproveAddState extends State<ApproveAdd> {

  final String userId;
  final String token;

  _ApproveAddState({required this.userId, required this.token}); // No need for another constructor


  List<dynamic> approvedAdds = [];
  bool isLoading = true;
  int _selectedIndex = 0;



  // Index for the selected bottom navigation bar item

  @override
  void initState() {
    super.initState();
    fetchApprovedAdds();
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }



  Future<void> fetchApprovedAdds() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3002/api/admin/get-all-adds'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          approvedAdds = responseData['data'];
          isLoading = false;
        });
        print(userId);
        print(userId);
        print(userId);

      } else {
        print('Failed to load data: ${response.statusCode}');
        // Handle error cases here
      }
    } catch (error) {
      print('Error fetching data: $error');
      // Handle error cases here
    }
  }

  Future<void> approveAdd(String addId) async {

    print(addId);
    print(addId);
    print(addId);
    print(addId);

    try {
      final response = await http.put(Uri.parse('http://localhost:3002/api/admin/approve-add/$addId'),
        headers: {
          'Authorization': 'Bearer $token', // Attach the token to the request
          'Content-Type': 'application/json',
        }
      ); // Replace with your actual API endpoint


      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print('Add approved successfully');
          showSnackBar(context, 'Add approved successfully');
           // Indicate successful approval
        } else {
          print('Failed to approve add: ${responseData['message']}');
           // Indicate approval failure
        }
      } else {
        print('Failed to approve add: ${response.statusCode}');
        // Indicate API error
      }
    } catch (error) {
      print('Error approving add: $error');// Indicate network or other errors
    }
  }




  Future<void> deleteAdd(String addId) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3002/api/admin/delete-add/$addId'),
        headers: {
          'Authorization': 'Bearer $token', // Attach the token to the request
          'Content-Type': 'application/json',
        },); // Replace with your actual API endpoint

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print('Add deleted successfully');

          showSnackBar(context, 'Add deleted successfully');

          // Indicate successful deletion
        } else {
          print('Failed to delete add: ${responseData['message']}');
           // Indicate deletion failure
        }
      } else {
        print('Failed to delete add: ${response.statusCode}');
        // Indicate API error
      }
    } catch (error) {
      print('Error deleting add: $error');
      // Indicate network or other errors
    }
  }
  // Index for the selected bottom navigation bar item


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve Adds'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => AdminHome(userId: widget.userId, token: widget.token,),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: approvedAdds.length,
        itemBuilder: (context, index) {
          final add = approvedAdds[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(add['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(add['description']),
                  Text('Price: \$${add['price']}'),
                  SizedBox(height: 5,),
                  Text('Add Id: \$${add['id']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      // Handle approve action
                      approveAdd(add['id']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action
                      deleteAdd(add['id']);
                    },
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }
}
