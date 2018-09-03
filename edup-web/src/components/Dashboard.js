import React from 'react';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';

const email = localStorage.email
const welcomeMessage = `Welcome, ${email}!`

export default () => (
    <Card>
        <CardHeader title={welcomeMessage} />
    </Card>
);
