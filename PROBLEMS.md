### Please describe found weak places below.

#### Security issues

1. SecureRandom.hex(5) is not enough to guarantee uniqueness since it has an upper bounds of 1,048,576. We should increase the number of characters and possibly use a different encoding, like Crockford Base-32. We should also introduce a unique constraint on the DB in case of collissions
2. Unsanitized mass-assignment of parameters for Transaction.create. The parameters need to be whitelisted
3. Manager.all.sample is a potential performance bottleneck and requests can be spammed for a potential DoS
4. Rendering views from an unsanitized type. The type needs to be checked from a whitelist before rendering
5. Client personal information - which is highly likely a PII - is not encrypted

#### Performance issues

1. Manager.all.sample loads all records and is a potential performance bottleneck
2. Transaction.all loads all records. Best to have the view paginated
3. Currency conversion - which might be relatively expensive - is happening before validation. It might be more efficient to validate first before we do the conversion
4. RubyMoney updating rates on Puma process start. The rates should be cached and updating should be moved to an asynchronous job that runs on a preset schedule

#### Code issues

1. Transaction#large? is incorrect. It should only return true if the amount is $100 to $1,000
2. ...
3. ...

#### Others

1. No tests
2. Manager.all.sample should be moved to the model logic
3. Unused methods on TransactionsController
4. Managing the list of available currencies needs a deploy because it's on a hard-coded array. It might be better persisted to a database table