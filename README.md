# Aergia
Aergia Listens for files to be uploaded to S3, then submits them to Zencoder for encoding.

# System basics
* Receive Amazon SNS that file uploaded to S3
* Send file to Zencoder for encoding
* Receive notification from Zencoder that job is completed
* Post message to ??? that job is complete
* Move orignal file from S3 to Glacier
* Relax
