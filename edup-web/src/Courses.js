import React from 'react';
import { List, Datagrid, TextField, RefreshButton, CreateButton,
  DeleteButton, SimpleForm, Create, TextInput, CardActions } from 'react-admin';

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
