const fs = require('fs');

const imagesJson = JSON.parse(fs.readFileSync('images/wizards/images.json', 'utf-8'));
const numImages = imagesJson.images.length;

const quotesJson = JSON.parse(fs.readFileSync('quotes.json', 'utf-8'));
const numQuotes = quotesJson.quotes.length;

const totalCombinations = numImages * numQuotes;

let readme = fs.readFileSync('README.md', 'utf-8');
readme = readme.replace(/with ~[0-9,]+ \(as of writing\) unique possibilities./, `with ~${totalCombinations.toLocaleString()} (as of writing) unique possibilities.`);
fs.writeFileSync('README.md', readme);
