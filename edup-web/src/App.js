import React from 'react';
import { Admin, Resource } from 'react-admin';

import Dashboard from './Dashboard';
import { UserList, UserCreate } from './Users';
import { CourseList, CourseCreate } from './Courses';

import BookIcon from '@material-ui/icons/Book';
import UserIcon from '@material-ui/icons/Group';

import authProvider from './authProvider';
import dataProvider from './dataProvider';

const App = () => (
  <Admin title="EdUp" dashboard={Dashboard} authProvider={authProvider} dataProvider={dataProvider}>
    {permissions => [
      permissions === 'publisher' ? <Resource name="users" list={UserList} create={UserCreate} icon={UserIcon} /> : null,
      permissions === 'publisher' ? <Resource name="courses" list={CourseList} create={CourseCreate} icon={BookIcon} /> : null
    ]}
  </Admin>
)

export default App;
