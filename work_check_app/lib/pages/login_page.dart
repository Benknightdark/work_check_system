import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:work_check_app/pages/register_page.dart';
import 'package:work_check_app/view_models/login_view_model.dart';
import 'package:work_check_app/view_models/register_view_model.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    var userNameController =
        TextEditingController(text: vm.loginModel.userName);
    var passwordController =
        TextEditingController(text: vm.loginModel.password);

    return Scaffold(
      appBar: AppBar(
        title: Text('登入'),
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
                      "https://media.giphy.com/media/hSyloQofR3lRt4qSYs/giphy.gif",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          child: Text("登入"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () {
                            (() async {
                              vm.loginModel.password = passwordController.text;
                              vm.loginModel.userName = userNameController.text;
                              EasyLoading.show(status: '登入中');

                              var resData = await vm.login();
                              if (resData) {
                                Navigator.of(context).pop(resData);
                              }
                            })();
                          },
                        ),
                        MaterialButton(
                          child: Text("重設"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.deepOrangeAccent)),
                          onPressed: () {
                            passwordController.text = "";
                            userNameController.text = "";
                            vm.loginModel.password = passwordController.text;
                            vm.loginModel.userName = userNameController.text;
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '忘記密碼',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        child: Text("新使用者請註冊帳號"),
                        onTap: () {
                          print("value of your text");
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => Provider(
                                create: (context) => RegisterViewModel(),
                                builder: (context, child) => RegisterPage(),
                              ),
                            ),
                          )
                              .then((value) {
                            if (value != null) {
                              Navigator.of(context).pop(value);
                            }
                          });
                        },
                      ),
                    )
                  ]),
                ),
              )
            ]),
      ),
    );
  }
}
