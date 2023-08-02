import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_book/auth.dart';
import 'package:game_book/constants.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  final User? user = Auth().currentUser;
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
    if (kDebugMode) {
      print('Sesion cerrada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Style.secondaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(0),
            child: profileDrawer(context),
          ),
          SizedBox(
              child: ListTile(
            title: Text(
              user?.displayName ?? 
              'Nombre de Usuario',
              style: const TextStyle(color: Style.textColor),
            ),
            subtitle: Text(
              user?.email ?? 
              'User Email',
              style: const TextStyle(color: Style.textColor),
            ),
          )),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.g_translate, color: Style.textColor),
            title: const Text(
              'Idioma',
              style: TextStyle(color: Style.textColor),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.important_devices, color: Style.textColor),
            title: const Text(
              'Visita la pagina oficial',
              style: TextStyle(color: Style.textColor),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Style.textColor),
            title: const Text(
              'Terminos y condiciones',
              style: TextStyle(color: Style.textColor),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: Style.textColor, indent: 5),
          ListTile(
            leading: const Icon(Icons.logout, color: Style.textColor),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Style.textColor),
            ),
            onTap: () {
              signOut();
              Navigator.pushNamed(context, 'WelcomePage');
            },
          ),
          const SizedBox(height: 250),
          const Center(
            child: Text(
              'Versión 1.0.0',
              style: TextStyle(color: Style.textColor),
            ),
          )
        ],
      ),
    );
  }

  Stack profileDrawer(BuildContext context) {
    return Stack(
      alignment: const Alignment(0.8, 2.3),
      children: [
        headerDrawer(context),
        CircleAvatar(
          radius: Style.avatarRadius,
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user?.photoURL ?? '')
              : null,
        ),
      ],
    );
  }

  Stack headerDrawer(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: const Alignment(0, 0),
      children: [
        Image.asset(
          "assets/img/drawer-top.png",
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
        Image.asset(
          "assets/img/logo-horizontal.png",
          width: width * 0.7,
        ),
      ],
    );
  }
}
