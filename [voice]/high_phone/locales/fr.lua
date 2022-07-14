Config.Languages["fr"] = {
    ["notifications"] = {
        -- Bank
        ["selftransfer"] = "Vous ne pouvez pas envoyer de l'argent à vous-même",
        ["selfrequest"] = "Vous ne pouvez pas vous réclamer de l'argent",
        ["receivedmoney"] = "Vous avez reçu <strong>{amount} $</strong> de la part de l'ID <strong>{senderId}</strong>! Libellé : <strong>{reason}</strong>",
        ["requestedmoney"] = "<strong>{requesterName} [{requesterId}]</strong> vous réclame <strong>{amount} $</strong>! Motif : <strong>{reason}</strong>",
        ["receivernonexistant"] = "Cet utilisateur n'existe pas",
        ["notenoughmoney"] = "Vous n'avez pas suffisamment d'argent",
        ["requestdoesntexist"] = "Cette demande n'existe pas",
        ["requestcooldown"] = "Vous ne pouvez pas réclamer de virement aussi vite",
        ["transfercooldown"] = "Vous ne pouvez pas faire de virement aussi vite",
        ["playernotonline"] = "L'utilisateur de cet ID est indisponible",
        ["playernotonlineanymore"] = "L'utilisateur n'est pas disponible pour le moment",
        -- Phone
        ["userbusy"] = "Votre correspondant est occupé",
        ["usernotavailable"] = "Votre correspondant est indisponible ",
        ["noavailableunits"] = "Le service que vous avez demandé n'est pour le moment pas disponible",
        -- Twitter/mail
        ["accountdoesntexist"] = "Cette adresse n'existe pas",
        ["emailtaken"] = "Cette adresse est déjà utilisée",
        ["usernametaken"] = "Ce nom est déjà utilisé",
        ["userdoesntexist"] = "Ce compte n'existe pas",
        ["wrongpassword"] = "Mauvaise mot de passe",
        ["wrongresetcode"] = "Code incorrect",
        -- Dark chat
        ["invitedoesntexist"] = "Cette invitation n'existe pas",
        ["alreadyingroup"] = "Vous avez déjà rejoint ce groupe",
        ["bannedfromgroup"] = "Vous avez été banni du groupe",
        ["groupmemberlimitreached"] = "Limite de membres du groupe atteinte",
        ["member_joined"] = "<strong>{memberName}</strong> a rejoint le groupe",
        ["member_left"] = "<strong>{memberName}</strong> a quitté le groupe",
        ["member_banned"] = "<strong>{memberName}</strong> a été banni du groupe",
        ["member_kicked"] = "<strong>{memberName}</strong> a été viré du groupe",
    },
    -- Other
    ["open_phone"] = "Ouvrir le téléphone",
    ["deleted_user"] = "Deleted User",
    ["unknown"] = "Inconnu",
    ["unknown_caller"] = "Numéro masqué",
    ["newtweetwebhook"] = {
        ["title"] = "📢 Nouveau tweet de {senderTwitterName} ({senderName} [**{senderId}**])!",
        ["replying"] = "Répondre à @{tweeterName}",
        ["footer"] = "ora-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["tweetreportwebhook"] = {
        ["title"] = "📢 Le tweet {tweetId} posté par {tweeterName} a été signalé par {reporterTwitterName} ({reporterName} [**{reporterId}**])!",
        ["footer"] = "ora-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newmailwebhook"] = {
        ["title"] = "📧 Nouveau mail de **{senderMailAddress}** ({senderName} [**{senderId}**])!",
        ["description"] = "À : **{recipients}**\nObjet : **{subject}**\nMail : **{content}**",
        ["footer"] = "ora-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newadwebhook"] = {
        ["title"] = "📢 New Advertisment from **{senderFullname}** ({senderName} **{senderId}**)!",
        ["footer"] = "ora-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["newtransactionwebhook"] = {
        ["title"] = "💸 **Virement reçu**",
        ["description"] = "Émetteur : **{senderName}** [**{senderId}**] Bénéficiaire : **{receiverName}** [**{receiverId}**]\nObjet : **{reason}**\nMontant : **{amount} $**",
        ["footer"] = "ora-phone v" .. GetResourceMetadata(GetCurrentResourceName(), "version")
    },
    ["twitterresetmail"] = {
        ["senderAddress"] = "noreply@twitter.com",
        ["senderName"] = "Twitter",
        ["senderPhoto"] = "media/icons/twitter.png",
        ["subject"] = "Compte réinitialisé",
        ["content"] = "Bonjour,<br><br>Il semblerait que vous ayez perdu votre compte. Voici votre code de récupération : <br><br><strong>{resetCode}</strong><div class='footer twt'>@ 2022 Twitter.com. All rights reserved</div>"
    }
}