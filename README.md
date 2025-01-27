# Stocky

[Live Demo][LandingPage]

[LandingPage]: https://launchkit.io/websites/lly5XP4d3J8/

![auth](mobile/src/images/auth.png)![userIndex](mobile/src/images/userIndex.png)

Stocky is a mobile application built using Ruby on Rains on the backend, PostgreSQL database, and React-native/Redux on the frontend. In this application, users can trade/sell stock at real-world prices with fake money. It is a fun game, that can also
give users a safe way to experiment in trading stock.

## Features
- User accounts with Facebook authentication
- Virtual money
- Real-World value of stock prices for better experience
- User profile page with current statistics
- Stocks and User details visualization with graph
- Leaderboard of all users with ranked on amount of money

![searchCompanies](mobile/src/images/searchCompanies.png)![companyDetails](mobile/src/images/companyDetails.png)


## Project Design
Stocky was designed and built in a week.

  - Started with [proposal] [proposal] to plan out and make the skeleton of this project.

[proposal]: ./docs/README.md

## Technology

- ###### Backend technology
  + Rails
    - Calculations and filled in information done in backend
    ```Ruby
      def index
        @transactions = Transaction.where('user_id = ? AND company_id = ?',
                                          current_user.id,
                                          params[:company_id])
        render 'api/transactions/index'
      end

      def create
        @user = User.find(current_user.id)
        @transaction = Transaction.new(transaction_params)
        @transaction.user_id = @user.id
        @transaction.stock_count = @transaction.stock_count.to_i
        @stock = Stock.find_or_create_by(user_id: @user.id,
                                         company_id: transaction_params[:company_id])
        @stock.shares ||= 0
        end
      end
    ```
    - Customized query to take filtered information from database
    ```Ruby
      def index
        @stocks =
          Stock
            .where(user_id: current_user.id)
            .where.not(shares: 0)
            .includes(:company)
      end
    ```


  + Google Finance API
    - Requesting live real-world stock prices and other information
  + Database
    - PostgreSQL
    - 5 different tables (companies, histories, stocks, users, transactions)
  + jBuilder
    - To manipulate hash structures in JSON format

- ###### Frontend technology
  + JavaScript and React Native
    - Uses the components to keep renders organized and reusable. Action, API util, reducers, and store
    - To make the connection more secure
    ```javascript
    import { AsyncStorage } from 'react-native';
    async function getToken() {
      try {
        const value = await AsyncStorage.getItem('sessionToken');
        if (value !== null){
          return value;
        } else {
          console.warn('No session token');
        }
      } catch (error) {
        console.warn('Error when getting session token in ServerAPI');
      }
    }
    ```
