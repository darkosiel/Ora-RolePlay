// Load up the discord.js library
const Discord = require("discord.js");
const { EmbedBuilder } = require('discord.js');

const mysql = require("mysql");
const { exec } = require("child_process");
const { pass } = require('./secret.js')

// This is your client. Some people call it `bot`, some people call it `self`,
// some might call it `cootchie`. Either way, when you see `client.something`, or `bot.something`,
// this is what we're refering to. Your client.
const client = new Discord.Client();
var con = mysql.createConnection({
    host: "localhost",
    user: "admin",
    password: "orabdd",
    database: "ora"
});

// Ora's color
const discordColor = "#ffdb4d"

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
    // It's good practice to ignore other bots. This also makes your bot ignore itself
    // and not get into a spam loop (we call that "botception").
    if(message.author.bot) return;

    //test push bot
    
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
    if (command == "pull" && message.channel.id == "1027263035091460136") {
        exec("cd /home/Prod/resources/ && git pull && r && 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", (error, stdout, stderr) => {
            if (error) {
                message.channel.send(`**Réponse du serveur :** \`\`\`${error.message}\`\`\``);
                return;
            }
            if (stderr) {
                message.channel.send(`**Réponse du serveur :** \`\`\`${stderr}\`\`\``);
                return;
            }
            message.channel.send(`**Réponse du serveur :** \`\`\`${stdout}\`\`\``);
        });
    }
    if (message.channel.id != "962003138905264169") {
        return}
        if (command == "wl") {
            if (args[0] !== undefined) {
                // args[0] should be equal to something like that : steam:1100001199ebce0 
                if (args[0].match(/steam:/) && (args[0].length == 21)) {
                    var sql = "INSERT INTO whitelist (identifier) VALUES ('"+args[0]+"')";
                    con.query(sql, function (err, result) {
                        if (err) {
                            message.channel.send(`**Erreur** \`\`\`${err.message}\`\`\``);
                        } else {
                            message.channel.send("Utilisateur ("+args[0]+") whitelist !")
                        }
                    });
                } else {
                    message.channel.send("Identifiant invalide ! ("+args[0]+") L'identifiant doit faire 21 caractères et commencer par 'steam:'")
                }
            }
        }
        if (command == "tow") {
            if (args[0] !== undefined) {
                var sql1 = `SELECT plate, pound FROM players_vehicles WHERE plate = '${args[0]}'`;
                con.query(sql1, function (err, result) {
                    if (err) { console.log('Error while performing Query.'); } 
                    if (result[0] !== undefined) {
                        if (result[0].pound == 0) {
                            var sql = "UPDATE players_vehicles SET pound = '1' WHERE plate = '"+args[0]+"'";
                            con.query(sql, function (err, result) {
                                if (err) console.log(err);
                                msg = "Plaque ("+args[0]+") envoyée en fourrière !"

                                var sql2 = "DELETE FROM players_parking WHERE plate LIKE '%"+args[0]+"'";
                                    con.query(sql2, function (err, result) {
                                    if (err) console.log(err);
                                    if (result.affectedRows > 0) {
                                        message.channel.send(msg + "\nPlaque ("+args[0]+") supprimée de " + result.affectedRows + " garages !")
                                    } else {
                                        message.channel.send(msg)
                                    }
                                });

                            });
                        } else {
                            message.channel.send("Plaque ("+args[0]+") déjà envoyée en fourrière !")
                        }
                    } else {
                        message.channel.send("<@"+message.author.id+"> **Attention : ** : Plaque ("+args[0]+") introuvable !")
                    }
                });
            }
        }
        if (command == "debugorga") {
            if (args[0] != undefined) {
                var sql = "DELETE FROM organisation_member WHERE uuid ='"+args[0]+"'";
                con.query(sql, function (err, result) {
                    if (err) { 
                        message.channel.send("Erreur : "+err.message);
                    } else {
                        message.channel.send("Utilisateur ("+args[0]+") débug faction !")
                    }
                });
            }
        }
        if (command == "unwl") {
            if (args[0] != undefined) {
                var sql = "DELETE FROM whitelist WHERE identifier ='"+args[0]+"'";
                con.query(sql, function (err, result) {
                    if (err) { 
                        message.channel.send("Erreur : "+err.message);
                    } else {
                        message.channel.send("Utilisateur ("+args[0]+") déswhitelist !")
                    }
                });
            }
        }
        if (command == "wipe") {
            if(args[0] != undefined){
                var sql = "UPDATE whitelist SET character_count = 0 WHERE identifier = '"+args[0]+"'";
                con.query("SELECT uuid FROM users WHERE identifier = '"+args[0]+"'", function (err, result, fields){
                    if (result[0] != undefined && result[0].uuid != undefined) {
                        if (err) message.channel.send("Erreur : "+err.message);
                        var sql = "DELETE FROM players_jobs WHERE uuid = '"+result[0].uuid+"'";
                        con.query(sql, function (err, result) {
                            if (err) message.channel.send("Erreur : "+err.message);
                        });
                        var sql = "DELETE FROM players_identity WHERE uuid = '"+result[0].uuid+"'";
                        con.query(sql, function (err, result) {
                            if (err) message.channel.send("Erreur : "+err.message);
                        });
                        var sql = "DELETE FROM players_vehicles WHERE uuid = '"+result[0].uuid+"'";
                        con.query(sql, function (err, result) {
                            if (err) message.channel.send("Erreur : "+err.message);
                        });
                        
                        var sql = "DELETE FROM players_parking WHERE uuid = '"+result[0].uuid+"'";
                        con.query(sql, function (err, result) {
                            if (err) message.channel.send("Erreur : "+err.message);
                        });
                        
                        var sql = "DELETE FROM players_appearance WHERE uuid = '"+result[0].uuid+"'";
                        con.query(sql, function (err, result) {
                            if (err) message.channel.send("Erreur : "+err.message);
                        });
                        
                        con.query("SELECT uuid, coowner FROM banking_account WHERE uuid = '"+result[0].uuid+"'", (err, res)=>{
                            if(err)message.channel.send("Erreur : "+err.message)
                            if(res.length == 1){ // if there's only a bank account created for the user
                                if(res['coowner'] != null){ // if there's a coowner on the bank account, switch coowner to owner
                                    con.query("UPDATE banking_account SET uuid = banking_account.coowner WHERE uuid = '"+result[0].uuid+"'", (err)=>{
                                        if (err) message.channel.send("Erreur : "+err.message)
                                    })
                                }else{ // if there's no coowner on it, delete the account
                                    con.query("DELETE FROM banking_account WHERE uuid = '"+result[0].uuid+"'", (err)=>{
                                        if (err) message.channel.send("Erreur : "+err.message)
                                    })
                                }
                            }
                            if(res.length > 1){ // if the user have multiple bank accounts
                                res.forEach(el => {
                                    if(el['coowner'] != null){// if there is a coowner
                                        con.query('UPDATE banking_account SET uuid = coowner WHERE uuid = "'+el['uuid']+'" AND coowner = "'+el['coowner']+'"', err=>{if (err) message.channel.send("Erreur : "+err.message)})
                                    }else{// if there is no coowner
                                        con.query('DELETE FROM banking_account WHERE uuid = "'+el['uuid']+'" AND coowner IS NULL', err=>{if (err) message.channel.send("Erreur : "+err.message)})
                                    }
                                })
                            }
                        })
                    } else {
                        message.channel.send("Cet utilisateur n'existe pas !")
                    }
                });
                var sql2 = "DELETE FROM users WHERE identifier = '"+args[0]+"'";
                con.query(sql, function (err, result) {
                    if (err) message.channel.send("Erreur : "+err.message);
                    con.query(sql2, function (err, result) {
                        if (err) message.channel.send("Erreur : "+err.message);
                        if (result.affectedRows == 1) {
                            message.channel.send("Joueur ("+args[0]+") wipe !")
                        }
                    });
                });
            } else {
                message.channel.send("Merci de préciser l'identifiant de l'utilisateur à wipe !")
            }
        }
        if (command == "info") {
            if (args[0] != undefined) {
                if (args[0] == "id") {
                        //var sql = `SELECT pi.first_name AS firstName, pi.last_name AS lastName, pi.uuid AS uuid, u.identifier AS identifier, u.last_connected_at AS lastConnected, u.is_active AS isActive, ba.amount AS amountInBank FROM banking_account As ba, users AS u, players_identity AS pi WHERE pi.uuid = u.uuid AND (u.identifier = ${args[1]} OR (pi.first_name = ${args[1]} AND pi.last_name = ${args[2]}) OR (pi.last_name = ${args[1]} AND pi.first_name = ${args[2]}));`;
                        var sql = `SELECT pi.first_name, pi.last_name, u.identifier, u.uuid, u.phone_number, u.group FROM players_identity AS pi, users AS u WHERE u.uuid = pi.uuid AND ((pi.first_name LIKE '${args[1]}' AND pi.last_name LIKE '${args[2]}') OR (pi.last_name LIKE '${args[1]}' AND pi.first_name LIKE '${args[2]}') OR (u.uuid = '${args[1]}') OR (u.identifier = '${args[1]}'));`;
                        con.query(sql, (err, res)=>{                            
                            if (err) console.log(err.message);
                            if(res.length == 1){
                                
                                var result = res[0];
                                // Embed message
                                var embed = new Discord.MessageEmbed()
                                .setTitle("Informations sur "+result.first_name+" "+res[0].last_name)
                                .setColor(discordColor)
                                .addFields(
                                    {name : "Nom", value : result.last_name, inline: true},
                                    {name : "Prénom", value : result.first_name, inline: true},
                                    {name : "Identifiant", value : result.identifier},
                                    {name : "UUID", value : result.uuid},
                                    {name : "Numéro de téléphone", value : result.phone_number},
                                    {name : "Groupe", value : result.group, inline : true},
                                    )
                                var sql_bank = `SELECT amount FROM banking_account WHERE uuid = '${result.uuid}';`;
                                con.query(sql_bank, (err, res)=>{
                                    if (err) console.log(err.message);
                                    if(res.length == 1){
                                        result.amountInBank = res[0].amount;
                                        
                                        embed.addFields(
                                            {name : "Solde en banque :", value : result.amountInBank + " $", inline : true}
                                        )

                                    }
                                        
                                    var sql_job = `SELECT name AS job1_name, rank AS job1_rank, orga AS job2_name, rank AS job2_rank FROM players_jobs WHERE uuid = '${result.uuid}';`;	
                                    con.query(sql_job, (err, res)=>{
                                        if (err) console.log(err.message);
                                        if(res.length >= 1){
                                            result.job1_name = res[0].job1_name;
                                            result.job1_rank = res[0].job1_rank;
                                            
                                            embed.addFields(
                                                {name : "Métier 1", value : result.job1_name + " (" + result.job1_rank + ")", inline : true},
                                            )
                                                
                                            result.job2_name = res[0].job2_name;
                                            result.job2_rank = res[0].job2_rank;
                                            
                                            embed.addFields(
                                                {name : "Métier 2", value : result.job2_name + " (" + result.job2_rank + ")", inline : true}
                                            )
                                        }
                                        var sql_orga = `SELECT orga.id AS "Id Orga", orga.name AS 'Name', orga_r.name AS 'Rank' FROM organisation AS orga, organisation_member AS orga_m, organisation_rank AS orga_r WHERE orga.id = orga_m.organisation_id AND orga_m.rank_id = orga_r.id AND orga_m.uuid = '${result.uuid}';`;
                                        con.query(sql_orga, (err, res)=>{
                                            if (err) console.log(err.message);
                                            if(res.length == 1){
                                                result.organizationId = res[0]["Id Orga"];
                                                result.organizationName = res[0]["Name"];
                                                result.organizationRank = res[0]["Rank"];
                                                
                                                embed.addFields(
                                                    {name : "Organisation", value : result.organizationName + (" (" + result.organizationId + ")"), inline : true},
                                                    {name : "Grade", value : result.organizationRank, inline : true},
                                                )
                                            }
                                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                            message.channel.send(embed); 
                                        });   
                                    });
                                        //message.channel.send(`Identifiant : ${res[0].identifier}\nUUID : ${res[0].uuid}\nNom : ${res[0].first_name} \nPrénom : ${res[0].last_name}\nNuméro de téléphone : ${res[0].phone_number}\nGroupe : ${res[0].group}\nBanque : ${res[0].Money + " $"}`)
                                });
                            } else {
                                message.channel.send("Aucun résultat pour cette recherche `" + args[1] + (args[2] !== undefined ? args[2] : "") +"`");
                            }
                        })
                } else if (args[0] == "plate") {
                    // select uuid owner
                    if (args[1] != undefined) {
                        var sql = `SELECT uuid, pound, label, plate_identifier FROM players_vehicles WHERE plate = '${args[1]}';`;
                        con.query(sql, (err, res)=>{
                            if (err) console.log(err.message);
                            if(res != undefined && res.length == 1){
                                var result = res[0];

                                var embed = new Discord.MessageEmbed()
                                .setTitle("Informations sur le véhicule ["+args[1]+"]")
                                .setColor(discordColor)

                                var sql = `SELECT pi.first_name AS first_name, pi.last_name AS last_name, u.identifier AS identifier, u.uuid AS uuid FROM players_identity AS pi, users AS u WHERE u.uuid = pi.uuid AND pi.uuid LIKE '${result.uuid}%';`;
                                con.query(sql, (err, res)=>{
                                    if (err) console.log(err.message);
                                    if(res.length == 1){
                                        embed.addFields(
                                            {name : "Nom du propriétaire", value : res[0].last_name, inline: true},
                                            {name : "Prénom du propriétaire", value : res[0].first_name, inline: true},
                                            {name : "Identifiant du propriétaire", value : res[0].identifier},
                                            {name : "UUID du propriétaire", value : res[0].uuid},
                                        )
                                            
                                        var sql_more_details = `SELECT pound FROM players_vehicles WHERE plate = '${args[1]}';`;
                                        con.query(sql_more_details, (err, res)=>{   
                                            if (err) console.log(err.message);
                                            if(res.length == 1 && res[0].pound == 1){
                                                result.pounded = res[0].pound;
                                                embed.addFields(
                                                    {name : "Position : ", value : "En fourrière", inline: true}
                                                )
                                                embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                message.channel.send(embed);
                                            } else {
                                                sql_more_details_2 = `SELECT uuid AS uuidPlayerPuttedVehicle, garage FROM players_parking WHERE plate LIKE '%${result.plate_identifier}%';`;
                                                con.query(sql_more_details_2, (err, res)=>{
                                                    if (err) console.log(err.message);
                                                    // To do : clean players_parking when duplicates
                                                    if(res.length >= 1){
                                                        result.uuidPlayerPuttedVehicle = res[0].uuidPlayerPuttedVehicle;
                                                        result.garage = res[0].garage;
                                                        embed.addFields(
                                                            {name : "Position : ", value : result.garage, inline: true}
                                                        )

                                                        var sql_more_details_3 = `SELECT first_name, last_name FROM players_identity WHERE uuid = '${result.uuidPlayerPuttedVehicle}';`;
                                                        con.query(sql_more_details_3, (err, res)=>{
                                                            if (err) console.log(err.message);
                                                            if(res.length == 1){
                                                                embed.addFields(
                                                                    {name : "Mis dans le garage par : ", value : (res[0].first_name.charAt(0).toUpperCase() + res[0].first_name.slice(1) + " " + res[0].last_name.toUpperCase()), inline: true}
                                                                )
                                                            }
                                                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                            message.channel.send(embed);
                                                        })
                                                    } else {
                                                        embed.addFields(
                                                            {name : "Position : ", value : "Impossible de la trouver", inline: true}
                                                        )
                                                        
                                                        embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                        message.channel.send(embed);
                                                    }

                                                })
                                            }

                                        })
                                    } else {
                                        sql_company = `SELECT label FROM business WHERE label = '${result.uuid}';`;
                                        con.query(sql_company, (err, res)=>{
                                            if (err) console.log(err.message);
                                            if(res.length == 1){
                                                result.company = res[0].name;
                                                embed.setDescription("Le propriétaire de ce véhicule est un entreprise : **" + result.company + "**");

                                                var sql_more_details = `SELECT pound FROM players_vehicles WHERE plate = '${args[1]}';`;
                                                con.query(sql_more_details, (err, res)=>{
                                                    if (err) console.log(err.message);
                                                    if(res.length == 1){
                                                        result.pounded = res[0].pound;
                                                        embed.addFields(
                                                            {name : "Position : ", value : "En fourrière", inline: true}
                                                        )
                                                        embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                        message.channel.send(embed);
                                                    } else {
                                                        sql_more_details_2 = `SELECT uuid AS uuidPlayerPuttedVehicle, garage FROM players_vehicles WHERE plate LIKE '%${args[1]}%';`;
                                                        con.query(sql_more_details_2, (err, res)=>{
                                                            if (err) console.log(err.message);
                                                            if(res.length == 1){
                                                                result.uuidPlayerPuttedVehicle = res[0].uuidPlayerPuttedVehicle;
                                                                result.garage = res[0].garage;
                                                                embed.addFields(
                                                                    {name : "Position : ", value : "Garage : " + result.garage, inline: true}
                                                                )

                                                                var sql_more_details_3 = `SELECT first_name, last_name FROM players_identity WHERE uuid = '${result.uuidPlayerPuttedVehicle}';`;
                                                                con.query(sql_more_details_3, (err, res)=>{
                                                                    if (err) console.log(err.message);
                                                                    if(res.length == 1){
                                                                        embed.addFields(
                                                                            {name : "Mis dans le garage par : ", value : (res[0].last_name.charAt(0).toUpperCase() + res[0].last_name.slice(1) + " " + res[0].first_name.toUpperCase()), inline: true}
                                                                        )
                                                                    }

                                                                    embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                                    message.channel.send(embed);

                                                                })
                                                            }
                                                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                            message.channel.send(embed);
                                                        })
                                                    }
                                                })

                                            }
                                        })
                                    }
                                })
                            } else {
                                message.channel.send("Aucun véhicule ne correspond à cette plaque");
                            }
                        });
                    } else {
                        var helpMsg = "<@"+message.author.id+">\n"+
                        "Pour utiliser cette commande, veuillez entrer un argument :\n"+                        
                        "`.info plate [plaque]`\n"
                        message.channel.send(helpMsg);
                    }
                } else if (args[0] == "bank") {
                    if (args[1] != undefined) {
                        var sql = `SELECT label, uuid AS uuid_owner, coowner AS uuid_coowner FROM banking_account WHERE iban = '${args[1]}';`;
                        con.query(sql, (err, res)=>{
                            if (err) console.log(err.message);
                            if(res.length == 1){
                                var result = {}
                                result.label = res[0].label;
                                result.uuid_owner = res[0].uuid_owner;
                                result.uuid_coowner = res[0].uuid_coowner;
                                var embed = new Discord.MessageEmbed()
                                    .setColor(discordColor)
                                    .setTitle("Informations sur la banque")
                                embed.setDescription("Le compte bancaire  : **" + args[1] + "**");
                                embed.addFields(
                                    {name : "Nom du compte : ", value : result.label}
                                )

                                if (result.uuid_owner != null) {
                                    sql_owner = `SELECT first_name, last_name FROM players_identity WHERE uuid = '${result.uuid_owner}';`;
                                    con.query(sql_owner, (err, res)=>{
                                        if (err) console.log(err.message);
                                        if(res.length == 1){
                                            embed.addFields(
                                                {name : "Nom du propriétaire : ", value : res[0].last_name, inline: true },
                                                {name : "Prénom du propriétaire : ", value : res[0].first_name, inline: true },
                                                {name : "Propriétaire UUID : ", value : result.uuid_owner, inline: true}
                                            )
                                        }
                                        if (result.uuid_coowner != null) {
                                            var sql_coowner = `SELECT first_name, last_name FROM players_identity WHERE uuid = '${result.uuid_coowner}';`;
                                            con.query(sql_coowner, (err, res)=>{
                                                if (err) console.log(err.message);
                                                if(res.length == 1){
                                                    embed.addFields(
                                                        embed.addFields(
                                                            {name : "Nom du co-prop : ", value : res[0].last_name, inline: true},
                                                            {name : "Prénom du co-prop : ", value : res[0].first_name, inline: true},
                                                            {name : "Co-prop UUID : ", value : result.uuid_coowner, inline: true}
                                                        )
                                                    )
                                                }
                                                embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                                message.channel.send(embed);
                                            })
                                        } else {
                                            embed.addFields(
                                                {name : "Co-propriétaire : ", value : "Aucun"}
                                            )
                                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                            message.channel.send(embed);
                                        }
                                    })
                                } else {
                                    embed.addFields(
                                        {name : "Propriétaire : ", value : "Aucun"}
                                    )
                                    if (result.coowner != null) {
                                        var sql_coowner = `SELECT first_name, last_name FROM players_identity WHERE uuid = '${result.uuid_coowner}';`;
                                        con.query(sql_coowner, (err, res)=>{
                                            if (err) console.log(err.message);
                                            if(res.length == 1){
                                                embed.addFields(
                                                    embed.addFields(
                                                        {name : "Nom du co-prop : ", value : res[0].last_name, inline: true},
                                                        {name : "Prénom du co-prop : ", value : res[0].first_name, inline: true},
                                                        {name : "Co-prop UUID : ", value : result.uuid_coowner, inline: true}
                                                    )
                                                )
                                            }
                                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                            message.channel.send(embed);
                                        })
                                    } else {
                                        embed.addFields(
                                            {name : "Co-propriétaire : ", value : "Aucun"}
                                        )
                                        embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                        message.channel.send(embed);
                                    }
                                }
                            } else {
                                message.channel.send("Aucun compte ne correspond à cette IBAN");
                            }
                        })
                    } else {
                        var helpMsg = "<@"+message.author.id+">\n"+
                        "Pour utiliser cette commande, veuillez entrer un argument :\n"+                        
                        "`.info bank [IBAN]`\n"
                        message.channel.send(helpMsg);
                    }
                } else if (args[0] == "num") {
                    //
                    if (args[1] != undefined) {
                        var sql = `SELECT first_name, last_name FROM players_identity, players_inventory WHERE players_identity.uuid = players_inventory.uuid AND players_inventory.inventory LIKE '%"num":"${args[1]}"%';`;
                        con.query(sql, (err, res)=>{
                            if (err) console.log(err.message);
                            if(res.length == 1){
                                var embed = new Discord.MessageEmbed()
                                    .setColor(discordColor)
                                    .setTitle("Informations sur le numéro")
                                embed.setDescription("Le numéro  : **" + args[1] + "**");
                                embed.addFields(
                                    {name : "Nom du propriétaire : ", value : res[0].last_name, inline: true },
                                    {name : "Prénom du propriétaire : ", value : res[0].first_name, inline: true }
                                )
                                embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                                message.channel.send(embed);
                            } else {
                                message.channel.send("Erreur sur l'obtention du propriétaire du numéro");
                            }
                        })
                    } else {
                        var helpMsg = "<@"+message.author.id+">\n"+
                        "Pour utiliser cette commande, veuillez entrer un argument :\n"+                        
                        "`.info num [numéro]`\n"
                        message.channel.send(helpMsg);
                    }
                } else if (args[0] == "help") {
                    var helpMsg = "<@"+message.author.id+">\n"+
                    "Pour utiliser cette commande :\n"+
                    "`.info id <[nom prénom][prénom nom][steam][uuid]>`\n"+
                    "`.info plate [plaque]`\n"+
                    "`.info bank [iban]`\n"+
                    "`.info num [numéro]`"
                    message.channel.send(helpMsg);
                }
            } else {
                var helpMsg = "<@"+message.author.id+">\n"+
                    "Pour utiliser cette commande, veuillez entrer des arguments :\n"+
                    "`.info id <[nom prénom][prénom nom][steam][uuid]>`\n"+
                    "`.info plate [plaque]`\n"+
                    "`.info bank [iban]`\n"+
                    "`.info num [numéro]`"
                message.channel.send(helpMsg);
            }
        }
        if (command == "orga") {
            if (args.length == 0) {
                message.channel.send("**Pour utiliser la commande (<@"+message.author.id+">) :**\n.orga list > Liste des organisations\n.orga member <nom/id> > Informations sur l'organisation");
            }

            if (args[0] == "list") {
                var sql = `SELECT orga.id, orga.name, orga.label, COUNT(orga_m.uuid) AS memberCount FROM organisation AS orga, organisation_member AS orga_m WHERE orga.id = orga_m.organisation_id GROUP BY orga.id, orga.name, orga.label ORDER by orga.id;`;
                con.query(sql, (err, res)=>{
                    if (err) console.log(err.message);
                    if(res.length == 0){
                        message.channel.send("Aucune organisation");
                    } else {
                        var embed = new Discord.MessageEmbed()
                            .setColor(discordColor)
                            .setTitle("Liste des organisations")
                        var text = "[id] - **[nom]** - [label]\n\n";
                            for (var i = 0; i < res.length; i++) {
                            text = text + ""+ res[i].id + " - **" + res[i].name + "** - (" + res[i].label + ") - *"+res[i].memberCount+" membre(s)*\n"
                        }
                        embed.setDescription(text);
                        embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                        message.channel.send(embed);
                    }
                })
            } else if (args[0] == "members") {
                var sql = "SELECT id, name FROM organisation WHERE (id LIKE '" + args[1] + "' OR name LIKE '"+args[1]+"');";
                con.query(sql, (err, res)=>{
                    if (err) console.log(err.message);
                    if(res.length == 1){
                        var id = res[0].id;
                        var name = res[0].name;
                        var sql = `SELECT first_name, last_name, players_identity.uuid, organisation_rank.name AS rank_label FROM players_identity, organisation_member, organisation, organisation_rank WHERE organisation_member.rank_id = organisation_rank.id AND organisation.id = organisation_member.organisation_id AND players_identity.uuid = organisation_member.uuid AND ((organisation_member.organisation_id = '${args[1]}') OR (organisation.name LIKE '${args[1]}')) ORDER BY organisation_rank.id ASC;`;
                        con.query(sql, (err, res)=>{
                            if (err) console.log(err.message);
                            if(res.length == 0){
                                message.channel.send("Aucun membre dans l'organisation");
                            } else {
                                var embed = new Discord.MessageEmbed()
                                    .setColor(discordColor)
                                    .setTitle("__Liste des membres de l'organisation " + name + " (" + id + ")__")
                                var text = "[NOM Prénom] - [Rang] - [uuid]\n\n";
                                for (var i = 0; i < res.length; i++) {
                                    text = text + ""+ res[i].last_name.toUpperCase() + " " + res[i].first_name + " - " + res[i].rank_label.toUpperCase() + " - " + res[i].uuid + "\n"
                                }
                            }
                            embed.setDescription(text);
                            embed.setTimestamp().setFooter("© "+message.guild.name, message.guild.iconURL());
                            message.channel.send(embed);
                        })
                    } else {
                        message.channel.send("Erreur sur l'obtention du nom de l'organisation");
                    }
                })
            }

        }
        if (command == "set") {
            if (args.length == 0) {
                message.channel.send("**Pour utiliser la commande (<@"+message.author.id+">) : **\n`.set job <1/2> <identifier/uuid> <job> <rank>` Pour définir le job (1 ou 2) d'un joueur.")
            }

            if (args[0] == "job") {
                if (args[1] == 1 || args[1] == 2) {
                    var sql = ""
                    if (args[1] == 1) {
                        sql = `UPDATE players_jobs SET job = ${args[3]}, rank = ${args[4]} WHERE (uuid = ${args[2]} OR uuid = (SELECT uuid FROM users WHERE (identifier = ${args[2]}));`;
                    } else {
                        sql = `UPDATE players_jobs SET orga = ${args[3]}, orga_rank = ${args[4]} WHERE (uuid = ${args[2]} OR uuid = (SELECT uuid FROM users WHERE (identifier = ${args[2]}))`;
                    }
                    con.query(sql, (err, res)=>{
                        if (err) console.log(err.message);
                        if(res.length == 1){
                            message.channel.send("Le job a bien été défini");
                        }
                    })
                } else {
                    message.channel.send("**Pour utiliser la commande (<@"+message.author.id+">) : **\n`.set job <1/2> <identifier/uuid> <job> <rank>` Pour définir le job (1 ou 2) d'un joueur.")
                }
            }
        }
    }
);

client.login(config.token);

client.on("ready", (message) => {
    client.channels.cache.get("962003138905264169").send("Le bot est en ligne ! :white_check_mark:")
});

