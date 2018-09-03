import React from 'react';
import { Admin, Resource } from 'react-admin';

import Dashboard from './components/Dashboard';
import { UserList, UserCreate } from './components/publisher/Users';
import { CourseList, CourseCreate, CourseShow,
  CourseEdit, LessonEdit } from './components/publisher/Courses';

import { CourseList as StudentCourseList,
  CourseShow as StudentCourseShow } from './components/student/Courses';

import BookIcon from '@material-ui/icons/Book';
import UserIcon from '@material-ui/icons/Group';

import authProvider from './authProvider';
import dataProvider from './dataProvider';

const App = () => (
  <Admin title="EdUp" dashboard={Dashboard} authProvider={authProvider} dataProvider={dataProvider}>
    {permissions => [
      permissions === 'publisher' ? <Resource name="users" list={UserList} create={UserCreate} icon={UserIcon} /> : null,
      permissions === 'publisher' ? <Resource name="courses" list={CourseList} create={CourseCreate} show={CourseShow} edit={CourseEdit} icon={BookIcon} /> : null,
      permissions === 'publisher' ? <Resource name="lessons" edit={LessonEdit} /> : null,
      permissions === 'student' ? <Resource name="courses" list={StudentCourseList} show={StudentCourseShow} icon={BookIcon} /> : null,
    ]}
  </Admin>
)

export default App;
