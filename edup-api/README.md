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
      - 404 NotFound
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
```
## Lessons
```
  POST /courses/1234-uuid/lessons
    { lesson: { name: 'Basics' }, course_id: '1234-uuid' }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/courses/1234-uuid'
      - 404 NotFound
      - 403 Forbidden

  GET /courses/1234-uuid/lessons
    Authorization: <jwt>
    Response:
      - 200 OK | json: [<lessons>]
      - 404 NotFound
      - 403 Forbidden

  GET /courses/1234-uuid/lessons/123-lesson-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { id: '123-lesson-uuid', name: 'Basics', course_id: '1234-uuid' }
      - 404 NotFound
      - 403 Forbidden
```
## Sessions
```
  POST /sessions
    { session: { name: 'Web development' }, courses: ['1234', '4567'] }
    Authorization: <jwt>
    Response:
      - 201 Created | location: 'http://host.com/sessions/1234-uuid'
      - 403 Forbidden

  GET /sessions
    Authorization: <jwt>
    Response:
      - 200 OK | json: [{ name: 'Web developmet'}]
      - 403 Forbidden

  GET /sessions/1234-uuid
    Authorization: <jwt>
    Response:
      - 200 OK | json: { name: 'Web developmet', courses: [<courses>] }
      - 404 NotFound
      - 403 Forbidden
```
### Testing
```
  ./bin/rspec
  open coverage/index.html
```
