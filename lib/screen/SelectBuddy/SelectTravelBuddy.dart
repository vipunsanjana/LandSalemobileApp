import 'package:flutter/material.dart';
//import 'package:travelup/data/PersonData.dart';
//import 'package:travelup/widget/PersonTileCard/PersonTileCard.dart';


class SelectTravelBuddy extends StatefulWidget {
  const SelectTravelBuddy({Key? key}) : super(key: key);

  @override
  _SelectTravelBuddyState createState() => _SelectTravelBuddyState();
}

class _SelectTravelBuddyState extends State<SelectTravelBuddy> {
  String searchQuery = ""; // Store the search query

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop(); // Go back when pressed
            },
          ),
          title: const Text('Select a Travel Buddy'),
          titleTextStyle: const TextStyle(
              fontFamily: 'inter', fontSize: 16, color: Colors.black),
          actions: [
            IconButton(
              onPressed: () {
                //filter function
              },
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search travel buddies",
                  fillColor: Colors.lightGreen.shade100,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.lightGreen,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            // This is the ListView builder that generates the list of PersonTileCard
            // Expanded(
            //   // Expanded to allow the list to take the rest of the space
            //   child: ListView.builder(
            //     itemCount: personData.length,
            //     itemBuilder: (context, index) {
            //       final person = personData[index];
            //
            //       // Check if the name matches the search query (case-insensitive)
            //       if (person['name']
            //           .toLowerCase()
            //           .contains(searchQuery.toLowerCase()) ||
            //           searchQuery.isEmpty) {
            //         // Display the PersonTileCard if it matches or if there's no query
            //         return PersonTileCard(
            //           name: person['name'],
            //           rating: person['rating'],
            //           rank: person['rank'],
            //           location: person['location'],
            //           price: person['price'],
            //           online: person['online'],
            //         );
            //       } else {
            //         // If no match, return an empty widget
            //         return const SizedBox.shrink();
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}