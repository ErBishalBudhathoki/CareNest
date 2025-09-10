# Invoice Process Documentation

This document outlines the process of generating and managing invoices within the application.

## Directory Structure

The invoice-related features are organized within the `lib/app/features/invoice` directory. Here's a breakdown of the key subdirectories and their purpose:

- `controllers`: Contains controllers for handling invoice-related logic.
- `domain`: Defines the core domain models for invoices.
- `models`: Holds data models for invoices and related information.
- `presentation`: Includes UI components and widgets for invoice presentation.
- `repositories`: Manages data access for invoices.
- `services`: Implements business logic and utility functions for invoices.
- `viewmodels`: Provides ViewModels for managing invoice-related UI state.
- `views`: Contains the different views related to invoice generation and management.

## Key Services

- `invoice_service.dart`: Core service for invoice operations.
- `invoice_pdf_generator_service.dart`: Handles the generation of PDF invoices.
- `send_invoice_service.dart`: Manages sending invoices to users.
- `invoice_email_service.dart`: Deals with email-related functionalities for invoices.

## Key Views

- `generateInvoice.dart`: View for generating a single invoice.
- `generateInvoiceForAll.dart`: View for generating invoices for all users.
- `invoice_email_view.dart`: View for managing invoice email settings.

## Further Steps

- Document the specific functionalities within each service and view.
- Elaborate on the data flow and interactions between different components.
- Provide examples of how to use the invoice generation and sending features.

Here's the detailed flow for invoice generation based on the code analysis:

1. Data Collection :
   
   - Client data is retrieved from emailClientMap using client name
   - Key client details extracted:
     - Address, city, state, zip
     - Business name
     - Start/end dates from date list
     - Total hours worked
2. Data Processing :
   
   - Client details are formatted for PDF display
   - Financial calculations performed (total hours, amounts)
   - Bank details are hardcoded (Commonwealth Bank account)
3. PDF Generation :
   
   - Uses pdf package to create document
   - Structured with:
     - Header section (invoice title, ABN, dates)
     - Billing information (client details)
     - Invoice number and job title
     - Table layout for financial data
4. Styling :
   
   - Custom borders and alignment
   - Font sizing and weights for emphasis
   - Proper spacing between sections
Key modified data:

- Client address components concatenated
- Dates formatted (dd-MM-yyyy)
- Hours converted to decimal format
- Financial amounts formatted to 2 decimal places
The complete PDF generation happens in the generatePdfForClient method which returns a pw.Document object ready for saving or sending.