/**
 * Check the actual expense date from the task.md timestamp
 */

// From task.md: "expenseDate":{"$date":{"$numberLong":"1753358992499"}}
const timestamp = 1753358992499;
const expenseDate = new Date(timestamp);

console.log('Expense timestamp:', timestamp);
console.log('Expense date:', expenseDate.toISOString());
console.log('Expense date (local):', expenseDate.toString());
console.log('Expense date (YYYY-MM-DD):', expenseDate.toISOString().split('T')[0]);

// Let's also check current date for reference
const now = new Date();
console.log('\nCurrent date:', now.toISOString());
console.log('Current date (YYYY-MM-DD):', now.toISOString().split('T')[0]);

// Calculate appropriate date range
const startDate = new Date(expenseDate);
startDate.setDate(startDate.getDate() - 1); // One day before
const endDate = new Date(expenseDate);
endDate.setDate(endDate.getDate() + 1); // One day after

console.log('\nSuggested date range:');
console.log('Start date:', startDate.toISOString().split('T')[0]);
console.log('End date:', endDate.toISOString().split('T')[0]);