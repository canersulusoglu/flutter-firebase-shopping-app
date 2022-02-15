// ignore_for_file: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../../Services/auth_service.dart';
import '../../Services/service.dart' show ReturnData;
import '../../Components/AppSettingsModalBottomSheet.dart' show showAppSettingsModalBottomSheet;
import '../../Components/SnackBars.dart' show showErrorMessageSnackBar, showSuccessMessageSnackBar;
import '../../Utils/FormValidator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Register"),
            Tooltip(
              message: "App Settings",
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: (){
                  showAppSettingsModalBottomSheet(context);
                }
              ),
            ),
          ],
        ),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Image.asset("assets/images/registerScreenImage.png",
              width: 280),
        ),
        Container(
          margin: const EdgeInsets.all( 30),
          child: const RegisterForm()
        ),
      ],
    ));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController nameInputController = TextEditingController();
  TextEditingController surnameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController passwordConfirmInputController = TextEditingController();

  bool passwordIsHidden = true;
  bool passwordConfirmIsHidden = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordIsHidden = !passwordIsHidden;
    });
  }

  void togglePasswordConfirmVisibility() {
    setState(() {
      passwordConfirmIsHidden = !passwordConfirmIsHidden;
    });
  }

  Future<void> onFormSubmit() async {
    if(registerFormKey.currentState!.validate()){      
      ReturnData result = await AuthService.instance.register(
        emailInputController.text,
        passwordInputController.text,
        nameInputController.text,
        surnameInputController.text,
        phoneNumberInputController.text
      );
      if(result.isSuccessful) {
        showSuccessMessageSnackBar(context, result.getMessage(context));
      }else{
        showErrorMessageSnackBar(context, result.getMessage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Register",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                Text("Sign up and start shopping..",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 5),
                  child: TextFormField(
                    autofocus: false,
                    controller: nameInputController,
                    decoration: const InputDecoration(
                        labelText: "Name", prefixIcon: Icon(Icons.badge)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value){
                      return FormValidator.validate(
                        required: true
                      ).getMessage(context, value!);
                    }
                  ),
                )
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20, left: 5),
                  child: TextFormField(
                    autofocus: false,
                    controller: surnameInputController,
                    decoration: const InputDecoration(
                        labelText: "Surname", prefixIcon: Icon(Icons.badge)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value){
                      return FormValidator.validate(
                        required: true
                      ).getMessage(context, value!);
                    }
                  ),
                )
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              autofocus: false,
              controller: emailInputController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Email", prefixIcon: Icon(Icons.email)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                return FormValidator.validate(
                  required: true,
                  isEmail: true
                ).getMessage(context, value!);
              }
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              autofocus: false,
              controller: phoneNumberInputController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //PhoneInputFormatter(),
                MaskedInputFormatter('(###) ###-####', allowedCharMatcher: RegExp(r"[0-9.]")),
              ],
              decoration: const InputDecoration(
                  labelText: "Phone Number", prefixIcon: Icon(Icons.phone)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                return FormValidator.validate(
                  required: true
                ).getMessage(context, value!);
              }
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              obscureText: passwordIsHidden,
              autofocus: false,
              controller: passwordInputController,
              decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.vpn_key),
                  suffix: InkWell(
                    onTap: togglePasswordVisibility,
                    child: Icon(
                      passwordIsHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                return FormValidator.validate(
                  required: true
                ).getMessage(context, value!);
              }
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: TextFormField(
              obscureText: passwordConfirmIsHidden,
              autofocus: false,
              controller: passwordConfirmInputController,
              decoration: InputDecoration(
                  labelText: "Password Confirm",
                  prefixIcon: const Icon(Icons.vpn_key),
                  suffix: InkWell(
                    onTap: togglePasswordConfirmVisibility,
                    child: Icon(
                      passwordConfirmIsHidden
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value){
                return FormValidator.validate(
                  required: true,
                  matchedString: passwordInputController.text
                ).getMessage(context, value!);
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Already have account? ",
                    style: DefaultTextStyle.of(context).style),
                TextSpan(
                    text: "Login!",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                      }),
              ])),
              ElevatedButton(
                  onPressed: onFormSubmit, child: const Text("Register"))
            ],
          )
        ],
      ),
    );
  }
}
