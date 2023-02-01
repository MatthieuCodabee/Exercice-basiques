import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: BasicPage(),
    );
  }
}

class BasicPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facebook Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("images/cover.jpg", height: 200, fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.only(top: 125),
                  child: CircleAvatar(radius: 75, backgroundColor: Colors.white,
                    child: myProfilePic(72),
                  ),
                )
              ],
            ),
            Row(
              children: const  [
                 Spacer(),
                Text(
                  "Matthieu Codabee",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
                Spacer()
              ],
            ),
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Un jour les chats domineront le monde, mais pas aujourd'hui, c'est l'heure de la sieste",
                  style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic
                  ),
                  textAlign: TextAlign.center,
                )
            ),
            Row(
              children: [
                Expanded(child: buttonContainer(text: "Modifier le profil")),
                buttonContainer(icon: Icons.border_color)
              ],
            ),
            const Divider(thickness: 2,),
            sectionTitleText("A propos de moi"),
            aboutRow(icon: Icons.house, text: "Hyères les palmiers, France"),
            aboutRow(icon: Icons.work, text: "Développeur Flutter"),
            aboutRow(icon: Icons.favorite, text: "En couple avec mon chat"),
            const Divider(thickness: 2,),
            sectionTitleText("Amis"),
            allFriends(width / 3.5),
            const Divider(thickness: 2,),
            sectionTitleText("Mes Posts"),
            post(time: "5 minutes", image: "images/carnaval.jpg", desc: "Petit tour au Magic World, on s'est bien amusés et en plus il n'y avait pas grand monde. Bref, le kiff"),
            post(time: "2 jours", image: "images/mountain.jpg", desc: "La montagne ca vous gagne", likes: 38),
            post(time: "1 semaine", image: "images/work.jpg", desc: "Retour au boulot après plusieurs mois de confinement", likes: 12, comments: 3),
            post(time: "5 ans", image: "images/playa.jpg", desc: "Le boulot en remote c'est le pied: la preuve ceci sera mon bureau pour les prochaines semaines", likes: 235, comments: 88)
          ],
        ),
      ),
    );
  }

  CircleAvatar myProfilePic(double radius) {
    return CircleAvatar(radius: radius, backgroundImage: const AssetImage("images/profile.jpg"));
  }

  Container buttonContainer({IconData? icon, String? text}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue
      ),
      height: 50,
      child: (icon == null)
          ?  Center(child: Text(text ?? "", style: TextStyle(color: Colors.white)))
          : Icon(icon, color: Colors.white,),
    );
  }

  Widget sectionTitleText(String text) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18
        ),
      ),
    );
  }

  Widget aboutRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(text),
        )
      ],
    );
  }

  Column friendsImage(String name, String imagePath, double width) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          width: width,
          height: width,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey)],
              color: Colors.blue

          ),

        ),
        Text(name),
        const Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }

  Row allFriends(double width) {
    Map<String, String> friends = {
      "José": "images/cat.jpg",
      "Maggie": "images/sunflower.jpg",
      "Douggy": "images/duck.jpg"
    };
    List<Widget> children = [];
    friends.forEach((name, imagePath) {
      children.add(friendsImage(name, imagePath, width));
    });
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Container post({required String time , required String image, required String desc, int likes = 0, int comments = 0}) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 3, right: 3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(225, 225, 225, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              myProfilePic(20),
              const Padding(padding: EdgeInsets.only(left: 8)),
              const Text("Matthieu Codabee"),
              const Spacer(),
              timeText(time)
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Image.asset(image, fit: BoxFit.cover,)
          ),
          Text(desc,
            style: const TextStyle(
                color: Colors.blueAccent),
            textAlign: TextAlign.center,

          ),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.favorite),
              Text("$likes Likes"),
              const Icon(Icons.message),
              Text("$comments Commentaires")
            ],
          )

        ],
      ),
    );
  }

  Text timeText(String time) {
    return Text("Il y a $time", style: const TextStyle(color: Colors.blue),);
  }
}
