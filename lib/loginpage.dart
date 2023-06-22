import 'package:VeteBacin/password_resetpage.dart';
import 'package:VeteBacin/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:VeteBacin/helper/colorpalatte.dart';
import 'package:VeteBacin/helper/azureApiHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/chat_api.dart';
import 'chat_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();

  final ColorPalette colors = ColorPalette();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool _obscureText = true;
  bool _isLoading = false;


  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }




  @override
  Widget build(BuildContext context) {


    return WillPopScope(

        onWillPop: () async => false,
      child:Scaffold(
        resizeToAvoidBottomInset:false,
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 16.0),
        ),
        centerTitle: true,
        leading: null,
        toolbarHeight: 60.0,
         backgroundColor: colors.primaryAppBar,
        ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/39loginbg22.png'), // Set your background image here
            fit: BoxFit.cover,
          ),
        ),
         child: Center(

          child: Form(

            key: _formKey,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Container(
                  width: 95.0,
                  height: 95.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/vetebacinlogo.png'),
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                 ),
                const SizedBox(height: 12.0),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(text: 'VeteB',),
                      TextSpan(
                        text: 'a',
                        style: TextStyle(
                          color: colors.primaryNeon,
                        ),
                      ),
                      TextSpan(text: 'c',),
                      TextSpan(
                        text: 'i',
                        style: TextStyle(
                          color: colors.primaryNeon,
                        ),
                      ),
                      TextSpan(text: 'n'),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: colors.primaryInputs,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'Emri i përdoruesit',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.person_outlined,
                        color: Color(0xFFFFFFFF),
                        size: 24.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ju lutem shkruani adresën tuaj të emailit';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email.text = value!;
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: colors.primaryInputs,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white30),
                    labelText: 'Fjalëkalimin',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFFFFFFFF),
                        size: 24.0,
                      ),
                      onPressed: _toggle,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ju lutem shkruani fjalëkalimin tuaj';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password.text = value!;
                  },
                ),
              ),
                const SizedBox(height: 12.0),

                Container(
                  child: !_isLoading
                      ? ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading=true;
                        });

                        final response = await _databaseHelper.login(_email.text, _password.text);
                        if (response == true) {
                          // Login successful
                          SharedPreferences.getInstance().then((prefs) {
                            setState(() {
                              prefs.setBool('isLoggedIn', true);
                            });
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(chatApi: ChatApi())));
                          setState(() {
                            _isLoading=false;
                          });
                        } else {
                          // Login failed
                          Fluttertoast.showToast(
                              msg: 'Email or Password incorrect.',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 10.0
                          );
                          setState(() {
                            _isLoading=false;
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: colors.primaryNeon,
                      foregroundColor: colors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.login, color: Colors.black87),
                        SizedBox(width: 8.0),
                        Text('Dërgo', style: TextStyle(color: Colors.black87)),
                      ],
                    ),
                  )
                      :
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(119, 212, 0, 1))),
                      ),
                  ),


                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => RegisterPage(),
                        transitionDuration: Duration(milliseconds: 200),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );
                  },
                  child: const Text(
                    'Për tu regjistruar',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),






                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ResetPasswordPage(),
                        transitionDuration: Duration(milliseconds: 200),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );
                  },
                  child: const Text(
                    'Password reset',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
