# EdUp API

API for EdUp.

## SignUp/SignIn
```
  POST /signup
    { email: 'email@example.com', password: '111', password_confirmation: '111' }
    Response:
      - 201 Created | json: {}
      - 409 Conflict | json: { message: <message> }

  POST /signin
    { email: 'email@example.com', password: '111' }
    Response:
      - 201 Created | json: { token: <jwt> }
      - 409 Conflict | json: { message: <message> }
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

  GET /lessons/123-lesson-uuid?course_id=1234-course-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { id: '123-lesson-uuid', name: 'Basics' }
      - 404 NotFound
      - 403 Forbidden

  UPDATE /lessons/1234-lesson-uuid
    { lesson: { name: 'Basics' }, course_id: '1234-uuid' }
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden

  DELETE /lessons/1234-uuid
    { course_id: '1234-course-uuid' }
    Authorization: <jwt>
    Response:
      - 200 OK
      - 404 NotFound
      - 403 Forbidden
```
### Testing
```
  ./bin/rspec
  open coverage/index.html
```
