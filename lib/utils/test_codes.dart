// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   num _selectedSize = 7;
//   int _quantity = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Air Jordan 6 Retro',
//               style: GoogleFonts.poppins(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '5.1 Reviews',
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Image.network(
//                 'https://example.com/sneaker_image.jpg', // replace with the actual image URL
//                 height: 200,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               '\$192.23',
//               style: GoogleFonts.poppins(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Sizes',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [7, 7.5, 8, 8.5, 9]
//                   .map((size) => ChoiceChip(
//                 label: Text(size.toString()),
//                 selected: _selectedSize == size,
//                 onSelected: (selected) {
//                   setState(() {
//                     _selectedSize = size;
//                   });
//                 },
//               ))
//                   .toList(),
//             ),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: _quantity > 1
//                       ? () {
//                     setState(() {
//                       _quantity--;
//                     });
//                   }
//                       : null,
//                 ),
//                 Text('$_quantity', style: GoogleFonts.poppins(fontSize: 18)),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       _quantity++;
//                     });
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.share),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }