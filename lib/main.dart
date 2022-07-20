import 'package:flutter/material.dart';

import 'package:fast_rsa/fast_rsa.dart';





void main() => runApp(MaterialApp(
  home:Home(),
));



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var key ,pub_key,pri_key;
  var message  ;
  var en_msg , de_msg ;

  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RSA Demo App"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,

      ),
      body: SingleChildScrollView(
        child: Center(

          child: Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // margin:
              children: <Widget>[
                Text('The generated public key',style:TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold ,
                  fontSize: 18,
                ) ,),

                SizedBox(height: 10),
                Text('$pub_key'),
                Text('The generated private key',style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold ,
                  fontSize: 18,


                ),),
                SizedBox(height: 10),

                Text('$pri_key'),
                SizedBox(height: 10),


                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a message',


                  ),
                ),

                SizedBox(height: 10),

                Text("The message is \"$message\"",style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold ,
                  fontSize: 18,
                ),),
                SizedBox(height: 10),

                TextButton(onPressed: ()async{
                  message = myController.text;


                  if(key == null)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Generate Keys first"),
                    ));
                    return ;
                  }

                  print("The message is = $message") ;
                  en_msg = await RSA.encryptPKCS1v15(message, key.publicKey);

                  print("The encrypted message is = $en_msg") ;

                  print("-------------------Ooo-------------------------");

                  de_msg = await RSA.decryptPKCS1v15(en_msg, key.privateKey);
                  print("The decrypted message is = $de_msg") ;

                  setState((){
                    en_msg ;
                    de_msg ;
                  });


                  },
                  child: Text('Press to encrypt and decrypt'),
                  style: TextButton.styleFrom(
                    primary: Colors.white ,
                    backgroundColor: Colors.deepOrangeAccent,
                  ),

                ),

                SizedBox(height: 10),

                Text("The encrypted message is ",style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold ,
                  fontSize: 18,
                ),),
                SizedBox(height: 10),

                Text('$en_msg'),

                SizedBox(height: 10),

                Text("The decrypted message is \"$de_msg\"",style: TextStyle(
                  color: Colors.black,
                  fontWeight:FontWeight.bold ,
                  fontSize: 18,
                ),),
                SizedBox(height: 10),




              ],


            ),
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:()async {
          print('Clicked');
          //

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Generating RSA key"),
          ));
          // message = myController.text;
          key = await RSA.generate(3072);
          setState((){
            pub_key = key.publicKey ;
            pri_key = key.privateKey ;
          });

          print(key.publicKey);
          print(key.privateKey);

          print("-------------------YAY-------------------------");

        },
        child: Text("Key"),
        backgroundColor: Colors.lightGreen,

      ),
    );
  }
}

