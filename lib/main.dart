import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

void main() => runApp(BarberApp());

class BarberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarberHomePage(),
    );
  }
}

class BarberHomePage extends StatefulWidget {
  @override
  _BarberHomePageState createState() => _BarberHomePageState();
}

class _BarberHomePageState extends State<BarberHomePage> {
  List<dynamic> barbershops = [];

  @override
  void initState() {
    super.initState();
    loadBarbershops();
  }

  void loadBarbershops() {
    String jsonData = '''
    [
      {
        "title": "Alana Barbershop – Haircut massage & Spa",
        "distance": "Banguntapan (5km)",
        "rating": 4.5,
        "imageUrl": "assets/foto3.jpeg"
      },
      {
        "title": "Hercha Barbershop – Haircut & Styling",
        "distance": "Jalan Kaliurang (8km)",
        "rating": 5.0,
        "imageUrl": "assets/foto4.jpeg"
      },
      {
        "title": "Barberking – Haircut styling & massage",
        "distance": "Jogia Expo Centre (12km)",
        "rating": 4.5,
        "imageUrl": "assets/foto5.jpeg"
      },
      {
        "title": "Master piece Barbershop – Haircut styling",
        "distance": "Joga Expo Centre (2km)",
        "rating": 5.0,
        "imageUrl": "assets/foto2.png",
        "isHighlighted": true
      },
      {
        "title": "Varcity Barbershop Jogja ex The Varcher",
        "distance": "Condongcatur (10km)",
        "rating": 4.5,
        "imageUrl": "assets/foto6.jpeg"
      },
      {
        "title": "Twinsky Monkey Barber & Men Stuff",
        "distance": "Jl Taman Siswa (8km)",
        "rating": 5.0,
        "imageUrl": "assets/foto7.jpeg"
      },
      {
        "title": "Barberman – Haircut styling & massage",
        "distance": "J-Walk Centre (17km)",
        "rating": 4.5,
        "imageUrl": "assets/foto9.jpeg"
      }
    ]
    ''';


    setState(() {
      barbershops = json.decode(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(CupertinoIcons.location, color: Colors.grey[600]),
            SizedBox(width: 8),
            Text(
              "yokohama",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/photop.jpg"),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "Joe Samanta",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            Text(
              "Nearest Barbershop",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: barbershops.length,
                itemBuilder: (context, index) {
                  var barbershop = barbershops[index];
                  return barbershopCard(
                    context: context,
                    title: barbershop["title"],
                    distance: barbershop["distance"],
                    rating: barbershop["rating"].toDouble(),
                    imageUrl: barbershop["imageUrl"],
                    isHighlighted: barbershop["isHighlighted"] ?? false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget barbershopCard({
    required BuildContext context,
    required String title,
    required String distance,
    required double rating,
    required String imageUrl,
    bool isHighlighted = false,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHighlighted)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.orange,
                    child: Text(
                      "Most Recommended",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          else
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 30,
              ),
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(distance),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.star, color: Colors.amber),
                  Text(rating.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
