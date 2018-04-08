// Update for main app-admin database initialization
const MongoClient = require('mongodb').MongoClient;
const url = 'mongodb://localhost:27017/hellodb';

const insertDocuments = (db, cb) => {
  const coll = db.collection('people');
  coll.insertMany([
    {name:'John Doe', age:24},
    {name:'Sam Fisher', age:36},
    {name:'Harry Potter', age:29},
    {name:'Hello Kitty', age:999}
  ], (err, res) => cb(res));
};

MongoClient.connect(url, (err, client) => insertDocuments(client.db('hellodb'), () => client.close()));
