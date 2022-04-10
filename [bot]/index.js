// Load up the discord.js library
const Discord = require("discord.js");
const mysql = require("mysql");
const { pass } = require('./secret.js')

// This is your client. Some people call it `bot`, some people call it `self`, 
// some might call it `cootchie`. Either way, when you see `client.something`, or `bot.something`,
// this is what we're refering to. Your client.
const client = new Discord.Client();
var con = mysql.createConnection({
    host: "localhost",
    user: "orarp",
    password: pass,
    database: "orarp"
  });
// Here we load the config.json file that contains our token and our prefix values. 
const config = require("./config.json");
// config.token contains the bot's token
// config.prefix contains the message prefix.

con.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
});
client.on("message", async message => {
  // This event will run on every single message received, from any channel or DM.
    console.log()
  // It's good practice to ignore other bots. This also makes your bot ignore itself
  // and not get into a spam loop (we call that "botception").
  if(message.author.bot) return;
  
  // Also good practice to ignore any message that does not start with our prefix, 
  // which is set in the configuration file.
  if(message.content.indexOf(config.prefix) !== 0) return;
  
  // Here we separate our "command" name, and our "arguments" for the command. 
  // e.g. if we have the message "+say Is this the real life?" , we'll get the following:
  // command = say
  // args = ["Is", "this", "the", "real", "life?"]
  const args = message.content.slice(config.prefix.length).trim().split(/ +/g);
  const command = args.shift().toLowerCase();
  
  // Let's go with a few common example commands! Feel free to delete or change those.
  console.log(command)
  console.log(command == "wl")
  console.log(message.channel.id)
    if (message.channel.id != "962003138905264169") {
        return}
    if (command == "wl") {
        console.log(args)
        if (args[0] !== undefined) {
            console.log("oue")
            var sql = "INSERT INTO whitelist (identifier) VALUES ('"+args[0]+"')";
            con.query(sql, function (err, result) {
            if (err) console.log(err);
            message.channel.send("Utilisateur ("+args[0]+") whitelist !")
            });
        }
    }
    if (command == "tow") {
        console.log(args)
        if (args[0] !== undefined) {
            var sql = "UPDATE players_vehicles SET pound = '1' WHERE plate = '"+args[0]+"'";
            con.query(sql, function (err, result) {
                if (err) console.log(err);
                message.channel.send("Plaque ("+args[0]+") envoyée en fourrière !")
            });
        }
    }
    if (command == "unwl") {
        if (args[0] != undefined) {
            var sql = "DELETE FROM whitelist WHERE identifier ='"+args[0]+"'";
            con.query(sql, function (err, result) {
            if (err) throw err;
            message.channel.send("Utilisateur ("+args[0]+") déswhitelist !")
            });
        }
    }
    if (command == "wipe") {
        if(args[0] != undefined){
            var sql = "UPDATE whitelist SET character_count = 0 WHERE identifier = '"+args[0]+"'";
            con.query("SELECT uuid FROM users WHERE identifier = '"+args[0]+"'", function (err, result, fields){
                if (err) throw err;
                var sql = "DELETE FROM players_jobs WHERE uuid = '"+result[0].uuid+"'";
                con.query(sql, function (err, result) {
                    if (err) throw err;
                });
                var sql = "DELETE FROM players_identity WHERE uuid = '"+result[0].uuid+"'";
                con.query(sql, function (err, result) {
                    if (err) throw err;
                });
                var sql = "DELETE FROM players_vehicles WHERE uuid = '"+result[0].uuid+"'";
                con.query(sql, function (err, result) {
                    if (err) throw err;
                });

                var sql = "DELETE FROM players_parking WHERE uuid = '"+result[0].uuid+"'";
                con.query(sql, function (err, result) {
                    if (err) throw err;
                });

                var sql = "DELETE FROM players_appearance WHERE uuid = '"+result[0].uuid+"'";
                con.query(sql, function (err, result) {
                    if (err) throw err;
                });
                
                con.query("SELECT uuid, coowner FROM banking_account WHERE uuid = '"+result[0].uuid+"'", (err, res)=>{
                    if(err)throw err
                    if(res.length == 1){ // if there's only a bank account created for the user
                        if(res['coowner'] != null){ // if there's a coowner on the bank account, switch coowner to owner
                            con.query("UPDATE banking_account SET uuid = banking_account.coowner WHERE uuid = '"+result[0].uuid+"'", (err)=>{
                                if (err) throw err
                            })
                        }else{ // if there's no coowner on it, delete the account
                            con.query("DELETE FROM banking_account WHERE uuid = '"+result[0].uuid+"'", (err)=>{
                                if (err) throw err
                            })
                        }
                    }
                    if(res.length > 1){ // if the user have multiple bank accounts
                        res.forEach(el => {
                            if(el['coowner'] != null){// if there is a coowner
																con.query('UPDATE banking_account SET uuid = coowner WHERE uuid = "'+el['uuid']+'" AND coowner = "'+el['coowner']+'"', err=>{if (err) throw err})
                            }else{// if there is no coowner
																con.query('DELETE FROM banking_account WHERE uuid = "'+el['uuid']+'" AND coowner IS NULL', err=>{if (err) throw err})
                            }
                        })
                    }
                })
            });
            var sql2 = "DELETE FROM users WHERE identifier = '"+args[0]+"'";
            con.query(sql, function (err, result) {
            if (err) throw err;
            con.query(sql2, function (err, result) {
                if (err) throw err;
                    message.channel.send("Utilisateur ("+args[0]+") wipe !")
                });
            });
        }
    }
    
});

client.login(config.token);