- [x]  Consume GitHub's API using the library [Tesla](https://github.com/teamon/tesla)
    - [x]  The module call shall return - for each user's repository - its `id` , `name` , `description` , `html_url` and `stargazers_count`
    - [x]  Have one route which will receive user's `username` and return the data described above with status `200` or `404` if the user couldn't be found
- [x]  Test the client created using [Bypass](https://github.com/PSPDFKit-labs/bypass)
---
- [x]  Create a new Entity called `User`
    - [x]  This entity shall contain the fields: `id` and `password`
    - [x]  When creating a new user, only its password should be passed on
    - [x]  The `id` should be generated automatically and returned as a response
        - [x]  Save the user's password hash on the database, no its original one
- [x]  Authenticate the `User` with a `login` route that will return a new token for the relative session. Passing on the body of the request its `id` and `password`
- [x]  Calling the user's repository route will also need to contain a token

---

- [x]  Alter token's expiration time to 1 minute
    - [x]  Renew it after each request as long as it's still valid
