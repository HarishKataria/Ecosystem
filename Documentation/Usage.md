# Usage

### Create object graphs without having to connect them manually 

```swift
import Ecosystem

final class Billing {
    var ecosystem: Ecosystem
    
    init() {
        var ecosystem = Composer.ecosystem()
        ecosystem.add(Replicator(CreditCardProcessor.init))
        ecosystem.add(Replicator(TransactionLog.init))
        ecosystem.add(Replicator(PizzaOrder.init))
        ecosystem.add(Replicator(CreditCard.init))
        ecosystem.add(Replicator(combiningTwo: { (processor: CreditCardProcessor, transactionLog: TransactionLog) -> BillingService in
                RealBillingService(processor: processor, transactionLog: transactionLog)
            }))
        self.ecosystem = ecosystem
    }
    
    func billingService() throws -> BillingService {
        return try ecosystem.createEntity()
    }
}

```
