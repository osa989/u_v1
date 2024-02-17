import 'package:flutter/material.dart';
import 'package:unheard_voices/constants.dart';
import 'package:unheard_voices/features/settings/presentation/view/widgets/address_screen.dart';
import 'package:unheard_voices/features/settings/presentation/view/widgets/settings_screen_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0x9D052EFD),
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.subject_outlined,
                      color: whiteColor,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    'Unheard Voices',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.language,
                      color: whiteColor,
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 14),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 13,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: whiteColor,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 22.0,
                          ),
                          SizedBox(width: 15.0),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                color: Color(0x9D5D7AFA),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 20,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey[100],
                          backgroundImage:
                              AssetImage('assets/GIF/HumanBeings.gif'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 105),
              Container(
                height: 25,
                color: Colors.white,
              ),
              Container(
                color: Colors.white,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: () {
                          print("Disable Notifications tapped");
                        },
                        title: Text("Name"),
                        trailing: Icon(Icons.title_rounded),
                      ),
                      ListTile(
                        onTap: () {
                          print("Disable Notifications tapped");
                        },
                        title: Text("Disable Notifications"),
                        trailing: Icon(Icons.notifications_active_outlined),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddressScreen()));
                        },
                        title: Text("Address"),
                        trailing: Icon(Icons.location_on_outlined),
                      ),
                      ListTile(
                        onTap: () {
                          print("About us tapped");
                        },
                        title: Text("About us"),
                        trailing: Icon(Icons.help_outline_rounded),
                      ),
                      ListTile(
                        onTap: () {
                          print("Contact us tapped");
                        },
                        title: Text("Contact us"),
                        trailing: Icon(Icons.phone_callback_outlined),
                      ),
                      ListTile(
                        onTap: () {
                          print("Logout tapped");
                        },
                        title: Text("Logout"),
                        trailing: Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
