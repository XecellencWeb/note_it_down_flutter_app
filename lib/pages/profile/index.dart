import 'package:flutter/material.dart';
import 'package:task_manager_app/functions/alert/index.dart';
import 'package:task_manager_app/pages/mainpage.dart';
import '../../classes/index.dart';

class ProfileMain extends StatefulWidget {
  final User? user;
  const ProfileMain({super.key, required this.user});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  dynamic textColor = const Color.fromARGB(255, 65, 65, 65);

  void passwordCallback(String text) {
    print(text);
  }

  void titleCallback(String text) {
    print(text);
  }

  void changePassword() {
    showPromptDialog(
        context, 'Enter Password', 'Enter current Password to Change Password',
        (text) {
      showPromptDialog(context, "Enter New Password", "Enter new Password",
          passwordCallback);
    });
  }

  void changeTitle() {
    showPromptDialog(
        context, 'Enter Password', 'Enter current Password to Change Title',
        (text) {
      showPromptDialog(
          context, "Enter New Title", "Enter new Title", passwordCallback);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Profile'),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 81, 1, 95),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: const Color.fromARGB(255, 81, 1, 95),
                    backgroundImage: NetworkImage(widget.user!.picture.toString()),
                  ),
                ),
              )
            ],
          ),
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(
                    user: widget.user,
                  ),
                ),
              );
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.user!.picture.toString()),
                    ),
                  ),
                ),
                Text(
                  widget.user!.name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.user!.title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        'Gender: ${widget.user!.gender}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Number of Task Created: ${widget.user!.numberOfTasksCreated}',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: changePassword,
                        child: const Text('Change password'),
                      ),
                      TextButton(
                        onPressed: changeTitle,
                        child: const Text('Change Title '),
                      ),
                      TextButton(
                        onPressed: () async {
                          //  FilePickerResult? result = await FilePicker.platform.pickFiles(
                          //     type: FileType.custom,
                          //     allowedExtensions: ['jpg','png']
                          //  );
                          //  if(result != null){
                          //  File file = File(result.files.single.path);
                          //  }else{
                          //   print('new file selected');
                          //  }
                        },
                        child: const Text('Change Picture'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
