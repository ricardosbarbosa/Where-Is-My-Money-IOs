# Where-Is-My-Money-IOs

## Instructions to reviewer

1. Clone the project
2. I have used cocoa pod to deal with libraries. So inside the project run the command below to instal the dependencie.
```
pod install
```
3. Open the Api.swift file and replace the code below with your aoi kwy form the website: https://mailboxlayer.com/
```
let key = "PLACE-YOUR-API-KEY-HERE" //https://mailboxlayer.com/dashboard
```

## About the app

### Description
Application to help the user have better financial control of their expenses and income, knowing where their money is spent, and how it is distributed in their bank accounts.

### Intended User
People who have difficulty knowing how their money is spent, who wish to have a record of expenses and revenues, to conclude over time how they can have a healthier financial life, knowing how to find excessive spending points that need to be better controlled.
People who already do some financial control in some other way can also benefit from using the application to help you with this task.

### Features
#### List of key features of the app:
- Login
- User registration
- Account creation (account types: savings, checking account, credit card, money/wallet)
- Record expenses for a category in a particular account
- Record of revenue of a category in a given account
- Transfer of values from one account to another, such as account withdrawals Chain, deposits etc.
- Account balances
#### Future Features (not in this version)
- Charts by accounts and categories
- Marking transactions with tags
- Recognize transactions as an invoice payment for a credit card account.credit
- Allow recurring transactions(daily, weekly or monthly)
- Allow split transactions
- Be able to tell if a revenue has actually been recieved or is scheduled
- The same for expenses, can inform if an expense has been paid or if it is open, delayed or programmed.
- Paging per month
- View grouped transaction per day in the list
- Footer in the list of transactions, displaying the balance
- Allow filters in the transactions list
- Search transactions
- Home view for overview
  - with transactions to pay and to receive
  - late bills
  - account balances

### User interfaces

### Key Considerations
#### How will your app handle data persistence?
I have decided try for the first time to use firebase realtime database, instead a relational database as sqllite.

#### Describe any libraries you’ll be using and share your reasoning for including them.
- Eureka https://github.com/EurekaCommunity
  - to create easy forms 
- RAMAnimatedTabBarController https://github.com/Ramotion/animated-tab-bar
  - to animate the tabbar
 

