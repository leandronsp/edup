import React from 'react';
import { List, Datagrid, EmailField } from 'react-admin';

export const UserList = (props) => (
    <List title="All users" {...props}>
        <Datagrid>
            <EmailField source="email" />
        </Datagrid>
    </List>
);
