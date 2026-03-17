const fs = require('fs');
const path = require('path');

const folders = [
  'lib/core/theme',
  'lib/core/router',
  'lib/core/network',
  'lib/core/utils',
  'lib/features/home',
  'lib/features/services',
  'lib/features/shop',
  'lib/features/learn',
  'lib/features/account',
  'lib/shared/widgets'
];

folders.forEach(folder => {
  const dir = path.join(__dirname, folder);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
});
console.log('Frontend folders created.');
