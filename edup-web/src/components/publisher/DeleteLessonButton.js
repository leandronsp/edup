import React, { Component } from 'react';
import { Button, showNotification, DELETE } from 'react-admin';
import { connect } from 'react-redux';
import dataProvider from '../../dataProvider';
import { refreshView } from 'ra-core';
import { withStyles } from '@material-ui/core/styles';
import ActionDelete from '@material-ui/icons/Delete';

const styles = {}

class DeleteLessonButton extends Component {

    handleClick = () => {
      const { record, showNotification, parentId } = this.props;
      dataProvider(DELETE, 'lessons', { id: record.id, data: { course_id: parentId }})
        .then(() => {
          showNotification('Lesson deleted')
          this.props.refreshView()
        })
        .catch((e) => {
          console.error(e);
          showNotification('Error: could not delete lesson', 'warning')
        });
    }

    render() {
        return (
          <Button style={{color: 'red'}} label="Delete" onClick={this.handleClick}><ActionDelete /></Button>
        )
    }
}

export default connect(null, {
    showNotification,
    refreshView
})(withStyles(styles)(DeleteLessonButton));
