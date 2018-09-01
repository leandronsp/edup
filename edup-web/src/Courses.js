import React from 'react';
import { List, Datagrid, TextField, RefreshButton, CreateButton, ShowButton,
  Show, SimpleShowLayout,
  DeleteButton, SimpleForm, Create, TextInput, CardActions } from 'react-admin';

import PublishButton from './PublishButton'

const CourseActions = ({basePath}) => (
    <CardActions>
        <CreateButton basePath={basePath} />
        <RefreshButton />
    </CardActions>
);

export const CourseList = (props) => (
    <List {...props} title="All Courses" actions={<CourseActions />} bulkActions={null} >
        <Datagrid>
            <TextField source="name" />
            <ShowButton />
            <PublishButton />
            <DeleteButton />
        </Datagrid>
    </List>
);

const CourseName = ({ record }) => {
    return <span>Course {record ? `"${record.name}"` : ''}</span>;
};

export const CourseShow = (props) => (
  <Show {...props} title={<CourseName />}>
    <SimpleShowLayout>
        <PublishButton />
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
