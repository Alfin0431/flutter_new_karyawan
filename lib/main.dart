import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/karyawan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //// TAMBAHAN (hilangkan banner debug)
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<List<Karyawan>> _readJsonData() async {
    final String response = await rootBundle.loadString('assets/karyawan.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Karyawan.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3, //// TAMBAHAN
        centerTitle: true, //// TAMBAHAN
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "DAFTAR KARYAWAN",
          style: TextStyle(
            fontWeight: FontWeight.bold, //// TAMBAHAN
            color: Colors.white, //// TAMBAHAN
          ),
        ),
      ),
      body: FutureBuilder<List<Karyawan>>(
        future: _readJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12), //// TAMBAHAN
              itemCount: data.length,
              itemBuilder: (context, index) {
                final karyawan = data[index];

                return Card(
                  //// TAMBAHAN (bungkus dengan Card)
                  elevation: 4, //// TAMBAHAN
                  margin: const EdgeInsets.only(bottom: 12), //// TAMBAHAN
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), //// TAMBAHAN
                  ),
                  child: Padding(
                    //// TAMBAHAN
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      //// TAMBAHAN
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          //// TAMBAHAN (avatar inisial)
                          radius: 28,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            karyawan.nama[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16), //// TAMBAHAN
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                karyawan.nama,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6), //// TAMBAHAN
                              Text(
                                'Umur : ${karyawan.umur}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 6), //// TAMBAHAN
                              Text(
                                'Alamat : ${karyawan.alamat.jalan}, ${karyawan.alamat.kota}, ${karyawan.alamat.provinsi}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Hobi : ${karyawan.hobi.join(", ")}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 10), //// TAMBAHAN
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan:\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
