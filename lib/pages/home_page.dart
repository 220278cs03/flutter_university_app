import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/repository/get_informatioon_repository.dart';

import '../model/university_model.dart';
import 'add_country.dart';

class HomePage extends StatefulWidget {
  final String country;
  const HomePage({Key? key, this.country = 'Uzbekistan'}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetInformationRepository api = GetInformationRepository();
  bool isLoading = true;

  List<University> listOfUni = [];

  Future<void> getInformation() async {
    isLoading = true;
    setState(() {});
    dynamic data = await api.getInformation(name: widget.country);
    data.forEach((element){
      listOfUni.add(University.fromJson(element));
    });
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Universities"),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) :
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: listOfUni.length,
              itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(top:16),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.lightBlue
              ),
              child: Column(
                children: [
                  Text(listOfUni[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 32,),
                  TextButton(onPressed: () async {
                    final launchUrl = Uri.parse(listOfUni[index].web_pages?[0]??"");
                    await url_launcher.launchUrl(launchUrl, mode: LaunchMode.externalApplication);
                  }, child: Text(listOfUni[index].web_pages?[0]??"", style: TextStyle(color: Colors.white),)),
                  SizedBox(
                    height: 32,
                  ),
                  TextButton(onPressed: () async {
                    final launchUrl = Uri(scheme: 'sms', path: '+998990504377');
                    await url_launcher.launchUrl(launchUrl);
                  }, child: Text('sms', style: TextStyle(color: Colors.white),)),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddCountry()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
