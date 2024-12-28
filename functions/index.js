const { initializeApp } = require('firebase-admin/app');
const { getMessaging } = require('firebase-admin/messaging');
const { onDocumentCreated } = require('firebase-functions/v2/firestore');

// Initialize Firebase Admin SDK
initializeApp();

// Firestore Trigger
exports.myFunction = onDocumentCreated('chat/{messageId}', (event) => {
    const snapshot = event.data;

    if (!snapshot) {
        console.log('No data found in snapshot.');
        return null;
    }

    const messageData = snapshot.data();

    return getMessaging().send({
        notification: {
            title: messageData.username || 'New Message',
            body: messageData.text || 'You have a new message!',
        },
        data: {
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
        topic: 'chat',
    });
});
