import 'package:flutter/material.dart';

class StudentCard extends StatefulWidget {
  static String tag = 'StudentCardPage';
  @override
  State<StatefulWidget> createState() {
    return _StudentCard();
  }
}

class _StudentCard extends State<StudentCard> {
  final formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Student')),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (input) => _name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (input) =>
                      !input.contains('@') ? 'Not a Valid Email' : null,
                  onSaved: (input) => _email = input,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (input) =>
                      input.length < 5 ? 'You need at least 5 digit' : null,
                  onSaved: (input) => _password = input,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Text('Sign in'),
                        onPressed: submit,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('Name = ' + _name + ' Email = ' + _email + _password);
    }
  }
}

//-----------------------------
