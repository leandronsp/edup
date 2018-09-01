import React from 'react';
import { List, Datagrid, EmailField, TextField, Create, SimpleForm, TextInput,
  CardActions, CreateButton, RefreshButton, } from 'react-admin';

const UserActions = ({basePath}) => (
    <CardActions>
        <CreateButton basePath={basePath} />
        <RefreshButton />
    </CardActions>
);

export const UserList = (props) => (
    <List title="All users" actions={<UserActions />} bulkActions={null} {...props}>
        <Datagrid>
            <EmailField source="email" />
            <TextField source="roles" />
        </Datagrid>
    </List>
);

export const UserCreate = (props) => (
    <Create {...props}>
        <SimpleForm>
            <TextInput source="email" />
        </SimpleForm>
    </Create>
);
