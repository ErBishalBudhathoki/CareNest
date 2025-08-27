const fs = require('fs');
const csv = require('csv-parser');
const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config({ path: __dirname + '/.env' });

const uri = process.env.MONGODB_URI;
const csvFilePath = __dirname + '/NDIS.csv';

function parseBool(val) {
  if (typeof val === 'string') {
    return val.trim().toUpperCase() === 'Y';
  }
  return false;
}

function parsePrice(val) {
  if (!val || val === 'NA') return null;
  return parseFloat(val.replace(/[$,]/g, ''));
}

function parseDate(val) {
  if (!val) return null;
  // Expecting YYYYMMDD or 99991231
  if (val === '99991231') return new Date('9999-12-31T00:00:00Z');
  if (val.length === 8) {
    return new Date(`${val.substring(0, 4)}-${val.substring(4, 6)}-${val.substring(6, 8)}T00:00:00Z`);
  }
  return new Date(val);
}

async function seed() {
  const items = [];
  fs.createReadStream(csvFilePath)
    .pipe(csv())
    .on('data', (row) => {
      const item = {
        supportItemNumber: row['Support Item Number'],
        supportItemName: row['Support Item Name'],
        registrationGroup: {
          number: row['Registration Group Number'],
          name: row['Registration Group Name'],
        },
        supportCategory: {
          number: row['Support Category Number'],
          name: row['Support Category Name'],
        },
        unit: row['Unit'],
        quoteRequired: (row['Quote'] || '').toLowerCase() === 'yes',
        startDate: parseDate(row['Start date']),
        endDate: parseDate(row['End Date']),
        supportType: row['Type'],
        rules: {
          allowNonFaceToFace: parseBool(row['Non-Face-to-Face Support Provision']),
          allowProviderTravel: parseBool(row['Provider Travel']),
          allowShortNoticeCancellation: parseBool(row['Short Notice Cancellations.']),
          ndiaRequiresQuote: parseBool(row['NDIA Requested Reports']),
          isIrregularSupport: parseBool(row['Irregular SIL Supports']),
        },
        priceCaps: {
          standard: {
            ACT: parsePrice(row['ACT']),
            NSW: parsePrice(row['NSW']),
            NT: parsePrice(row['NT']),
            QLD: parsePrice(row['QLD']),
            SA: parsePrice(row['SA']),
            TAS: parsePrice(row['TAS']),
            VIC: parsePrice(row['VIC']),
            WA: parsePrice(row['WA']),
          },
          highIntensity: {
            ACT: parsePrice(row['P01']),
            NSW: parsePrice(row['P01']),
            NT: parsePrice(row['P01']),
            QLD: parsePrice(row['P01']),
            SA: parsePrice(row['P01']),
            TAS: parsePrice(row['P01']),
            VIC: parsePrice(row['P01']),
            WA: parsePrice(row['P01']),
          },
        },
      };
      // If P02 exists, use it for highIntensity
      if (row['P02']) {
        item.priceCaps.highIntensity = {
          ACT: parsePrice(row['P02']),
          NSW: parsePrice(row['P02']),
          NT: parsePrice(row['P02']),
          QLD: parsePrice(row['P02']),
          SA: parsePrice(row['P02']),
          TAS: parsePrice(row['P02']),
          VIC: parsePrice(row['P02']),
          WA: parsePrice(row['P02']),
        };
      }
      items.push(item);
    })
    .on('end', async () => {
      let client;
      try {
        client = await MongoClient.connect(uri, { serverApi: ServerApiVersion.v1 });
        const db = client.db('Invoice');
        await db.collection('supportItems').deleteMany({}); // Clear old data
        await db.collection('supportItems').insertMany(items);
        console.log(`Seeded ${items.length} support items.`);
      } catch (err) {
        console.error('Error seeding support items:', err);
      } finally {
        if (client) await client.close();
      }
    });
}

seed();