const express = require('express');
const holidayController = require('../controllers/holidayController');
const router = express.Router();

/**
 * Get all holidays
 * GET /getHolidays
 */
router.get("/getHolidays", holidayController.getAllHolidays);

/**
 * Upload CSV data from GitHub to MongoDB
 * Fetches holiday data from a remote CSV file and stores it in the database
 * POST /uploadCSV
 */
router.post("/uploadCSV", holidayController.uploadCSV);

/**
 * Delete a holiday by ID
 * DELETE /deleteHoliday/:id
 * @param {string} id - MongoDB ObjectId of the holiday to delete
 */
router.delete("/deleteHoliday/:id", holidayController.deleteHoliday);

/**
 * Add a new holiday
 * POST /addHolidayItem
 * @param {object} req.body - Holiday data (Holiday, Date, Day)
 */
router.post("/addHolidayItem", holidayController.addHoliday);

/**
 * Check if dates are holidays
 * POST /check-holidays
 * @param {string} req.body.dateList - Comma-separated list of dates to check
 * @returns {Array} Array of "Holiday" or "No Holiday" for each date
 */
router.post("/check-holidays", holidayController.checkHolidays);

module.exports = router;