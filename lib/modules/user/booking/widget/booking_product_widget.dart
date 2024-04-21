import 'package:crafton_final/servieces/api_service.dart';
import 'package:crafton_final/servieces/db_services.dart';
import 'package:crafton_final/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingProductWidget extends StatefulWidget {
  BookingProductWidget(
      {super.key, required this.bookingDetails, this.isCompleted});

  final Map<String, dynamic> bookingDetails;
  bool? isCompleted;

  @override
  State<BookingProductWidget> createState() => _BookingProductWidgetState();
}

class _BookingProductWidgetState extends State<BookingProductWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.bookingDetails);
    return Container(
      height: 200,
      padding: EdgeInsets.all(5.0),
      color: Colors.grey.shade100,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(widget.bookingDetails['image'][0],
                  width: 130, height: 130),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.bookingDetails['product_name'],
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Bold',
                            fontSize: 18)),
                    SizedBox(
                      width: 150,
                      child: Text(widget.bookingDetails['description'],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Ubuntu-Regular',
                              fontSize: 15)),
                    ),
                    Text('price:${widget.bookingDetails['total']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Regular',
                            fontSize: 15)),
                    Text('${widget.bookingDetails['quantity']} product',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Ubuntu-Regular',
                            fontSize: 15)),
                  ],
                ),
              ),
            ],
          ),
          if (widget.isCompleted == true)
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Feed back',
                    onPressed: () {

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FeedDialog(
                            productId: widget.bookingDetails['product_id'],
                          );
                        },
                      ).then((value) {

                        setState(() {
                          
                        });
                        
                      });



                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButton(
                    text: 'Complaint',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ComplaintDialog(
                            productId: widget.bookingDetails['product_id'],
                          );
                        },
                      ).then((value) {

                        setState(() {
                          
                        });
                        
                      });
                    },
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class ComplaintDialog extends StatefulWidget {

  ComplaintDialog({super.key, required this.productId});

  final String productId;

  @override
  State<ComplaintDialog> createState() => _ComplaintDialogState();
}

class _ComplaintDialogState extends State<ComplaintDialog> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController complaintController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Complaint'),
      content: loading ?  Center(child: CircularProgressIndicator(),) : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: complaintController,
            decoration: const InputDecoration(labelText: 'Complaint'),
          ),
        ],
      ),
      actions: <Widget>[CustomButton(text: 'Add', onPressed: ()  async{

        setState(() {
          loading = true;
        });

       await  ApiService().addComplaint(
          loginId: DbService.getLoginId()!, 
          productId: widget.productId, 
          complaint: complaintController.text, 
          context: context, 
          title: titleController.text);

      Navigator.pop(context);

      setState(() {
        loading =  false;
      });

        
      })],
    );
  }
}


class FeedDialog extends StatefulWidget {

 FeedDialog({super.key, required this.productId});

  final String productId;

  @override
  State<FeedDialog> createState() => _FeedDialogState();
}

class _FeedDialogState extends State<FeedDialog> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController complaintController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Feedback'),
      content: loading ?  Center(child: CircularProgressIndicator(),) : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          
          TextField(
            controller: complaintController,
            decoration: const InputDecoration(labelText: 'Feed back'),
          ),
        ],
      ),
      actions: <Widget>[CustomButton(text: 'Add', onPressed: ()  async{

        setState(() {
          loading = true;
        });

       await  ApiService().addFeedback(
          loginId: DbService.getLoginId()!, 
          productId: widget.productId, 
          feedback: complaintController.text, 
          context: context, 
          );

      Navigator.pop(context);

      setState(() {
        loading =  false;
      });

        
      })],
    );
  }
}




