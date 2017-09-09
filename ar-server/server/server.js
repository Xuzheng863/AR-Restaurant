const express = require("express");
const path = require("path");
const mongoose = require('mongoose');
const routes = require('./routes/routes');
const bodyParser = require('body-parser');

// connect to the mongodb local or on heroku
// URI is provided by heroku in the .env file

mongoose.Promise = global.Promise;
mongoose.connect(process.env.MONGODB_URI,{
  useMongoClient: true,
});

var app = express();
var port = process.env.PORT || 3000;

//Prepare for the ejs path and template
app.set('views', __dirname + '/../client/view');
app.set('view engine', 'ejs');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
        
//make the '/' path relate to local client folder
app.use('/', express.static(path.join(__dirname, '/../client')));

app.get('/',function (req,res){
    res.render('index')
})

// routes(app);

app.listen(port);