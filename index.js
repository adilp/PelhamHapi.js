'use strict';

const Hapi = require('hapi');
var mysql      = require('mysql');
const Bcrypt = require('bcryptjs');
const Basic = require('hapi-auth-basic');


var connection = mysql.createConnection({
 host: 'mydb.conrqu16ybbt.us-east-1.rds.amazonaws.com',
  user     : 'adilp',
  password : 'v0f19py8',
  database: 'hockeydb'
});

const server = new Hapi.Server();
server.connection({ port: 3000 });
connection.connect();







function spotAvailable(cb){
    connection.query('SELECT * FROM master_schedule WHERE idmaster_schedule = 1', (err, result) => {
        reservationCb(result,cb);
    });
};

function reservationCb(res, cb){
    connection.query('SELECT * FROM reservation WHERE idmaster_schedule = 1', (err, result) => {
        var numberOfSpotsAvailable = res[0].numOfSpots;
        var numberOfReservedSpots = result.length;
        cb(numberOfSpotsAvailable - numberOfReservedSpots);
    });

}


//---------- calculation

server.route({
        method: 'GET',
        path: '/SpotsLeft',
        handler: function (request, reply) {

                var TotalSpots;
                var totalSpotsLeft;
                
                spotAvailable(function(result){
                    reply({"spots" : result});
                    console.log(result);


                    
                });  



                
        }
});



//-----------------
function spotAvailableStickPuck(cb){
    connection.query('SELECT * FROM master_schedule WHERE idmaster_schedule = 2', (err, result) => {
        reservationStickPuckCb(result,cb);
    });
};

function reservationStickPuckCb(res, cb){
    connection.query('SELECT * FROM reservation WHERE idmaster_schedule = 2', (err, result) => {
        var numberOfSpotsAvailable = res[0].numOfSpots;
        var numberOfReservedSpots = result.length;
        cb(numberOfSpotsAvailable - numberOfReservedSpots);
    });

}


server.route({
        method: 'GET',
        path: '/SpotsLeftStickPuck',
        handler: function (request, reply) {

                var TotalSpots;
                var totalSpotsLeft;
                
                spotAvailableStickPuck(function(result){
                    reply({"spots" : result});
                    console.log(result);

                });  
                
        }
});

//------------------------------------- USED TO RESERVE A SPOT FOR PICK UP

function pickupReservationsMade(cb){
    connection.query('SELECT * FROM reservation', (err, result) => {
        pickupReserve(result.length + 1,cb);
        //console.log(result.length + 1);
        //cb(result.length + 1);

    });
};
function pickupReserve(res, cb){
    connection.query('INSERT INTO reservation VALUES (?,1,1)', [res], (err, result) => {
       // var numberOfSpotsAvailable = res;
        //var numberOfReservedSpots = result;
        //cb([numberOfSpotsAvailable , numberOfReservedSpots]);
        //console.log(result);
        cb(true);
    });

}

server.route({
        method: 'GET',
        path: '/ReservePickUpSpot',
        handler: function (request, reply) {

                var TotalSpots;
                var totalSpotsLeft;
                
                pickupReservationsMade(function(result){
                    reply({"Result": true});
                    //console.log(result);

                });  
                
        }
});


//------------------------------------- USED TO RESERVE A SPOT FOR STICKPUCK

function stickPuckReservationsMade(cb){
    connection.query('SELECT * FROM reservation', (err, result) => {
        stickPuckReserve(result.length + 1,cb);
        //console.log(result.length + 1);
        //cb(result.length + 1);

    });
};
function stickPuckReserve(res, cb){
    connection.query('INSERT INTO reservation VALUES (?,1,2)', [res], (err, result) => {
       // var numberOfSpotsAvailable = res;
        //var numberOfReservedSpots = result;
        //cb([numberOfSpotsAvailable , numberOfReservedSpots]);
        //console.log(result);
        cb(true);
    });

}

server.route({
        method: 'GET',
        path: '/ReserveStickPuck',
        handler: function (request, reply) {

                var TotalSpots;
                var totalSpotsLeft;
                
                stickPuckReservationsMade(function(result){
                    reply({"Result": true});
                    //console.log(result);

                });  
                
        }
});


//------------Authentication
server.route({
        method: 'GET',
        path: '/authentication/{UserName}/{Password}',
        handler: function (request, reply) {
            

                myFunction(encodeURIComponent(request.params.UserName), encodeURIComponent(request.params.Password),  function(result){
                    reply({"result" : result});
                });
                
                
        }
});


//---------Authentication function


function myFunction(username, password, cb){
    var tf;
    connection.query('SELECT * FROM User WHERE Email = ?', [username], (err, result) => {
    
   var resultUserName = result[0].UserName;
   var resultPassword = result[0].Password;
    
    if (err){
        throw err;
    }
    if (resultUserName == username & resultPassword == password){
        console.log("first " + tf);
        tf = true;
        cb(true);
        console.log("Second " + tf);
    } else{
        console.log(false);
    tf = false;
    cb(false);
}
});
    console.log("Hirtd " + tf);
    
};





var pickup = [
{
date : '03/31/16',
time : '7:00pm' ,
spots : '3'
}
];

var stickPuck = [
{
	date: '03/31/16',
	time: '4:00pm',
    spots: '20'
}];

// var publicSkate = [
// {
// 	date: '04/01/16'
// 	time: '2:00pm'
// }];

server.route({
    method: 'GET',
    path: '/api/schedule/hockey/{type}',
    handler: function (request, reply) {
        
        if (request.params.type=='pickup'){
        reply(pickup);
    	}
    	 if (request.params.type=='stickpuck'){
    	 	reply(stickPuck)
    	 }

    }
});

server.route({
    method: 'GET',
    path: '/api/schedule/iceskating',
    handler: function (request, reply) {
        reply(publicSkate);
    }
});

server.route({
        method: 'GET',
        path: '/pickup',
        handler: function (request, reply) {
            connection.query('SELECT * FROM master_schedule', function(err, rows, fields) {
                if (err) throw err;
                
                //var date = rows[0].start.toString();

                //var timestamp = new Date(date.replace(' ', 'T')).getTime();
                
                //var x = myFunction("adilp");

                //reply(x);
                reply({"Time" : rows[0].start});
                });
        }
});








server.start((err) => {

    if (err) {
        throw err;
    }
    console.log('Server running at:', server.info.uri);
});