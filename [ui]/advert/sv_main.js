
const Discord = require("fx-discord");
const client = new Discord.Client();


client.on("message", async message => {
    if(message.content.indexOf("!") !== 0) return;
  
    // Here we separate our "command" name, and our "arguments" for the command. 
    // e.g. if we have the message "+say Is this the real life?" , we'll get the following:
    // command = say
    // args = ["Is", "this", "the", "real", "life?"]
    const args = message.content.slice(1).trim().split(/ +/g);
    var auth =   message.guild.member(message.author).displayName
    const command = args.shift().toLowerCase();
  if (command == "advert") {
    var Attachment = (message.attachments).array();
    var pp = undefined;
    if (Attachment[0]!==undefined){
      pp = Attachment[0].url;
    }
    var t = [message.content.replace("!advert",""),pp,auth]
    emitNet("advert:AddAdvert", -1,JSON.stringify(t));
  }
});

client.login("NzA3NzI0MjAwOTUyOTg3Njcw.XsHsUw.JdwKt-OPDnuuunljYkCU43GOPz4");