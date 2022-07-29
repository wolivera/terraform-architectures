const app = require('express')();

app.get('/', (req, res) => {
  res.send('Hello, World!\n');
});

app.listen(3000, '0.0.0.0');
console.log('app listening on port 8080');
