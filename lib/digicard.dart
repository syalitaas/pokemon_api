import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class digicard extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const digicard({super.key});
  Future<List<dynamic>> _fecthListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            maxRadius: 35,
                            backgroundImage: NetworkImage(
                              snapshot.data[index]['img'].toString(),
                            ),
                          ),
                          title: Text(
                            snapshot.data[index]['name'].toString(),
                          ),
                          subtitle: Text(
                            snapshot.data[index]['level'].toString(),
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
