import 'package:cnattendance/provider/prefprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecurityCheck extends StatefulWidget {
  final String name;
  final IconData icon;
  final String route;

  SecurityCheck(this.name, this.icon, this.route);

  @override
  State<StatefulWidget> createState() => SecurityCheckState();
}

class SecurityCheckState extends State<SecurityCheck> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PrefProvider>(context);
    return FutureBuilder(
      future: provider.getUserAuth(),
      builder: (BuildContext context,AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  minLeadingWidth: 5,
                  leading: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  trailing: Switch(
                    value: snapshot.data!,
                    onChanged: (value) async {

                    },
                    activeTrackColor: Colors.blueAccent,
                    activeColor: Colors.lightBlue,
                  ),
                  selected: true,
                ),
                const Divider(
                  height: 1,
                  color: Colors.white24,
                  indent: 15,
                  endIndent: 15,
                ),
              ],
            ),
          );
        }else{
          return SizedBox(height: 0,);
        }

      },
    );
  }
}
