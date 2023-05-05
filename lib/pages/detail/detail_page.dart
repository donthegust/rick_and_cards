import 'package:flutter/material.dart';
import 'package:rick_and_cards/models/navigation_arguments.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NavigationArguments;

    const baseTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ClipOval(
                  child: Image.network(args.char.image!),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFF272727),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text(args.char.name!, style: baseTextStyle)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Status: ${args.char.status!}',
                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          Text('Species: ${args.char.species!}',
                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          // Text(args.char.type!, style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          Text('Origin: ${args.char.origin!.name!}',
                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          Text('Actual Location: ${args.char.location!.name!}',
                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
