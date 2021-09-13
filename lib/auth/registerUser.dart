import 'package:chmm_carpool/auth/userData.dart';
import 'package:chmm_carpool/sharedPreferences/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  final String phone;
  SignUp({this.phone});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController aadharCotroller = TextEditingController();
  TextEditingController dateOFBirthController = TextEditingController();

  String uid;
  String mob;
  //dropdown variables

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form field variables
  String name;
  String phone;
  String email;
  String upiId;
  String adhar;
  String dob;
  String vehicleNo;
  int carpool = 0;
  bool _isVisible = false;

  bool _areFieldsFilled() {
    if (namecontroller.text.isEmpty) {
      _showToast("Name is required");
      return false;
    }
    if (emailController.text.isEmpty) {
      _showToast("Email is required");
      return false;
    }
    if (aadharCotroller.text.isEmpty) {
      _showToast("Aadhar is required");
      return false;
    }
    if (dateOFBirthController.text.isEmpty) {
      _showToast("Date of birth is required");
      return false;
    }

    return true;
  }

  _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 1,
    );
  }

  void saveUserInfo() async {
    uid = FirebaseAuth.instance.currentUser.uid;
    phone = FirebaseAuth.instance.currentUser.phoneNumber;
    await UserDatabaseService(uid: uid)
        .updateUserData(name, email, upiId, adhar, dob, carpool, vehicleNo);
    // print("stored user details in firestore");

    //save user id from response in local storage

    MySharedPreferences.instance.setStringValue("userName", name);
    MySharedPreferences.instance.setStringValue("userPhone", phone);
    MySharedPreferences.instance.setStringValue("upiID", upiId);
    MySharedPreferences.instance.setStringValue('aadhar', adhar);
    MySharedPreferences.instance.setStringValue('dob', dob);

    MySharedPreferences.instance.setStringValue("vechicleno", vehicleNo);
    MySharedPreferences.instance.setStringValue("email", email);

    MySharedPreferences.instance.setBoolValue("isLoggedIn", true);
    MySharedPreferences.instance.setIntValue("carpool", carpool);

    // print("stored user data in local storage");
  }

  // Submit the user details to database
  void _submitForm(BuildContext context) async {
    saveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        children: <Widget>[
          Image(
            //
            height: 250,

            image: AssetImage("assets/signUp.jpg"),
          ),
          // Sign Up container
          Container(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            width: 320.0,
            height: 500.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -10.0),
                    blurRadius: 10.0)
              ],
            ),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // UserName
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                        labelText: "Name", icon: Icon(Icons.account_circle)),
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Poppins"),
                    onChanged: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "example@email.com",
                        labelText: "Email ID",
                        icon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  // Phone
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "abcd@ybl",
                        labelText: "UPI ID",
                        icon: Icon(Icons.money)),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() {
                        upiId = val;
                      });
                    },
                  ),

                  // Branch
                  TextFormField(
                    controller: aadharCotroller,
                    decoration: InputDecoration(
                        labelText: "Aadhar Number ",
                        icon: Icon(Icons.credit_card_outlined)),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() {
                        adhar = val;
                      });
                    },
                  ),
                  TextFormField(
                    controller: dateOFBirthController,
                    decoration: InputDecoration(
                        labelText: "Date of birth",
                        hintText: "19/05/1997",
                        icon: Icon(Icons.date_range_sharp)),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() {
                        dob = val;
                      });
                    },
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),

                  // Carpool
                  Row(
                    children: <Widget>[
                      Text(
                        "Do you have a vehicle to pool?",
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(2.0)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Yes:", style: TextStyle(fontSize: 17.0)),
                      Radio(
                        activeColor: Colors.green,
                        value: 1,
                        groupValue: carpool,
                        onChanged: (int val) {
                          setState(() {
                            carpool = val;
                            _isVisible = true;
                          });
                        },
                      ),
                      Text("No:", style: TextStyle(fontSize: 17.0)),
                      Radio(
                        activeColor: Colors.green,
                        value: 0,
                        groupValue: carpool,
                        onChanged: (int val) {
                          setState(() {
                            carpool = val;
                            _isVisible = false;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  ),
                  Visibility(
                    visible: _isVisible,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Vehicle No",
                          icon: Icon(Icons.directions_bike)),
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontFamily: "Poppins"),
                      onChanged: (val) {
                        setState(() {
                          vehicleNo = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Submit Button

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              child: Text("Register"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Terms and Conditions agreement'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  'You agree to our terms and conditions when you register..'),
                                              Text(
                                                  'Would you like to go further?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              'Register',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                            onPressed: () {
                                              if (_areFieldsFilled()) {
                                                _submitForm(context);
                                                Navigator.pushNamed(
                                                    context, "/homescreen");
                                              }
                                            },
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text("Read terms"))
                                        ],
                                      );
                                    });
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
