import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shopappfirebase/src/common/color.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _emailAddress = '';
  String _password = '';
  bool _visiblePass = true;
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();

  void _submitFormLogin() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
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
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.only(top: 80),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.flaticon.com/icons/png/128/869/869636.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
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
                            _emailAddress = '$value';
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
                          focusNode: _passwordFocus,
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
                          onEditingComplete: _submitFormLogin,
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
                              primary: Colors.purple.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: AppColor.backgroundColor,
                                ),
                              ),
                            ),
                            onPressed: _submitFormLogin,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(Feather.user, size: 16),
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
