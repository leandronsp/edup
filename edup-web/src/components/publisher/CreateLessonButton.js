import React, { Component } from 'react';
import { Button, showNotification, CREATE } from 'react-admin';
import { connect } from 'react-redux';
import dataProvider from '../../dataProvider';
import { refreshView } from 'ra-core';
import { withStyles } from '@material-ui/core/styles';
import BookIcon from '@material-ui/icons/Book';

const styles = {}

class CreateLessonButton extends Component {

    handleClick = () => {
      const { showNotification, parentId } = this.props;
      dataProvider(CREATE, 'lessons', { data: { course_id: parentId }})
        .then(() => {
          showNotification('Lesson created');
          this.props.refreshView()
        })
        .catch((e) => {
          console.error(e);
          showNotification('Error: could not create lesson', 'warning')
        });
    }

    render() {
        return (
          <Button style={{color: 'green'}} label="Create Lesson" onClick={this.handleClick}><BookIcon /></Button>
        )
    }
}

export default connect(null, {
    showNotification,
    refreshView
})(withStyles(styles)(CreateLessonButton));
