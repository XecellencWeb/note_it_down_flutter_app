import 'package:flutter/material.dart';
import 'package:task_manager_app/classes/index.dart';
import 'package:task_manager_app/components/loader.dart';
import 'package:task_manager_app/graph_ql/mutation.dart';
import 'package:task_manager_app/pages/mainpage.dart';
import 'package:task_manager_app/storage/index.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double customWidth = 350;
  double customHeight = 50;
  double logoSize = 50;
  bool isLoading = false;
  final GraphQLMutation _graphQLMutation = GraphQLMutation();
  final userStorage = Storage.getStorage('user_store');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void createUser() async {
    try {
      print('creation Started');
      isLoading = true;

      User result = await _graphQLMutation.createUser(
        user: User.toMap(
          user: User(
            name: _nameController.text,
            title: _titleController.text,
            gender: _genderController.text,
            password: _passwordController.text,
          ),
        ),
      );

      _gotomainpage(user: result);

      isLoading = false;
      print('creation ended');
    } catch (e) {
      print(e);
    }finally{
        isLoading = false;
    }

    
  }

  void _gotomainpage({required User user}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(user: user),
      ),
    );
  }

  void signUpFunction() {
    setState(() {
      createUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isLoading
            ? const Loader()
            : Container(
                padding: const EdgeInsets.all(25),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: logoSize,
                        height: logoSize,
                        margin: const EdgeInsets.only(bottom: 10, top: 30),
                        child: Image.asset('assets/logo.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: const Text(
                          'NOTE IT DOWN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 83, 6, 134)),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your Name...'),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your Title...'),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _genderController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Your Gender...'),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Password...'),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ElevatedButton(
                          onPressed: signUpFunction,
                          child: const Text('Sign Up'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text('or'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: customHeight,
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 83, 6, 134),
                                style: BorderStyle.solid),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/google-icon.png'),
                                ),
                              ),
                              const Text('Sign in with Google')
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'have an account, log in',
                          style:
                              TextStyle(color: Color.fromARGB(255, 83, 6, 134)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
