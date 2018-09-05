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
import CardHeader from '@material-ui/core/CardHeader';
import CardContent from '@material-ui/core/CardContent';
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
    width: 350,
    height: 360,
    margin: '0.5em',
    display: 'inline-block',
    verticalAlign: 'top'
};

const LessonCard = ({ record }) => {
  const cardStyle2 = {
      width: '80%',
      height: 500,
      margin: '0.5em',
      display: 'inline-block',
      verticalAlign: 'top'
  };
  const getVideoId = require('get-video-id');
  const {id, service} = getVideoId(record.source_url || "");

  return <Card key={record.id} style={cardStyle2}>
      <CardHeader
          title={<TextField record={record} source="name" />}
          avatar={<Avatar><BookIcon /></Avatar>}/>
      <CardContent>
        {service === 'vimeo' && <Vimeo video={id} width={700} height={400} />}
        {service === 'youtube' && <YouTube video={id} width={700} height={400} />}
        {service === undefined && <img src="/placeholder.png"/>}
      </CardContent>
  </Card>;
};


export const LessonShow = (props) => {
    return <Show {...props} title={<LessonName />} >
        <SimpleShowLayout>
          <LessonCard />
        </SimpleShowLayout>
    </Show>
}

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
              {service === undefined && <img src="/placeholder.png"/>}
            </CardContent>
            <CardActions style={{ textAlign: 'right' }}>
                <ShowButton label="View" resource='lessons' basePath='/lessons' record={lesson}  />
            </CardActions>
        </Card>
    })}
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
