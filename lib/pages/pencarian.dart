import 'package:api_cuaca/pages/hasil_pencarian.dart';
import 'package:flutter/material.dart';

class Pencarian extends StatelessWidget {
  const Pencarian({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController placeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Data Cuaca",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pencarian",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              TextFormField(
                controller: placeController,
                decoration: const InputDecoration(
                  hintText: "Cari",
                  icon: const Icon(Icons.search),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HasilPencarian(
                          place: placeController.text,
                        ),
                      ));
                  print(placeController.text);
                },
                child: const Text("Cari"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
