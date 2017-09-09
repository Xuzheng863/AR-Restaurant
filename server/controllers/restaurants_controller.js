// const Restaurant = require('../db/Restaurant.js')
// const Vote= require('../db/Vote.js');
// const request = require('request')
// const APIKEY_geocode = 'AIzaSyAI9YglLGrKtH8kTHaIVb1H_c_h206eOv8';
// const APIKEY_search = 'AIzaSyC_-bl7-_WVyoBBlhiyUXBi_Dbxex6NWPM';

// module.exports = {

//     index(req,res){
//         //send all the restaurants in the database to the 
//         //client side as an array with json object as elements
//        Restaurant.find({},function(err,restaurants){
//                 if(err){
//                     console.log(err);
//                 }else{
//                     res.json(restaurants);
//                 }
//        });
//     },

//     create_google(req,res){
//         var restaurant = req.body;
//         var lat = restaurant.lat;
//         var lng = restaurant.lng;
//         var url_geocode = `https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=${APIKEY_geocode}`
//         request.get(url_geocode,function(error,response,body){
//             console.log('error:',error);
//             console.log('statusCode:',response && response.statusCode);
//             var body = JSON.parse(body);
//             var placeId = body.results[0].place_id
//             var url_detail = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&radius=1&type=restaurant&key=${APIKEY_search}`
//             request.get(url_detail,function(error,response,body){
//                     console.log('error:',error);
//                     console.log('statusCode:',response && response.statusCode);
//                     var body = JSON.parse(body);
//                     var new_restaurant = Restaurant({
//                         name: body.results[0].name,
//                         address: body.results[0].vicinity
//                     });
        
//                     //save the new restaurant to Mongodb
//                     new_restaurant.save((err) => {
//                         if (err) throw err;
        
//                         console.log('restaurant saved!');
//                     });
//             })
//         })
//         res.sendStatus(200);
//     },
        
//     // ES6 version of create : function(req,res)
//     create(req,res){
//         //get the information from the website
//         var restaurant = req.body;
//         var new_restaurant = Restaurant({
//             name: restaurant.name,
// 	        address: restaurant.address,
//         });

//         //save the new restaurant to Mongodb
//         new_restaurant.save((err) => {
//             if (err) throw err;

//             console.log('restaurant saved!');
//         });
        
//         res.sendStatus(200);

//     },

//     delete(req,res){
//         var restaurant_id = req.params.id;
//         //find the id from mongoDB and also remove it 
//         Restaurant.findByIdAndRemove({_id : restaurant_id},function(err,restaurant){
//                 if(err){
//                     console.log(err);
//                 }else{
//                     res.json(restaurant);
//                 }
//         });
//         Vote.remove({restaurant_id : restaurant_id},function(err){
//                 if(err){
//                     console.log(err);
//                 }
//         });
//     },

//     view(req,res){
//         var restaurant_id = req.params.id;
//         Restaurant.findById({_id : restaurant_id},function(err,restaurant){
//                 if(err){
//                     console.log(err);
//                 }else{
//                     res.json(restaurant);
//                 }
//         });
//     },

//     edit(req,res){
//         var restaurant_id = req.params.id;
//         const restaurantProps = req.body;

//         Restaurant.update({ _id: restaurant_id }, restaurantProps, 
//                 function(err,restaurant){
//                     if(err){
//                         console.log(err);
//                     }else{
//                         console.log("Update Successfully");
//                     }
//                 })
//         //change all the vote related to this restaurant
//         Vote.find({"restaurant_id" : restaurant_id }).exec()
//           .then((doc) =>
//             {
//               for(var index = 0;index < doc.length;index ++){
//                 doc[index].restaurant_name = restaurantProps.name;
//                 doc[index].save();
//               }
//             }
//         );

//         res.sendStatus(200);
//     }
// }