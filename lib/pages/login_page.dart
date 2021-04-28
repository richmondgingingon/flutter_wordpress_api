import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/services/progress_hud.dart';
import 'package:flutter_wordpress_api/services/api_service.dart';
import 'package:flutter_wordpress_api/utils/form_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final _scaffoldKey = GlobalKey<ScaffoldState>();
static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
String _username = "";
String _pwd = "";
bool hidePassword = true;
bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldKey,
        body: ProgressHUD(
          child: _loginUISetup(context),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
      )
    );
  }

  Widget _loginUISetup(BuildContext context){
    return new SingleChildScrollView(
      child: new Container(
        child: new Form(
          key: globalFormKey,
          child: _loginUI(context),
        )
      ),
    );
  }

  Widget _loginUI(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,         
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer()
            ]
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 20, 
              top: 40
            ),
            child: Text(
              "WordPress Login",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 25
              ),
            )
          )
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 20, 
            top: 20
          ),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(
              Icons.verified_user
            ),
            "username",
            "Username",
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return 'Username can\'t be empty.';
              }

              return null;
            },
            (onSavedValue){
              _username = onSavedValue.toString().trim();
            }
          )
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 20
          ),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(
              Icons.lock
            ),
            "password",
            "Password",
            (onValidateVal){
              if(onValidateVal.isEmpty){
                return 'Password can\'t be empty.';
              }

              return null;
            },
            (onSavedValue1){
              _pwd = onSavedValue1.toString().trim();   
            },
            initialValue: "",
            obscureText: hidePassword,
            suffixIcon: IconButton( 
              onPressed: (){
                setState((){
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withOpacity(0.4),
              icon: Icon( 
                hidePassword?Icons.visibility_off: Icons.visibility
              ),
            )
          )
        ), 
        SizedBox( 
          height: 20,
        ),
        new Center(
          child: FormHelper.saveButton(
            "Login",
            (){
              if(validateAndSave())
              {
                print("Username : $_username");
                print("Password : $_pwd");

                setState(() {
                  this.isApiCallProcess = true;
                });

                APIServices.loginCustomer(_username, _pwd).then((response){
                  setState(() {
                    this.isApiCallProcess = false;
                  });

                  if(response){
                    globalFormKey.currentState.reset();
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                  else{
                    FormHelper.showMessage(context, "Login", "Invalid Username/Password", "Ok", (){
                      Navigator.of(context).pop();
                    });
                  }
                }); 
              }
            },
          )
        )
      ],
    );
  }

  bool validateAndSave(){
    final form = globalFormKey.currentState;

    if(form.validate()){
      form.save();
      return true;
    }

    return false;
  }
}