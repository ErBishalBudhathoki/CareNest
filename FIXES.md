Lets have automatic clamping as price should never go bayond capped price. That is against NDIS.
For time boundries also yes but for Monn-Sunday. and you should also focus on:
Yes, there are different pricing arrangements for supports delivered on Saturday and Sunday, but the hourly pricing structure generally differs from the breakdown used during the week.

The NDIS Pricing Arrangements and Price Limits 2024-25 document defines prices based on the **day of the week** the support is provided.

### Hourly Support Pricing on Weekends

For standard hourly supports (such as Assistance With Self-Care Activities or Assistance in Supported Independent Living), the document generally sets a **single, elevated price limit** that applies to the entire 24-hour period of the weekend day, rather than breaking it down into separate Daytime, Evening, and Night rates like it does for weekdays.

For NDIS claiming purposes, a **Saturday Support** is defined as any support that starts at or after midnight on the night prior to a Saturday and ends before or at midnight of that Saturday (unless it is a Public Holiday or Night-time Sleepover Support). A **Sunday Support** is defined similarly, starting at or after midnight on the night prior to Sunday and ending before or at midnight of that Sunday (unless it is a Public Holiday or Night-time Sleepover Support).

This contrasts with weekdays, which have separate price limits for:
*   Weekday Daytime Support (starting 6:00 am and ending 8:00 pm).
*   Weekday Evening Support (starting 8:00 pm and finishing at or before midnight).
*   Weekday Night Support (commencing at or before midnight and finishing after midnight, or commencing before 6:00 am).

**Example Standard Hourly Rates (National MMM 1-3) for Assistance with Self-Care Activities:**

| Day/Time | Price Limit | Source |
| :--- | :--- | :--- |
| Weekday Daytime | $67.56 per hour | |
| Weekday Night | $75.82 per hour | |
| **Saturday** (Any Time) | **$95.07 per hour** | |
| **Sunday** (Any Time) | **$122.59 per hour** | |

*(Note: The multiplier calculated in the previous response reflects that the weekend rate is substantially higher than the weekday day rate, incorporating the necessary shift loadings for these days.)*

### Exception: Night-Time Sleepover Support

The one key exception regarding overnight support is the specific item for **Night-Time Sleepover Support**.

*   This support applies to **any day of the week**, including Saturday and Sunday, and has a fixed price limit rather than an hourly rate.
*   It covers a continuous period of eight (8) hours or more where the worker is allowed to sleep when not actively providing support, and includes up to two hours of active support.
*   The fixed price limit for a standard Night-Time Sleepover Support is **$286.56 per *Each*** (National rate).
*   If more than two hours of active support are provided during the sleepover, providers may claim for the third or additional hour at the **applicable Saturday, Sunday or Public Holiday rates**.

Lets have a UI to set base rate and with differenrt support item number.
This is an insightful question that highlights an important distinction within the NDIS pricing framework.

When NDIS **service price limits are absent** for a specific support item, the baseline is established through negotiation and agreement, underpinned by the principle of *reasonable pricing*.

Here is an explanation of the baseline and mechanism applied when service rates are not subject to price control:

### 1. The Principle of Agreement on a Reasonable Price

For supports that **do not have a price limit** (i.e., those that are "not subject to price control"), the fundamental requirement is that the **provider and participant must agree on the reasonable price for the support**.

*   **Provider Responsibility:** The NDIS does not set the prices providers charge. When a price limit is absent, providers must agree the price for the support with the participant.
*   **Reasonable and Necessary:** Regardless of whether a support has a price limit, it must still be determined that the support is **reasonable and necessary** to meet the participant's needs to be claimed from their plan.
*   **Service Agreement:** The agreed-upon reasonable price, including the cost of the supports and the billing schedule, should be explicitly set out in the **Service Agreement** between the participant and the provider.

### 2. Claiming Mechanism: The "Notional Unit Price"

To facilitate the administrative claim process for these price-uncontrolled items, the NDIS uses a **"notional unit price"**.

*   **Definition:** Where a support item does not have a price limit, the provider should claim for that item by reference to the "notional unit price" if one is set out in the NDIS Support Catalogue or associated guides.
*   **The Baseline Value:** For many such supports (e.g., Low Cost Assistive Technology, Provider Travel – Non-Labour Costs, Activity Based Transport), this **notional unit price is \$1.00 per unit**.
*   **How it Works:** The provider submits a payment request by adjusting the *number of units* claimed at the \$1.00 notional unit price to equal the *agreed total cost*.

**Example:** If a provider and participant agree on a reasonable cost of **\$530** for Low Cost Assistive Technology (which is not subject to a price limit but has a notional unit price of \$1.00), the provider submits a claim for **530 units at \$1.00 a unit** for a total amount of \$530.
for state source fields:
clients: in clients collection:
{"_id":{"$oid":"684ed3246e30ad7d0570e451"},"clientFirstName":"Jamapel","clientLastName":"Jama","clientEmail":"abc@abc.com","clientPhone":"0450000000","clientAddress":"123 George Street","clientCity":"Sydney","clientState":"NSW","clientZip":"2000","businessName":"","organizationId":"6846b040808f01d85897bbd8","createdBy":"test@tester.com","createdAt":{"$date":{"$numberLong":"1749996324598"}},"isActive":true,"updatedAt":{"$date":{"$numberLong":"1750087821865"}},"ndisItem":{"itemNumber":"01_404_0104_1_1","itemName":"Assistance With Self-Care Activities - High Intensity - Public Holiday","supportCategoryNumber":"1","supportCategoryName":"Assistance with Daily Life (Includes SIL)","registrationGroupNumber":"104","registrationGroupName":"High Intensity Daily Personal Activities","unit":"H","type":"Price Limited Supports","isQuotable":false,"startDate":null,"endDate":null,"supportPurposeId":"1","generalCategory":"Core Supports","supportCategoryNumberPACE":null,"supportCategoryNamePACE":null,"nonFaceToFaceSupport":null,"providerTravel":null,"shortNoticeCancellations":null,"ndiaRequestedReports":null,"irregularSILSupports":null}}

organizations in organizations collection:
{"_id":{"$oid":"6846a824808f01d85897bbd3"},"name":"Pratiksha Care Service","code":"TT5K0V1Z","ownerEmail":"deverbishal331@gmail.com","createdAt":{"$date":{"$numberLong":"1749461028099"}},"isActive":true,"settings":{"allowEmployeeInvites":true,"maxEmployees":{"$numberInt":"100"}}}

One thing to be alert is that the organization code is unique and should not be changed once set as it is used to identify the organization in the system. And when attacching something with the oraganisation it should be attached to the organization code that can be obtained with ownerEmail.

For MMM source fields: I think we can use clients address which is in client collection.
{"_id":{"$oid":"684ed3246e30ad7d0570e451"},"clientFirstName":"Jamapel","clientLastName":"Jama","clientEmail":"abc@abc.com","clientPhone":"0450000000","clientAddress":"123 George Street","clientCity":"Sydney","clientState":"NSW","clientZip":"2000","businessName":"","organizationId":"6846b040808f01d85897bbd8","createdBy":"test@tester.com","createdAt":{"$date":{"$numberLong":"1749996324598"}},"isActive":true,"updatedAt":{"$date":{"$numberLong":"1750087821865"}},"ndisItem":{"itemNumber":"01_404_0104_1_1","itemName":"Assistance With Self-Care Activities - High Intensity - Public Holiday","supportCategoryNumber":"1","supportCategoryName":"Assistance with Daily Life (Includes SIL)","registrationGroupNumber":"104","registrationGroupName":"High Intensity Daily Personal Activities","unit":"H","type":"Price Limited Supports","isQuotable":false,"startDate":null,"endDate":null,"supportPurposeId":"1","generalCategory":"Core Supports","supportCategoryNumberPACE":null,"supportCategoryNamePACE":null,"nonFaceToFaceSupport":null,"providerTravel":null,"shortNoticeCancellations":null,"ndiaRequestedReports":null,"irregularSILSupports":null}}

But I akk not sure how to define remote ares, very remote areas, metroplitian or else.
