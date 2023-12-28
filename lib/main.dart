import 'package:flutter/material.dart';
import 'package:task_manager_app/components/loader.dart';
import 'package:task_manager_app/graph_ql/queries.dart';
import 'package:task_manager_app/storage/index.dart';
import './pages/signup.dart';
import './pages/mainpage.dart';
import 'classes/index.dart';

void main() async {
  await Storage.initStorage('user_store');
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'start',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double customWidth = 350;
  double customHeight = 50;
  double logoSize = 100;
  bool login = false;
  User? user;
  bool isLoading = false;
  final GraphQLQuery _graphQLQuery = GraphQLQuery();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final userStore = Storage.getStorage('user_store');
  @override
  void initState() {
    super.initState();

    _loginUserIn();
  }

  void _loginUserIn() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (login) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  MainPage(
              user: user,
            ),
          ),
        );
      }
    });
  }

  

  void loginFunction() async {
    try {
      isLoading = true;
      print(_name.text);
      print(_password.text);
      User loggedUser = await _graphQLQuery.getUser(name: _name.text, password: _password.text);
      login = true;
      user = loggedUser;
      _loginUserIn();
      print("It works user exist");
    } catch (error) {
      print(error);
      throw Exception(error);
    } finally {
      isLoading = false;
    }
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
                        margin: const EdgeInsets.only(bottom: 10, top: 40),
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
                          controller: _name,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Your Name...'),
                        ),
                      ),
                      Container(
                        width: customWidth,
                        height: customHeight,
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TextField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Password...',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: customWidth,
                        height: customHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loginFunction();
                            });
                          },
                          child: const Text('Log In'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: const Text('or'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: customWidth,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account, create one',
                          style: TextStyle(
                            color: Color.fromARGB(255, 83, 6, 134),
                          ),
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
