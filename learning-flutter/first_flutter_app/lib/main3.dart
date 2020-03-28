import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Manage',
      home: LoginForm()
    );
  }
}

class LoginForm extends StatefulWidget {

  @override
  State createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person)
                ),
                validator: (v){
                  return v.trim().length > 0? null:"用户名不能唯恐";
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (v){
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: (){
                          if ((_formKey.currentState as FormState).validate()){
                            print("login in ${_usernameController.text}:${_passwordController.text}");
                          }
                        },
                      ),
                    )
                  ],
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}