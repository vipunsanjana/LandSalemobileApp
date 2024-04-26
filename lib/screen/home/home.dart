import 'dart:convert';
import 'package:ecomm/screen/createAdd/createAdd.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm/screen/profile/profile.dart'; // Import the Profile screen



class Home extends StatefulWidget {
  const Home({Key? key, required this.userId, required this.token}) : super(key: key);

  final String userId;
  final String token;

  @override
  _HomeState createState() => _HomeState(userId: userId,token: token); // Pass userId here
}

class _HomeState extends State<Home> {
  final String userId;
  final String token;

  _HomeState({required this.userId, required this.token}); // No need for another constructor

  List<dynamic> approvedAdds = [];
  bool isLoading = true;
  int _selectedIndex = 0;

// ... rest of your code



  // Index for the selected bottom navigation bar item

  @override
  void initState() {
    super.initState();
    fetchApprovedAdds();
  }

  Future<void> fetchApprovedAdds() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3002/api/user/get-approved-adds'));
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

  // Function to handle bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Navigate to other screens based on index
      switch (index) {
        case 0:
        // Navigate to the Home screen
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
          break;
        case 1:
        // Navigate to the Profile screen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateAddPage(userId: userId, token: token)));
          break;

          case 2:
        // Navigate to the Profile screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(userId: userId, token: token),
              ),
            );
          break;
      // Add cases for other screens if needed
      }
    });
  }

  // Function to navigate to the details page of a selected ad
  void _navigateToAdDetails(dynamic ad) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdDetailsPage(ad: ad),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Ads'),

      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : approvedAdds.isEmpty
          ? Center(child: Text('No approved ads found'))
          : ListView.builder(
        itemCount: approvedAdds.length,
        itemBuilder: (context, index) {
          final add = approvedAdds[index];
          return GestureDetector(
            onTap: () => _navigateToAdDetails(add),
            child: Card(
              elevation: 4, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Add rounded corners
              ),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add margin
              child: ListTile(
                contentPadding: EdgeInsets.all(16), // Add padding for content
                title: Text(
                  add['name'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8), // Add space between title and subtitle
                    Text(
                      add['description'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8), // Add space between description and price
                    Text(
                      'Price: \$${add['price'] ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                // Add more details to display if needed
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Home',
          ), BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Create Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          // Add more BottomNavigationBarItems for other screens if needed
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AdDetailsPage extends StatelessWidget {
  final dynamic ad;

  const AdDetailsPage({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.lightGreenAccent, // Set your desired background color here
            padding: EdgeInsets.all(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ad['name'] ?? '',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  ad['description'] ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Price: \$${ad['price'] ?? ''}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Add more details to display if needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}