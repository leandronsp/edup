import React from 'react';
import { List, Datagrid, TextField, RefreshButton, CreateButton, ShowButton, BooleanField,
  Show, SimpleShowLayout, ListButton, TabbedShowLayout, Tab, ReferenceManyField, EditButton, CardContent,
  Edit, DeleteButton, SimpleForm, Create, TextInput, CardActions, GET_ONE } from 'react-admin';

import BookIcon from '@material-ui/icons/Book';
import ActionList from '@material-ui/icons/List';

import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import Avatar from '@material-ui/core/Avatar';

import dataProvider from '../../dataProvider';

const CourseListActions = ({basePath}) => (
  <CardActions>
      <RefreshButton />
  </CardActions>
);

const CourseShowActions = ({data, basePath, parentId}) => (
  <CardActions>
      <ListButton basePath={basePath} />
      <RefreshButton />
  </CardActions>
);

export const CourseList = (props) => (
  <List {...props} title="All Courses" actions={<CourseListActions />} bulkActions={null} >
      <Datagrid>
          <TextField source="name" />
          <ShowButton label="Lessons" />
      </Datagrid>
  </List>
);

const CourseName = ({ record }) => {
    return <span>
      Course {record ? `"${record.name}"` : ''}
    </span>;
};

const cardStyle = {
    width: 300,
    margin: '0.5em',
    display: 'inline-block',
    verticalAlign: 'top'
};

const LessonGrid = ({record, basePath}) => {
    const lessons = record.lessons || []

    return <div style={{ margin: '1em' }}>
    {lessons.map(lesson =>
        <Card key={lesson.id} style={cardStyle}>
            <CardHeader
                title={<TextField record={lesson} source="name" />}
                avatar={<Avatar><BookIcon /></Avatar>}
            />
        </Card>
    )}
    </div>
}

const LessonName = ({ record }) => {
  return <span>Lesson</span>;
};

export const CourseShow = (props) => (
  <Show {...props} title={<CourseName />} actions={<CourseShowActions parentId={props.id} />}>
    <SimpleShowLayout>
      <LessonGrid parentId={props.id} />
    </SimpleShowLayout>
  </Show>
);
