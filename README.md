##ARISAN - a lending circle app

---

The concept of lending circles is new to the West, but this form of social lending is widely used in a lot of Third World countries.

#####What is a lending circle?
A lending circle is a form of social lending where individuals in a community forms a group and supports each other financially. When a circle forms, individuals in the group pool their money together and start a raffle. Whoever wins the raffle wins from the pool of money. The circle then meets again at a specified date, pool their money and play the raffle again. However, previous winners are not able to win again, but they are still required to put their money in to the pool. The circle will end when every individual in the group has won.

#####Why lending circles?
In most Third World countries going through a traditional bank and asking for a loan will not apply to most citizens who are poor and can not afford to pay a down payment, do not have collateral, they only want a small loan or are not willing to pay the interest attached to the loan.

#####Technology:
* Node.js
* Coffee Script
* Angular.js
* Ruby
* Rails
* Ionic

#####How to run this app:
As of now this app only runs on http://localhost:8100/ or through the iPhone emulator with Xcode. However, we first need to talk to the backend because our API (built with Ruby on Rails) will store all of the user's information and group/ circle information.

######Serving the API 
1.	Go to this link: https://github.com/indotek68/arisan_api
2.	Clone the repository
3.	Migrate the database from the terminal
4.	Run **rails s** in the terminal

######Running the app 
1. You can either run **ionic serve** to run it in the browser or...
2. In the terminal type **cordova emulate ios --target="iPhone (Retina 4-inch)"
** This will run the emulator.





