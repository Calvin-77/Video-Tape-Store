import 'package:flutter/material.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/style/style.dart';
import 'package:video_tape_store/user_page/film_page.dart';
import 'package:video_tape_store/user_page/main_page.dart';

class CheckOut extends StatefulWidget {
  final List<VideoTape> cart;

  final int totalPrice = 0;

  const CheckOut({super.key, required this.cart});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int calculateTotalPrice() {
    int total = 0;
    for (var videoTape in widget.cart) {
      total += videoTape.Price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = calculateTotalPrice();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          titleTextStyle: AppTextStyle.title(context),
          backgroundColor: Theme.of(context).colorScheme.surface,
          toolbarHeight: 40,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Container(
            height: 450,
            width: 330,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.secondary),
                color: Theme.of(context).colorScheme.primary),
            child: Column(
              children: [
                SizedBox(
                  height: 230,
                  width: 330,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) => ListTile(
                          dense: true,
                          title: Center(
                            child: Text(
                              style: AppTextStyle.body(context),
                              "${widget.cart[index].Title}     \Rp ${widget.cart[index].Price}",
                            ),
                          )),
                    ),
                  ),
                ),
                Text(
                  "______________________________________________",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Total  :  \Rp ${totalPrice}",
                  style: AppTextStyle.title2(context),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 70,
                  width: 180,
                  child: ElevatedButton(
                      onPressed: () {
                        FilmPage.cart.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Text(
                        "Purchase",
                        style: AppTextStyle.title(context),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
