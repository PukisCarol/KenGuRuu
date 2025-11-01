const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function runLoadTest() {
  const userCount = 1000;
  const promises = [];

  const start = Date.now();

  for (let i = 0; i < userCount; i++) {
    const data = {
      userId: `user_${i}`,
      timestamp: new Date(),
      entry: `Test entry ${i}`,
    };
    promises.push(db.collection("load_test_entries").add(data));
  }

  await Promise.all(promises);

  const end = Date.now();
  const durationSec = (end - start) / 1000;

  console.log(`${userCount} writes completed`);
  console.log(`Total Time: ${durationSec.toFixed(2)} seconds`);
  console.log(`Response Time: ${(durationSec / userCount).toFixed(5)}`);
  console.log(`Throughput: ${(userCount / durationSec).toFixed(2)} ops/sec`);
}

runLoadTest().catch(console.error);