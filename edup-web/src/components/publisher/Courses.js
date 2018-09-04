import React from 'react';
import { Player } from 'video-react';
import YouTube from '@u-wave/react-youtube';
import Vimeo from '@u-wave/react-vimeo';

import { List, Datagrid, TextField, RefreshButton, CreateButton, ShowButton, BooleanField,
  Show, SimpleShowLayout, ListButton, TabbedShowLayout, Tab, ReferenceManyField, EditButton,
  Edit, DeleteButton, SimpleForm, Create, TextInput, CardActions, GET_ONE } from 'react-admin';

import BookIcon from '@material-ui/icons/Book';
import ActionList from '@material-ui/icons/List';

import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import CardHeader from '@material-ui/core/CardHeader';
import Avatar from '@material-ui/core/Avatar';

import PublishButton from './PublishButton'
import CreateLessonButton from './CreateLessonButton'
import DeleteLessonButton from './DeleteLessonButton'

import CounterField from './CounterField'

import dataProvider from '../../dataProvider';

const CourseListActions = ({basePath}) => (
  <CardActions>
      <CreateButton basePath={basePath} />
      <RefreshButton />
  </CardActions>
);

const CourseShowActions = ({data, basePath, parentId}) => (
  <CardActions>
      <CreateLessonButton parentId={parentId} />
      <ListButton basePath={basePath} />
      <RefreshButton />
  </CardActions>
);

const LessonEditActions = (props) => (
  <CardActions>
      <RefreshButton />
  </CardActions>
);

export const CourseList = (props) => (
  <List {...props} title="All Courses" actions={<CourseListActions />} bulkActions={null} >
      <Datagrid>
          <TextField source="name" />
          <ShowButton label="Lessons" />
          <CounterField source="students" />
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

const cardStyle = {
    width: 350,
    height: 360,
    margin: '0.5em',
    display: 'inline-block',
    verticalAlign: 'top'
};

const LessonGrid = ({record, basePath}) => {
    const lessons = record.lessons || []
    const getVideoId = require('get-video-id');

    return <div style={{ margin: '1em' }}>
    {lessons.map(lesson => {
        const {id, service} = getVideoId(lesson.source_url || "");

        return <Card key={lesson.id} style={cardStyle}>
            <CardHeader
                title={<TextField record={lesson} source="name" />}
                avatar={<Avatar><BookIcon /></Avatar>}
            />
            <CardContent>
              {service === 'vimeo' && <Vimeo video={id} width={300} height={200} />}
              {service === 'youtube' && <YouTube video={id} width={300} height={200} />}
            </CardContent>
            <CardActions style={{ textAlign: 'right' }}>
                <EditButton resource='lessons' basePath='/lessons' record={lesson} />
                <DeleteLessonButton parentId={record.id} record={lesson} />
            </CardActions>
        </Card>
    })}
    </div>
}

const LessonName = ({ record }) => {
  return <span>Lesson</span>;
};

const LessonCard = ({ record }) => {
  const cardStyle2 = {
      width: '60%',
      minHeight: 200,
      margin: '0.5em',
      display: 'inline-block',
      verticalAlign: 'top'
  };

  return <Card key={record.id} style={cardStyle2}>
      <CardHeader
          title={<TextInput record={record} source="name" />}
          avatar={<Avatar><BookIcon /></Avatar>}/>
      <CardContent>
        <TextInput record={record} source="source_url" style={{width: '100%'}} />
      </CardContent>
  </Card>;
};

export const LessonEdit = (props) => {
    return <Edit title={<LessonName />} {...props} actions={<LessonEditActions />}>
        <SimpleForm redirect='edit'>
          <LessonCard />
        </SimpleForm>
    </Edit>
}

export const CourseEdit = (props) => {
    return <Edit title={<CourseName />} {...props}>
        <SimpleForm>
            <TextInput source="name" />
        </SimpleForm>
    </Edit>
}

export const CourseShow = (props) => (
  <Show {...props} title={<CourseName />} actions={<CourseShowActions parentId={props.id} />}>
    <SimpleShowLayout>
      <PublishButton />
      <LessonGrid parentId={props.id} />
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
