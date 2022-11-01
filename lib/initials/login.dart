import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/initials/HomePage.dart';
import 'package:login/initials/mainScreen.dart';
import 'package:login/manager/sectionManagement.dart';
import 'package:login/models/modelPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static const snackBar = SnackBar(
    content: Text('Login Scuessfully'),
  );
  bool isClick = true;
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  String username = '';
  String password = '';
  void initState() {
    setState(() {
      isClick = !isClick;
    });
  }

  Future<Login?> submitData(String username, String password) async {
    String basicAuth = base64Encode('$username:$password'.codeUnits);
    var response = await http.post(
        Uri.parse('https://api.kyc365pro.com:6113/login'),
        headers: <String, String>{
          'authorization': 'basic $basicAuth'
        },
        body: {
          "username": username,
          "password": password,
        });
    var data = response.body;

    print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Login.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<bool> _navigatetohome() async {
    Login? response =
        await submitData(usernameController.text, passwordController.text);
    SessionManager preferences = SessionManager();
    if (response != null) {
      await preferences.setAuthToken(response.token.toString());
      //  Navigator.pushReplacement(
      //      context, MaterialPageRoute(builder: (context) => HomePage()));
      return true;
    } else {
      return false;
    }
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.setString("username", username);
    // await preferences.setString("password", password);
    // Navigator.pushReplacement(
    //   context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              height: MediaQuery.of(context).size.height / 4,
              child: const Image(image: AssetImage("assets/logo.png")),
            ),
            Text("Staff Application",
                style: GoogleFonts.shadowsIntoLight(
                    fontSize: 33, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    child: const Divider(
                      color: Colors.pink,
                      thickness: 2,
                    ),
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 25, color: Colors.pink),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Container(
                    child: const Divider(
                      color: Colors.pink,
                      thickness: 2,
                    ),
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 232, 230, 230),
                      child: FormBuilderTextField(
                        name: "User Name",
                        controller: usernameController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9]*$')),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please enter phone number'),
                          FormBuilderValidators.minLength(10,
                              errorText: 'Please enter valid phone number'),
                          FormBuilderValidators.maxLength(10,
                              errorText: 'Please enter valid phone number')
                        ]),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            prefixIcon: const Icon(Icons.person_rounded),
                            prefixIconColor: Colors.blue,
                            hintText: "Enter Your Number",
                            labelText: "User Name"),
                        onChanged: (newValue) {
                          setState(() {
                            username = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: const Color.fromARGB(255, 232, 230, 230),
                      child: FormBuilderTextField(
                        name: "Password",
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: !isClick,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Please enter  name'),
                          FormBuilderValidators.minLength(4,
                              errorText: 'Please enter valid  name'),
                          FormBuilderValidators.maxLength(20,
                              errorText: 'Please enter valid name')
                        ]),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: Colors.blue,
                            hintText: "Enter Your Password",
                            labelText: "Password"),
                        onChanged: (newValue) {
                          setState(() {
                            password = newValue.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderCheckbox(
                            activeColor: Colors.pink,
                            name: "checkbox",
                            title: const Text(
                              "Show Password",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            initialValue: false,
                            onChanged: (isClick) {
                              setState(() {
                                initState();
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Forget Password ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 242, 91, 141)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // print("login1");
                        formKey.currentState!.save();
                        if (formKey.currentState!.validate()) {
                          // print("login2");
                          username = formKey.currentState!.value['User Name']
                              .toString();
                          password = formKey.currentState!.value['Password']
                              .toString();
                          await _navigatetohome().then((value) {
                            // ignore: void_checks
                            // print(value);
                            if (value == true) {
                              _displaySnackBar(
                                  context, "Logged in sucessfully !!!");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            } else {
                              _displaySnackBar(
                                  context, " Invalid Credentials...");
                            }
                          });
                          // Login? response =
                          //   await submitData(username, password);
                          // submitData(username, password);
                          //String token = response!.token;
                          //   print(response!.token.toString());
                        } else {}
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(110, 10, 110, 10),
                        child: Text(
                          'LOGIN ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    const Center(child: Text("www.kyc365pro.com"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
