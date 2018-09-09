# EdUp API

Endpoints for managing users, courses and lessons. It uses [JWT](https://jwt.io/) for authorization.

## SignUp
Create a simple account with no roles.
```
  POST /signup
    { email: 'email@example.com', password: '111', password_confirmation: '111' }
    Response:
      - 201 Created | json: {}
      - 409 Conflict | json: { message: <message> }
```

## SignIn
Simple authentication with email/password credentials. Returns a valid JWT which can
be used for authorization.
```
  POST /signin
    { email: 'email@example.com', password: '111' }
    Response:
      - 201 Created | json: { token: <jwt> }
      - 409 Conflict | json: { message: <message> }
```

Then, at any endpoint, the token can be sent as HTTP header:
```
Authorization: Bearer <token>
```

## Users
```
  POST /users
    { email: 'new@example.com' }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/courses/1234-uuid'
      - 409 Conflict | json: { message: <message> }
      - 403 Forbidden

  GET /users
    Authorization: <jwt>
    Response:
      - 200 OK | json: [{ id: '1234-uuid', email: 'email', roles: ['student'] }]
      - 403 Forbidden

  GET /users/1234-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { id: '1234-uuid', email: 'email', roles: ['student'] }
      - 404 NotFound
      - 403 Forbidden
```

## Courses
```
  POST /courses
    { name: 'Ruby programming' }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/courses/1234-uuid'
      - 403 Forbidden

  GET /courses
    Authorization: <jwt>
    Response:
      - 200 OK | json: [{ id: '1234-uuid', name: 'Ruby programming' }]
      - 403 Forbidden

  GET /courses/1234-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { id: '1234-uuid', name: 'Ruby programming' }
      - 404 NotFound
      - 403 Forbidden

  DELETE /courses/1234-uuid
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden

  UPDATE /courses/1234-uuid
    { course: { name: 'Ruby programming' }}
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden
```
## Lessons
```
  POST /lessons
    { lesson: { name: 'Basics' }, course_id: '1234-uuid' }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/courses/1234-uuid'
      - 404 NotFound
      - 403 Forbidden

  GET /lessons?course_id=<course_id>
    Authorization: <jwt>
    Response:
      - 200 OK | json: [<lessons>]
      - 404 NotFound
      - 403 Forbidden

  GET /lessons/123-lesson-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { id: '123-lesson-uuid', name: 'Basics' }
      - 404 NotFound
      - 403 Forbidden

  UPDATE /lessons/1234-lesson-uuid
    { lesson: { name: 'Basics' }}
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden

  DELETE /lessons/1234-uuid
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden
```
### Upload an mp4 video on a lesson
The upload works using the same `UPDATE` enpoint, but it looks for a parameter called `upload`
which must contain two keys: `src` (the content encoded using base64) and `title` (the upload filename).

In case the `upload` parameter is not sent, it performs as a normal update action.
```
  UPDATE /lessons/1234-lesson-uuid
    {
      lesson: { name: 'Basics' },
      upload: { src: <base64_encoded>, title: 'my_upload.mp4' }
    }
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden
```

## Development and Testing
This project was tested under OSX using the following technologies:

  * Ruby 2.5
  * Rails 5.2+
  * PostgreSQL 10.5

#### Setup data
Reset and seed data.
```
  ./bin/rake db:reset db:migrate db:seed
  ./bin/rake db:reset db:migrate RAILS_ENV=test
```
Now you can perform a `signin` using a `publisher` credentials:

  * email: publisher@example.com
  * password: pa$$w0rd

Look at the `db/seeds.rb` file for further details at the created data.

#### Testing
```
  ./bin/rspec
  open coverage/index.html

  # TDD
  bundle exec guard
```

#### Running
```
./bin/rails -p 4001
```
Open http://localhost:4001

## TODO

  * add proper Serializers
  * implement JWT expiration
