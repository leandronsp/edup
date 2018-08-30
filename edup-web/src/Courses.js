import React from 'react';
import { List, Datagrid, TextField,
  DeleteButton, SimpleForm, Create, TextInput } from 'react-admin';

export const CourseList = (props) => (
    <List title="All Courses" {...props} >
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
