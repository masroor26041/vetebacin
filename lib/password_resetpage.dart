import 'package:VeteBacin/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:VeteBacin/helper/colorpalatte.dart';
import 'package:VeteBacin/helper/azureApiHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _birthday=TextEditingController();
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

        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Reset Password',
            style: TextStyle(fontSize: 16.0),
          ),
          centerTitle: true,
          toolbarHeight: 60.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },

          ),
          backgroundColor:colors.primaryAppBar,

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
                      controller: _birthday,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white30),
                        labelText: 'Birthday',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {

                      },
                      onSaved: (value) {
                        _birthday.text = value!;
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

                          final response = await _databaseHelper.resetPassword(_email.text, _birthday.text ,_password.text);
                          if (response == true) {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                          Text('Reset Password', style: TextStyle(color: Colors.black87)),
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
