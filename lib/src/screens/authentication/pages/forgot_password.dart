import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:shopappfirebase/src/common/myicon.dart';
import 'package:shopappfirebase/src/services/authentication_service.dart';
import 'package:shopappfirebase/src/services/global_methods.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  String _email = '';
  FocusNode _emailFocus = FocusNode();
  GlobalMethods _globalMethods = GlobalMethods();
  AuthenticationService _auth = AuthenticationService();
  bool _isLoading = false;

  void submitForm() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      _auth
          .forgetPassword(
        email: _email,
        onError: (err) {
          _globalMethods.showError(subtitle: err, context: context);
        },
      )
          .then((value) {
        Fluttertoast.showToast(
          msg: 'An email has been sent',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16,
        );
        setState(() {
          _isLoading = false;
          _emailController.clear();
          FocusScope.of(context).unfocus();
        });
      });
    }
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Forget password',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: _emailController,
                  key: ValueKey('email'),
                  validator: (value) {
                    if ('$value'.isEmpty || !'$value'.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onEditingComplete: () {},
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 3),
                    ),
                    filled: true,
                    prefixIcon: Icon(
                      Icons.email,
                      color: _emailFocus.hasFocus ? Colors.purple : Colors.grey,
                    ),
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                      color: _emailFocus.hasFocus ? Colors.purple : Colors.grey,
                    ),
                    fillColor: Theme.of(context).backgroundColor,
                  ),
                  onSaved: (value) {
                    _email = '$value';
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                  primary: Colors.purple.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: AppColor.backgroundColor,
                    ),
                  ),
                ),
                onPressed: submitForm,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    _isLoading
                        ? Container(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(MyIcon.key, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
