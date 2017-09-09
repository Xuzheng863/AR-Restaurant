const Restaurant = require('../db/Restaurant.js')
const request = require('request')
const APIKEY_search = 'AIzaSyDgXVhtYw1RwGQSajpSlIwufcsPHciE4U0';

module.exports = {
    create(req,res){
        var lat = 40.4430055;
        var lng = -79.94606759999999;
        var url_detail = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&radius=1000&type=restaurant&key=${APIKEY_search}`
        request.get(url_detail,function(error,response,body){
            console.log('error:',error);
            console.log('statusCode:',response && response.statusCode);
            var body = JSON.parse(body);
            for (index = 0; index < 20; index++){
                var new_restaurant = Restaurant({
                    name: body.results[index].name,
                    address: body.results[index].vicinity,
                    geoposition : [body.results[index].geometry.location.lat,body.results[index].geometry.location.lng],
                    rating : 3 ,
                    price_level : body.results[index].price_level ? body.results[index].price_level : 0
                });
    
                //save the new restaurant to Mongodb
                new_restaurant.save((err) => {
                    if (err) throw err;
    
                    console.log('restaurant saved!');
                });
            }
        })
        res.sendStatus(200);
    },
    fetch_restaurants(req,res){
        Restaurant.find({},function(err,restaurants){
            if(err){
                console.log(err);
            }else{
                res.json(restaurants);
            }
        });
    }
}