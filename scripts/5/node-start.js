// Update this file so the host-app application will be hosted here
var path = require('path');
var express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const http = require('http');
var helmet = require('helmet')
const MongoClient = require('mongodb').MongoClient;

function getData(cb) {
  const url = 'mongodb://localhost:27017/hellodb';
  MongoClient.connect(url, (err, client) => {
    const db = client.db('hellodb');
    const coll = db.collection('people');
    coll.find({}).toArray((err, ppl) => {
      cb(ppl);
      client.close();
    });
  });
}

function runServer() {
  const app = express();
  const server = http.createServer(app);
  app.use(bodyParser.json());
  app.use(cors());
  app.use(helmet())
  app.options('*', cors());
  app.get('/', (req, res) => res.send('Hello stranger'));
  app.get('/api/data', (req, res) => getData((ppl) => res.json(ppl)));
  app.get('*', (req, res) => res.status(404).send('You lost, dude???'));
  server.listen(process.env.PORT);
}

runServer();
