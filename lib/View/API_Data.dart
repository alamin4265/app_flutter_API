import 'dart:convert';

import 'package:StudentInformation/Model/Photos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class APIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _APIPage();
  }
}

class _APIPage extends State<APIPage> {
  List<Photo> list = List();
  var isLoading = false;
  final _total = TextEditingController();
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => new Photo.fromJson(data))
          .take(int.parse(_total.text))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
              child: new Text("Fetch Data"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SimpleDialog(                      
                        children: <Widget>[
                          Center(
                            child:
                                Text('Write how many data do you want to fetch',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0)),
                          ),
                          SizedBox(height: 100),
                          TextFormField(                          
                            autofocus: true,
                            decoration: InputDecoration(hintText: '100',contentPadding: EdgeInsets.all(10.0) ),
                            controller: _total,
                            textInputAction: TextInputAction.go,
                          ),
                          FlatButton(
                              child: Text('Get Data'),
                              onPressed: () {
                                Navigator.pop(context);
                                _fetchData();                                         
                              }                              
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].title),
                    trailing: new Image.network(
                      list[index].thumbnailUrl,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }));
  }
}
