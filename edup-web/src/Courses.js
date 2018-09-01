import React from 'react';
import { List, Datagrid, TextField, RefreshButton, CreateButton, ShowButton,
  Show, SimpleShowLayout, ListButton,
  DeleteButton, SimpleForm, Create, TextInput, CardActions } from 'react-admin';

import BookIcon from '@material-ui/icons/Book';

import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import Avatar from '@material-ui/core/Avatar';

import PublishButton from './PublishButton'
import CreateLessonButton from './CreateLessonButton'
import DeleteLessonButton from './DeleteLessonButton'

const CourseListActions = ({basePath}) => (
  <CardActions>
      <CreateButton basePath={basePath} />
      <RefreshButton />
  </CardActions>
);

const CourseShowActions = ({data, basePath}) => (
  <CardActions>
      <CreateLessonButton  data={data} />
      <ListButton basePath={basePath} />
      <RefreshButton />
  </CardActions>
);

export const CourseList = (props) => (
  <List {...props} title="All Courses" actions={<CourseListActions />} bulkActions={null} >
      <Datagrid>
          <TextField source="name" />
          <ShowButton label="Lessons" />
          <PublishButton />
          <DeleteButton />
      </Datagrid>
  </List>
);

const CourseName = ({ record }) => {
    return <span>
      Course {record ? `"${record.name}"` : ''}
    </span>;
};

const LessonGrid = ({ record, basePath }) => {
  const cardStyle = {
    width: 300,
    margin: '0.5em',
    display: 'inline-block',
    verticalAlign: 'top'
  };

  const lessons = record.lessons || [];

  const content = <div style={{ margin: '1em' }}>
    {lessons.map(lesson =>
      <Card key={lesson.id} style={cardStyle}>
        <CardHeader
            title={<TextField record={lesson} source="name" />}
            avatar={<Avatar><BookIcon /></Avatar>}
        />
        <CardActions style={{ textAlign: 'right' }}>
            <DeleteLessonButton record={lesson} />
        </CardActions>
      </Card>
    )}
  </div>;

  return record.lessons && record.lessons.length ? content : <h3 style={{ margin: '1em' }}>No Lessons</h3>;
};

export const CourseShow = (props) => (
  <Show {...props} title={<CourseName />} actions={<CourseShowActions />}>
    <SimpleShowLayout>
        <PublishButton />
        <LessonGrid />
    </SimpleShowLayout>
  </Show>
);

export const CourseCreate = (props) => (
    <Create {...props}>
        <SimpleForm>
            <TextInput source="name" />
        </SimpleForm>
    </Create>
);

const cardStyle = {
    width: 300,
    minHeight: 300,
    margin: '0.5em',
    display: 'inline-block',
    verticalAlign: 'top'
};
