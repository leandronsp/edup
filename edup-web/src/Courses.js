import React from 'react';
import { List, Datagrid, TextField, RefreshButton, CreateButton, BooleanField,
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
            <BooleanField source="published" />
            <PublishButton />
            <DeleteButton />
        </Datagrid>
    </List>
);

export const CourseCreate = (props) => (
    <Create {...props}>
        <SimpleForm>
            <TextInput source="name" />
        </SimpleForm>
    </Create>
);
