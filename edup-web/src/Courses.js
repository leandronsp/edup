import React from 'react';
import { List, Datagrid, TextField,
  EditButton, SimpleForm, Create, TextInput } from 'react-admin';

export const CourseList = (props) => (
    <List title="All Courses" {...props} >
        <Datagrid>
            <TextField source="name" />
            <EditButton />
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
