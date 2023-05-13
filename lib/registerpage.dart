import 'package:VeteBacin/usersAgreement.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'helper/azureApiHelper.dart';
import 'helper/colorpalatte.dart';
import 'loginpage.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';


 class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum CivilStatus { yes, no, defaultNothing }

CivilStatus? _civilStatus = CivilStatus.defaultNothing;
class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final ColorPalette colors = ColorPalette();



  bool _obscureText = true;
  bool _isLoading = false;



  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }



  ///Define Controller
  //FORMSFIELDS

  final TextEditingController _email=TextEditingController();
  final TextEditingController _vorname=TextEditingController();
  final TextEditingController _nachname=TextEditingController();
  final TextEditingController _alter = TextEditingController();
  final TextEditingController _verheiratet=TextEditingController();
  final TextEditingController _password=TextEditingController();

  late String _countryValue='';
  late String _stateValue='';
  late String _cityValue='';
  bool _usersagrrementIsChecked = false;

  String validateCheckbox(bool? value) {
    if (value == false) {
      return 'Please accept the terms and conditions to continue';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
        onWillPop: () async => false,
    child:Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text(
          'Për tu regjistruar',
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/39loginbg22.png'), // Set your background image here
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40.0),

          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(

            key: _formKey,
            child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [


                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'E-mail*',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 24.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                      final RegExp regex = RegExp(emailPattern);
                      if (value!.isEmpty) {
                        return 'Ju lutem shkruani adresën tuaj të emailit';
                      } else if (!regex.hasMatch(value)) {
                        return 'Ju lutem shkruani një email të saktë';
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
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _vorname,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'Emër/First Name*',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.person_outlined,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 24.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      final namePattern = r'^[a-zA-Z ]+$';
                      final RegExp regex = RegExp(namePattern);
                      if (value!.isEmpty) {
                        return 'Ju lutem shkruani emrin tuaj';
                      } else if (!regex.hasMatch(value)) {
                        return 'Ju lutem shkruani një emër të saktë';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _vorname.text = value!;
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _nachname,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'Mbiemër/Last Name*',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.person_outlined,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 24.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      final namePattern = r'^[a-zA-Z ]+$';
                      final RegExp regex = RegExp(namePattern);
                      if (value!.isEmpty) {
                        return 'Ju lutem shkruani mbiemrin tuaj';
                      } else if (!regex.hasMatch(value)) {
                        return 'Ju lutem shkruani një mbiemër të saktë';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nachname.text = value!;
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(

                      textTheme: const TextTheme(
                        subtitle1: TextStyle(color: Colors.white),
                      ),
                    ),
                    child: SelectState(

                      onCountryChanged: (value) {
                        setState(() {
                          _countryValue = value;
                        });
                      },
                      onStateChanged:(value) {
                        setState(() {
                          _stateValue = value;
                        });
                      },
                      onCityChanged:(value) {
                        setState(() {
                          _cityValue = value;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      dropdownColor: const Color.fromRGBO(52, 52, 66, 1),


                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _alter,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'Data e lindjes/ Birthday',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.calendar_today_outlined,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 24.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onTap: () async {
                      final DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: colors.primaryNeon, // header background color
                                onPrimary: Colors.black, // header text color
                                onSurface: Colors.green, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: colors.secondaryDark, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        final Duration difference = DateTime.now().difference(selectedDate);
                        final int age = (difference.inDays / 365).floor();
                        if (age < 6 && age > 0) {

                          // Display an error message if age is less than 18
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Fehler"),
                              content: Text("Sie müssen mindestens 6 Jahre alt sein, um diese App zu nutzen."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                        }

                        else {

                          // Update the text field with the selected date
                          _alter.text = DateFormat('dd.MM.yyyy').format(selectedDate);
                        }
                      }
                    },
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 180,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gjendja civile/ Family status',
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: RadioListTile<CivilStatus>(
                          title: const Text(
                            'I martuar/ married',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: CivilStatus.yes,
                          groupValue: _civilStatus,
                          onChanged: (CivilStatus? value) {
                            setState(() {
                              _civilStatus = value;
                            });
                          },
                          activeColor: colors.primaryNeon,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<CivilStatus>(
                          title: const Text(
                            'Jo i martuar/ single',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: CivilStatus.no,
                          groupValue: _civilStatus,
                          onChanged: (CivilStatus? value) {
                            setState(() {
                              _civilStatus = value;
                            });
                          },
                          activeColor: colors.primaryNeon,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<CivilStatus>(
                          title: const Text(
                            '-',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: CivilStatus.defaultNothing,
                          groupValue: _civilStatus,
                          onChanged: (CivilStatus? value) {
                            setState(() {
                              _civilStatus = value!;
                            });
                          },
                          activeColor: colors.primaryNeon,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(52, 52, 66, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white30),
                      labelText: 'Fjalëkalimin/ Password*',
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
                      else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~.,-]).{8,}$').hasMatch(value)) {
                          Fluttertoast.showToast(
                              msg: 'Fjalëkalimi kërkon një shkronjë të madhe dhe një karakter special.',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 10.0
                          );
                          return 'Gabim';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password.text = value!;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => UsersAgreement(),
                        transitionDuration: Duration(milliseconds: 200),
                        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                      ),
                    );
                  },
                  child: const Text(
                    'Users Agreement',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              Row(
                children: [
                  Checkbox(
                    value: _usersagrrementIsChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _usersagrrementIsChecked = value!;
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: colors.primaryNeon,
                    side: BorderSide(color: Colors.white),
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text('I agree to the terms and conditions', style: TextStyle(color: Colors.white)),
                ],
              ),



              Container(
                child:

                Column( children: [

                  !_usersagrrementIsChecked
                    ? Text(validateCheckbox(_usersagrrementIsChecked), style: TextStyle(color: Colors.red)) :
                      Text(validateCheckbox(_usersagrrementIsChecked)),
                  const SizedBox(height: 12.0),
                ]),
              ),


              Container(
                child: !_isLoading
                    ? ElevatedButton(
                  onPressed: () async {

                    if (_formKey.currentState!.validate() && _usersagrrementIsChecked==true) {
                      setState(() {
                        _isLoading=true;
                      });

                      final response = await _databaseHelper.register(
                          _nachname.text,
                          _vorname.text,
                          _email.text,
                          '$_countryValue,$_stateValue,$_cityValue',
                          _alter.text,
                          _civilStatus.toString(),
                          _password.text);

                      if (response.statusCode == 200) {
                        // Registration successful
                        Fluttertoast.showToast(
                            msg: "Registration successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        setState(() {
                          _isLoading=false;
                        });
                      } else {
                        // Registration failed
                        Fluttertoast.showToast(
                            msg: response.body,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: colors.primaryNeon,
                            textColor: Colors.white,
                            fontSize: 12.0
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.edit, color: Colors.black),
                      SizedBox(width: 8.0),
                      Text(
                        'Dërgoni',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ) :
                SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(119, 212, 0, 1))),
                ),
              ),
              const SizedBox(height: 20.0),

              ],

            ),

            ),
          ),

      ),
      ),

    );
  }
}
