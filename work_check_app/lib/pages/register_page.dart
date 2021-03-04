import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:work_check_app/models/register.dart';
import 'package:work_check_app/pages/dashboard_page.dart';
import 'package:work_check_app/view_models/dashboard_view_model.dart';
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
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
                child: FormBuilder(
                  key: _fbKey,
                  child: Column(children: <Widget>[
                    Image.network(
                      "https://media.giphy.com/media/2NaoYKJHNAw8XYgGP7/giphy.gif",
                      fit: BoxFit.cover,
                    ),
                    //
                    FormBuilderTextField(
                      name: "userName",
                      decoration: InputDecoration(labelText: "帳號"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "欄位不能為空值"),
                      ]),
                    ),
                    FormBuilderTextField(
                      obscureText: true,
                      name: "password",
                      decoration: InputDecoration(labelText: "密碼"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "欄位不能為空值"),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: "displayName",
                      decoration: InputDecoration(labelText: "顯示名稱"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "欄位不能為空值"),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: "email",
                      decoration: InputDecoration(labelText: "Email"),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: "欄位不能為空值"),
                        FormBuilderValidators.email(context,
                            errorText: "請填寫正確的Email"),
                      ]),
                    ),
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
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                              vm?.register =
                                  Register.fromJson(_fbKey.currentState.value);
                              var resData = await vm?.registerUser();
                              if (resData != null) {
                                Navigator.of(context).pop(resData);
                                // Navigator.pushAndRemoveUntil(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) => Provider(
                                //       create: (context) => DashboardViewModel(),
                                //       builder: (context, child) =>
                                //           DashboardPage(),
                                //     ),
                                //   ),
                                //   (Route<dynamic> route) => false,
                                // );
                              }
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("重設"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.deepOrangeAccent)),
                          onPressed: () {
                            _fbKey.currentState.reset();
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
