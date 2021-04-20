import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:work_check_app/models/register.dart';

import 'package:work_check_app/view_models/register_view_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RegisterViewModel>(context);
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var displayNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('註冊'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Column(children: <Widget>[
                    Image.network(
                      "https://media.giphy.com/media/2NaoYKJHNAw8XYgGP7/giphy.gif",
                      fit: BoxFit.cover,
                    ),
                    TextFormField(
                      autofocus: true,
                      controller: userNameController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        focusColor: Colors.black,
                        labelText: "帳號",
                      ),
                    ),
                    TextFormField(
                        autofocus: true,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          focusColor: Colors.black,
                          labelText: "密碼",
                        )),
                    //
                    TextFormField(
                      autofocus: true,
                      controller: displayNameController,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        focusColor: Colors.black,
                        labelText: "顯示名稱",
                      ),
                    ),
                    TextFormField(
                        autofocus: true,
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          focusColor: Colors.black,
                          labelText: "email",
                        )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          child: Text("註冊"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () async {
                            Map<String, dynamic> dd = {};
                            dd["userName"] = userNameController.text;
                            dd["password"] = passwordController.text;
                            dd["displayName"] = displayNameController.text;
                            dd["email"] = emailController.text;
                            vm.register = Register.fromJson(dd);
                            var resData = await vm.registerUser();
                            if (resData != null) {
                              Navigator.of(context).pop(resData);
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("重設"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.deepOrangeAccent)),
                          onPressed: () {
                            userNameController.text = "";
                            passwordController.text = "";
                            displayNameController.text = "";
                            emailController.text = "";
                            Map<String, dynamic> dd = {};
                            dd["userName"] = userNameController.text;
                            dd["password"] = passwordController.text;
                            dd["displayName"] = displayNameController.text;
                            dd["email"] = emailController.text;
                            vm.register = Register.fromJson(dd);
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}
