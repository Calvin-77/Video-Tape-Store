import 'package:flutter/material.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/user_page/checkout_page.dart';
import 'package:video_tape_store/user_page/film_page.dart';
import 'package:video_tape_store/style/style.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<VideoTape> cart = FilmPage.cart;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          titleTextStyle: AppTextStyle.title(context),
          backgroundColor: Theme.of(context).colorScheme.surface,
          toolbarHeight: 40,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 600,
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 1,
                ),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmPage(
                            videoTape: cart[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 189, 188, 188),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              "http://10.0.2.2:3000${cart[index].VideoTapeImage}",
                              fit: BoxFit.cover,
                              width: 100,
                              height: double.infinity,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              cart[index].Title,
                              style: AppTextStyle.body(context),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOut(cart: FilmPage.cart)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Check Out',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
