### Please describe found weak places below.

#### Security issues

1. SecureRandom.hex(5) is not enough to guarantee uniqueness since it has an upper bounds of 1,048,576. We should increase the number of characters and possibly use a different encoding, like Crockford Base-32. We should also introduce a unique constraint on the DB in case of collissions
2. Unsanitized mass-assignment of parameters for Transaction.create. The parameters need to be whitelisted
3. Manager.all.sample is a potential performance bottleneck and requests can be spammed for a potential DoS
#### Performance issues
4. Rendering views from an unsanitized type. The type needs to be checked from a whitelist before rendering

1. Manager.all.sample loads all records and is a potential performance bottleneck
2. ...
3. ...
#### Code issues

1. Transaction#large? is incorrect. It should only return true if the amount is $100 to $1,000
2. ...
3. ...
#### Others

1. No tests
2. Manager.all.sample should be moved to the model logic
3. Unused methods on TransactionsController
