import React from 'react';
import { Admin, Resource } from 'react-admin';

import Dashboard from './Dashboard';
import { UserList } from './Users';
import { CourseList } from './Courses';

import BookIcon from '@material-ui/icons/Book';
import UserIcon from '@material-ui/icons/Group';

import authProvider from './authProvider';
import dataProvider from './dataProvider';

const App = () => (
  <Admin title="EdUp" dashboard={Dashboard} authProvider={authProvider} dataProvider={dataProvider}>
    {permissions => [
      permissions === 'publisher' ? <Resource name="users" list={UserList} icon={UserIcon} /> : null,
      <Resource name="courses" list={CourseList} icon={BookIcon} />
    ]}
  </Admin>
)

export default App;
