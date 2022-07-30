const app = require('express')();

app.get('/', (req, res) => {
  res.send('Hello, World!\n');
});

app.get('/health', (req, res) => {
  res.send(`I'm alive!\n`);
});

app.listen(8080, '0.0.0.0');
console.log('app listening on port 8080');
