# API Spec WEB

> {{BASE_URL}}/web/v1

## Auth (/auth)

### 1. Sign In (/sign-in)

* **Method**: POST
* **BODY**: {"username": "USER_NAME", "secret": "PASSWORD"}
* **Expected**: token, created datetime, expired datetime

### 2. Sign Out (/sign-out)

* **Method**: POST
* **Header**: TOKEN

## Dashboard (/dashboard)

### 1. Listing (/listing)

* **Method**: POST
* **Header**: TOKEN
* **Expected**: id, dao_profile_image, dao_name, dao_full_position_title, total_usd, total_khr, collected_usd, collected_khr

### 2. Current Transactions by OCR (/listing-detail)

* **Method**: POST
* **Header**: TOKEN
* **BODY**: {"id": "LISTING_ID", "pageIndex": "1", "pageSize": "10"}
* **Expected**: total_usd, total_khr, [loan_account, loan_currency, client_name, balance, principal, interest, operational_fee, total, total_khr_recieve, total_usd_received, remark]

### 3. Notification (/all-notification)

* **Method**: POST
* **Header**: TOKEN
* **Expected**: max 20 rows [notification_content, date_create (ordered)]

## DOA Detail Transaction Collection (/dao-detail-trans)

### 1. Upload File (/upload)

* **Method**: POST
* **Header**: TOKEN
* **Multipart**: stream, length, filename

### 2. All Transaction Collection List (/all-trans)

* **Method**: POST
* **Header**: TOKEN
* **BODY**: {"id": "LISTING_ID", "filter": {"branchCode": "", "villageCode": "", "daoCode": "", "clientName": ""}, "pageIndex": "1", "pageSize": "10"}
* **Expected**: [loan_account, loan_currency, client_name, balance, principal, interest, operational_fee, total]