import React from 'react';
import { List, Datagrid, TextField } from 'react-admin';

export const CourseList = (props) => (
    <List title="All Courses" {...props} >
        <Datagrid>
            <TextField source="name" />
        </Datagrid>
    </List>
);
