import React, { Component } from 'react';
import { Button, showNotification, DELETE } from 'react-admin';
import { connect } from 'react-redux';
import dataProvider from './dataProvider';
import { refreshView } from 'ra-core';
import { withStyles } from '@material-ui/core/styles';
import ContentCreate from '@material-ui/icons/Create';

const styles = {}

class EditLessonButton extends Component {

    handleClick = () => {
    }

    render() {
        return (
          <Button
            style={{color: 'blue'}}
            label="Edit"
            onClick={this.handleClick}
          >
            <ContentCreate />
          </Button>
        )
    }
}

export default connect(null, {
    showNotification,
    refreshView
})(withStyles(styles)(EditLessonButton));
