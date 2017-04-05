# Routes 

## Client Side Routes

### Consumer Routes

```
/ 
/signup
/login
/users/:slug 
/users/:slug/profile
/users/:slug/cart
/users/:slug/orders
/users/:slug/orders/:order_id
/items
/items/:slug
/users/:slug/cart/checkout
```

### Admin Routes 

```
/
/admin/login
/admin/:slug/admin_create
/admin/:slug 
/admin/:slug/profile 
/admin/:slug/items
/admin/:slug/items/new
/admin/:slug/items/edit 
/admin/:slug/orders
/admin/:slug/orders/:order_id
```

## Server Side Routes 

POST /api/v1/users  
  - creates a user account 

  - Params 

  ```javascript
  { user: { email: 'luke@flatironschool.com', password: 'password' } }
  ```
  
  - Response

  ```javascript
  {
    user: {
      email: ‘luke@flatironschool.com’ 
    }, 
    token: ‘123.abc.456.def.wayiuawehriw4y398rayrtau’	
  }
  ```

POST /api/v1/auth 
  - logs in a previously create user 

  - Params 

  ```javascript
  { user: { id: 1, email: 'luke@flatironschool.com', password: 'password' } }
  ```

  - it returns the user info and a JWT token 

  ```javascript
  {
    user: {
      id: 1,
      email: ‘luke@flatironschool.com’ 
    }, 
    token: ‘123.abc.456.def.wayiuawehriw4y398rayrtau’	
  }
  ```

POST /api/v1/auth/refresh 

  - check for a valid JWT token in the request header 

  - Headers

  ```javascript 
  headers: {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'Authorization': 'Bearer: fajsfklasjhawuktajrharar'
  }
  ```

  - response (on success)

  ```javascript
  {
    user: {
      id: 1,
      email: ‘luke@flatironschool.com’ 
    }, 
    token: ‘123.abc.456.def.wayiuawehriw4y398rayrtau’	
  }
  ```

### default unauthorized error 
  
  response (on error)

  ```javascript
  { 
    status: 403, 
    error: { message: 'Unauthorized' }
  }
  ```

  GET /api/v1/items 

  - it returns a list of items 
  - it does not require an authenticated user

  - response 

  ```javascript 
  {
    items: [
      { title: 'monkey', price: '31.99', inventory: 3 },
      { title: 'lion', price: "49.99", inventory: 4 }
    ]
  }
  ```

  POST /api/v1/items 

  - it creates a new item 

  - it is an authenticated route for admins only

  - params & headers 

  ```javascript 
  headers: {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'Authorization': 'Bearer: fajsfklasjhawuktajrharar'
  }
  parms: {
    item: {
      title: 'cat', 
      price: '32.99',
      inventory: 1 
    }
  }
  ```

  - response (on success)

  ```javascript 
  {
    status: 200, 
    message: 'Ok', 
    item: {
      title: 'cat', 
      price: '32.99',
      inventory: 1 
    }
  }
  ```

  - response (on error)

  ```javascript 
  {
    status: 500, 
    error: { message: { key: ['some error message'] } }
  }
  ```

  user goes to site and logs in 

    -> user get a token stored in the browser 

        -> user goes to google and decides to do something else 

          -> 5 minutes later returns to buy the item he looked at 

            -> does he have token? or does login again 

              -> check browser for current token

                -> if token exists then make a request to the server for a new 
                token and user info 

                  -> is token from our application? 

                    -> if yes 

                      -> send user info with new token 

                    -> if no

                      -> tell the client that their token in invalid
                    
                -> if no token then user is truly logged out.
