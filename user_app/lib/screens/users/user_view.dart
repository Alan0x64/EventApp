// ignore_for_file: use_build_context_synchronously
import 'dart:ui';
import 'package:flutter/material.dart';


import '../../models/user.dart';
import '../../utilities/shared.dart';
import '../../widgets/future_builder.dart';

class UserProfilePage extends StatefulWidget {


  const UserProfilePage({
    super.key,
  });

  @override
  State<UserProfilePage> createState() {
    return _UserProfilePageState();
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isDarkMode = false;
  User? userx;

  @override
  Widget build(BuildContext context) {
    return BuildFuture(
      callback: () => getUser(),
      mapper: (resData) => toUser(resData.data),
      builder: (data) {
        userx = data;
        String fullName = userx!.fullName;
        return Scaffold(
            appBar: buildAppBar(context, "$fullName's Profile",
                button: const BackButton()),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          height: 200,
                        ),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                userx!.profilePic,
                              ),
                              fit: BoxFit.cover,
                            ),
                            // border: Border.all(
                            //   color: Colors.white,
                            //   width: 1,
                            // ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                userx!.profilePic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userx!.fullName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Email',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.email,
                                      style: const TextStyle(),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Phone Number',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.phoneNumber,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Department',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.department,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Faculty',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.faculty,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Scientific Title',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.scientificTitle,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'University',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.university,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Date Of Birth',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      userx!.dateOfBirth.substring(0, 10),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Bio',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      userx!.bio,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                        ]),
                  ]),
            ));
      },
    );
  }
}
