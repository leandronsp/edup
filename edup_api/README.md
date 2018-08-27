# EdUp API

API for EdUp.


## SignUp/SignIn
  POST /signup
    { email: 'email@example.com', password: '111', password_confirmation: '111' }
    Response:
      - 201 Created | json: {}
      - 409 Conflict | json: { message: <message> }

  POST /signin
    { email: 'email@example.com', password: '111' }
    Response:
      - 201 Created | json: { token: <jwt> }
      - 404 NotFound

## Courses
  POST /courses
    { name: 'Ruby programming' }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/courses/1234-uuid'
      - 403 Forbidden

### Testing
  ./bin/rspec
  open coverage/index.html
