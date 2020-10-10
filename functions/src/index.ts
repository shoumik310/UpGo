 import admin = require('firebase-admin')
import * as functions from 'firebase-functions'
admin.initializeApp(functions.config().firebase)

 export const sendNotification = functions.database.ref('/notification').onUpdate((change,context) => {
    const before = change.before.val()
    const after = change.after.val()
    const payload = {
        notification:{
            title: 'ALERT!!',
            body: 'A Fall Has Occured',
            image: 'https://img.icons8.com/color/48/000000/falling-person.png'
        }
    }

    if(before.test === after.text){
        console.log("Text didn't change")
        return null
    }

    const token ="c_Ge-fALTjC3tJLf3fCcb_:APA91bHRTnl-em6hnkKeZ19kQtRopdetReAQs8JQM7e3sCBb1bPbp5SPLA_YQbzJVxSUdeAQfIhEBGTq9CUI8awuqLDtN15rTAEUcMCgdPxLgl-11K0BtqJk88jm7k9rhJJ1xoYnqb4q"
    return admin.messaging().sendToDevice(token,payload).then(function(response){
        console.log('Notification sent successfully:',response)
    }).catch(function(error){
        console.log('Notification sent failed:',error)
    })
 })
