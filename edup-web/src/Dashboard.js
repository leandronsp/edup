import React from 'react';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import CardHeader from '@material-ui/core/CardHeader';

const email = localStorage.email
const welcomeMessage = `Welcome, ${email}!`

export default () => (
    <Card>
        <CardHeader title={welcomeMessage} />
        <CardContent>Lorem ipsum sic dolor amet...</CardContent>
    </Card>
);
