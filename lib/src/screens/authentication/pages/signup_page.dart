import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/services/authentication_service.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  
  FocusNode _fullNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _phoneFocus = FocusNode();

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _phone = '';
  bool _visiblePass = true;
  File? _pickedImage;
  AuthenticationService _authenticationService = AuthenticationService();
  GlobalMethods _globalMethods = GlobalMethods();

  @override
  void initState() {
    super.initState();
  }

  void _submitFormSignUp() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      if (_pickedImage == null) {
        _globalMethods.showError(
            subtitle: 'Please pick an image', context: context);
      } else {
        _authenticationService.signUp(
            email: _email,
            password: _password,
            fullName: _fullName,
            phone: _phone,
            image: _pickedImage!,
            onSuccess: () {
              Get.back();
            },
            error: (err) {
              _globalMethods.showError(subtitle: err, context: context);
            });
      }
    }
  }

  @override
  void dispose() {
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  void _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Get.back();
  }

  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Get.back();
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [AppColor.gradientFStart, AppColor.gradientStart],
                      [AppColor.gradientFEnd, AppColor.gradientEnd],
                    ],
                    durations: [19400, 10800],
                    heightPercentages: [0.20, 0.25],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(double.infinity, double.infinity)),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 30),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: AppColor.gradientEnd,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: AppColor.gradientFEnd,
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage!),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 110,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: AppColor.gradientEnd,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.gradientStart),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: _pickImageFromCamera,
                                        splashColor: Colors.grey.shade400,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                color: AppColor.title,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _pickImageFromGallery,
                                        splashColor: Colors.grey.shade400,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                color: AppColor.title,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _removeImage,
                                        splashColor: Colors.grey.shade400,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              'Remove',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(15),
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('fullname'),
                          validator: (value) {
                            if ('$value'.isEmpty) {
                              return 'Please enter a valid full name';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                          focusNode: _fullNameFocus,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.purple,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              color: _fullNameFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: _fullNameFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onSaved: (value) {
                            _fullName = '$value';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if ('$value'.isEmpty || !'$value'.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocus),
                          focusNode: _emailFocus,
                          cursorColor: Colors.purple,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.email,
                              color: _emailFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: _emailFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onSaved: (value) {
                            _email = '$value';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if ('$value'.isEmpty || '$value'.length < 8) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          cursorColor: Colors.purple,
                          focusNode: _passwordFocus,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_phoneFocus),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                            ),
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: _passwordFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _visiblePass = !_visiblePass;
                                });
                              },
                              child: Icon(
                                _visiblePass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: _passwordFocus.hasFocus
                                    ? Colors.purple
                                    : Colors.grey,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: _passwordFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          obscureText: _visiblePass,
                          onSaved: (value) {
                            _password = '$value';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          cursorColor: Colors.purple,
                          key: ValueKey('phone'),
                          validator: (value) {
                            if ('$value'.isEmpty || '$value'.length < 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          onEditingComplete: _submitFormSignUp,
                          focusNode: _phoneFocus,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple, width: 3),
                            ),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: _phoneFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                              color: _phoneFocus.hasFocus
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                            fillColor: Theme.of(context).backgroundColor,
                          ),
                          onSaved: (value) {
                            _phone = '$value';
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 22),
                              primary: Colors.pinkAccent.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: AppColor.backgroundColor,
                                ),
                              ),
                            ),
                            onPressed: _submitFormSignUp,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(Feather.user_plus, size: 16),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
