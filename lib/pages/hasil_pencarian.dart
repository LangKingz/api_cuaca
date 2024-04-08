import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HasilPencarian extends StatelessWidget {
  final String place;
  const HasilPencarian({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> getDataFromAPI() async {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${place}&appid=0c216bcb093b1d2d64f20c9870092b4f&units=metric"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return data;
      } else {
        throw Exception("Error !!");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Hasil Pencarian",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.navigate_before, color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: getDataFromAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: NetworkImage(
                              'https://flagsapi.com/${data["sys"]["country"]}/shiny/64.png')),
                      Text(
                        data["name"],
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data["weather"][0]["description"],
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${data["main"]["temp"]}°C",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Humidity: ${data["main"]["humidity"]}%",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text("Gak Ada");
            }
          },
        ),
      ),
    );
  }
}
