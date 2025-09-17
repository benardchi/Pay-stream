Pay-Stream Smart Contract

Overview
The **Pay-Stream** smart contract is a decentralized and trustless salary streaming protocol built on the Stacks blockchain.  
It enables employers to create continuous payment streams for recipients, allowing them to withdraw accrued STX funds in real time based on elapsed blocks.  

This contract ensures transparency, automation, and flexibility for payrolls, recurring payments, grants, and subscriptions.

---

Features
- **Create Stream** – Employers can lock STX and define salary/payment streams for recipients.  
- **Withdraw Funds** – Recipients can withdraw the proportional amount they’ve earned at any time.  
- **Cancel Stream** – Employers can cancel a stream, ending it immediately and reclaiming unspent funds.  
- **Stream Transparency** – Publicly query stream details including employer, recipient, total amount, start and end blocks, withdrawn amount, and cancellation status.  
- **Error Handling** – Prevents invalid operations such as zero-amount streams, non-recipient withdrawals, or unauthorized cancellations.

---

Use Cases
- Automated **employee payrolls**  
- **Scholarship disbursements**  
- **Recurring donations or allowances**  
- **Subscription-based payments**  
- **Grants and milestone-based funding**

---

Deployment
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/pay-stream.git
   cd pay-stream
