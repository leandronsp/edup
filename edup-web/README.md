# EdUp Web

The frontend application for [EdUp](https://bitbucket.org/leandronsp/edup/src/master/edup-api/README.md), built on top of [React](https://github.com/facebook/react).

## Stack

  * ES6
  * React 16
  * [react-admin](https://github.com/marmelab/react-admin)
  * yarn

## Development
By default the backend API must be listening to the port `4001`, but if for some reason you need to change
the API port, please update the file `src/config/apiEndpoint.js`.

#### Running
```
yarn start
```
Open http://localhost:4000 and use credentials to perform the login.
```
# publisher
publisher@example.com

# student
student@example.com

# password
pa$$w0rd
```

#### Testing
```
yarn test
```
