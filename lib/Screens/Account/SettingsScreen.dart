// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import '../../Services/service.dart' show ReturnData;
import '../../Services/auth_service.dart';
import '../../Utils/FormValidator.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({ Key? key }) : super(key: key);

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  TextEditingController nameInputController = TextEditingController(text: AuthService.instance.getLoggedUserData.name);
  TextEditingController surnameInputController = TextEditingController(text: AuthService.instance.getLoggedUserData.surname);
  TextEditingController emailInputController = TextEditingController(text: AuthService.instance.getLoggedUserData.email);
  TextEditingController phoneNumberInputController = TextEditingController(text: AuthService.instance.getLoggedUserData.phoneNumber);
  TextEditingController oldPasswordInputController = TextEditingController();
  TextEditingController newPasswordInputController = TextEditingController();
  TextEditingController newPasswordConfirmInputController = TextEditingController();

  bool oldPasswordIsHidden = true;
  bool newPasswordIsHidden = true;
  bool newPasswordConfirmIsHidden = true;
  
  final changeNameAndSurnameFormKey = GlobalKey<FormState>();
  final changeEmailFormKey = GlobalKey<FormState>();
  final changePhoneNumberFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

  void toggleOldPasswordVisibility() {
    setState(() {
      oldPasswordIsHidden = !oldPasswordIsHidden;
    });
  }

  void toggleNewPasswordVisibility() {
    setState(() {
      newPasswordIsHidden = !newPasswordIsHidden;
    });
  }

  void toggleNewPasswordConfirmVisibility() {
    setState(() {
      newPasswordConfirmIsHidden = !newPasswordConfirmIsHidden;
    });
  }

  
  Future<void> changeNameAndSurname() async{
    if(changeNameAndSurnameFormKey.currentState!.validate()){
      bool result = await AuthService.instance.changeUserNameAndSurname(nameInputController.text, surnameInputController.text);
      if(result){
        print("Name and surname changed");
      }
    }
  }

  Future<void> changePassword() async{
    if(changePasswordFormKey.currentState!.validate()){
      ReturnData result = await AuthService.instance.changePassword(oldPasswordInputController.text, newPasswordInputController.text);
      if(result.isSuccessful){
        
      }else{
        print(result.getMessage(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: const CircleAvatar(
                    radius: 45,
                    child: Text("CS", style:TextStyle(fontSize: 24)),
                  ),
                ),
                Form(
                  key: changeNameAndSurnameFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Change your name and surname"),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              autofocus: false,
                              controller: nameInputController,
                              decoration: const InputDecoration(labelText: "Name", prefixIcon: Icon(Icons.email),),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (String? value){
                                return FormValidator.validate(
                                  required: true
                                ).getMessage(context, value!);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              autofocus: false,
                              controller: surnameInputController,
                              decoration: const InputDecoration(labelText: "Surname", prefixIcon: Icon(Icons.email),),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (String? value){
                                return FormValidator.validate(
                                  required: true
                                ).getMessage(context, value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: 
                        ElevatedButton(
                          child: const Text("Confirm"),
                          onPressed: changeNameAndSurname,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // E-Mail
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Change your e-mail address"),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: "E-Mail", prefixIcon: Icon(Icons.email),),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value){
                    return FormValidator.validate(
                      required: true,
                      isEmail: true
                    ).getMessage(context, value!);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: 
                  ElevatedButton(
                    child: const Text("Confirm"),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ),
          // Telephone
          Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Change your phone number"),
                  ],
                ),
                TextFormField(
                  autofocus: false,
                  controller: phoneNumberInputController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    //PhoneInputFormatter(),
                    MaskedInputFormatter('(###) ###-####', allowedCharMatcher: RegExp(r"[0-9.]")),
                  ],
                  decoration: const InputDecoration(labelText: "Phone Number", prefixIcon: Icon(Icons.phone)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value){
                    return FormValidator.validate(
                      required: true
                    ).getMessage(context, value!);
                  }
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: 
                  ElevatedButton(
                    child: const Text("Confirm"),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ),
          // Password
          Container(
            margin: const EdgeInsets.all(20),
            child: Form(
              key: changePasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Change your password"),
                    ],
                  ),
                  TextFormField(
                      obscureText: oldPasswordIsHidden,
                      autofocus: false,
                      controller: oldPasswordInputController,
                      decoration: InputDecoration(
                          labelText: "Old Password",
                          prefixIcon: const Icon(Icons.vpn_key),
                          suffix: InkWell(
                            onTap: toggleOldPasswordVisibility,
                            child: Icon(
                              oldPasswordIsHidden
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
                  TextFormField(
                      obscureText: newPasswordIsHidden,
                      autofocus: false,
                      controller: newPasswordInputController,
                      decoration: InputDecoration(
                          labelText: "New Password",
                          prefixIcon: const Icon(Icons.vpn_key),
                          suffix: InkWell(
                            onTap: toggleNewPasswordVisibility,
                            child: Icon(
                              newPasswordIsHidden
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
                  TextFormField(
                    obscureText: newPasswordConfirmIsHidden,
                    autofocus: false,
                    controller: newPasswordConfirmInputController,
                    decoration: InputDecoration(
                        labelText: "New Password Confirm",
                        prefixIcon: const Icon(Icons.vpn_key),
                        suffix: InkWell(
                          onTap: toggleNewPasswordConfirmVisibility,
                          child: Icon(
                            newPasswordConfirmIsHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value){
                      return FormValidator.validate(
                        required: true,
                        matchedString: newPasswordInputController.text
                      ).getMessage(context, value!);
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: 
                    ElevatedButton(
                      child: const Text("Confirm"),
                      onPressed: changePassword,
                    ),
                  )
                ],
              )
            )
          )
        ],
      ),
    );
  }
}