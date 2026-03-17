const fs = require('fs');
const path = require('path');

const folders = [
  'src/config',
  'src/controllers',
  'src/routes',
  'src/services',
  'src/middlewares',
  'src/models'
];

folders.forEach(folder => {
  const dir = path.join(__dirname, folder);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
});
console.log('Backend folders created.');
