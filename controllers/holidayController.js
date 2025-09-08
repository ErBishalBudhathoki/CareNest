const HolidayService = require('../services/holidayService');
const logger = require('../config/logger');

class HolidayController {
  /**
   * Get all holidays
   * GET /getHolidays
   */
  static async getAllHolidays(req, res) {
    try {
      const holidays = await HolidayService.getAllHolidays();
      res.status(200).json(holidays);
    } catch (err) {
      logger.error('Error in getHolidays endpoint', {
        error: err.message,
        stack: err.stack
      });
      res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
  }

  /**
   * Upload CSV data from GitHub to MongoDB
   * POST /uploadCSV
   */
  static async uploadCSV(req, res) {
    try {
      const result = await HolidayService.uploadCSVData();
      res.status(200).json(result);
    } catch (err) {
      logger.error('Error in uploadCSV endpoint', {
        error: err.message,
        stack: err.stack
      });
      res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
  }

  /**
   * Delete a holiday by ID
   * DELETE /deleteHoliday/:id
   */
  static async deleteHoliday(req, res) {
    try {
      const id = req.params.id;
      const result = await HolidayService.deleteHoliday(id);
      res.status(200).json(result);
    } catch (err) {
      logger.error('Error in deleteHoliday endpoint', {
        error: err.message,
        stack: err.stack,
        holidayId: req.params.id
      });
      
      if (err.message === "Invalid holiday ID format") {
        return res.status(400).json({
          success: false,
          message: err.message
        });
      }
      
      if (err.message === "Holiday not found") {
        return res.status(404).json({
          success: false,
          message: err.message
        });
      }
      
      res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
  }

  /**
   * Add a new holiday
   * POST /addHolidayItem
   */
  static async addHoliday(req, res) {
    try {
      const result = await HolidayService.addHoliday(req.body);
      res.status(200).json(result);
    } catch (err) {
      logger.error('Error in addHolidayItem endpoint', {
        error: err.message,
        stack: err.stack,
        holidayData: req.body
      });
      
      if (err.message === "Missing required fields" || 
          err.message === "Invalid date format. Use DD-MM-YYYY") {
        return res.status(400).json({
          success: false,
          message: err.message
        });
      }
      
      if (err.message === "A holiday already exists on this date") {
        return res.status(409).json({
          success: false,
          message: err.message
        });
      }
      
      res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
  }

  /**
   * Check if dates are holidays
   * POST /check-holidays
   */
  static async checkHolidays(req, res) {
    try {
      const { dateList } = req.body;
      const result = await HolidayService.checkHolidays(dateList);
      res.status(200).json(result);
    } catch (err) {
      logger.error('Error in check-holidays endpoint', {
        error: err.message,
        stack: err.stack,
        dateList: req.body.dateList
      });
      
      if (err.message === "Missing dateList parameter") {
        return res.status(400).json({
          success: false,
          message: err.message
        });
      }
      
      res.status(500).json({
        success: false,
        message: "Internal Server Error",
        error: process.env.NODE_ENV === 'development' ? err.message : undefined
      });
    }
  }
}

module.exports = HolidayController;