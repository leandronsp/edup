import React, { Component } from 'react';
import { Button, showNotification, UPDATE } from 'react-admin';
import { connect } from 'react-redux';
import ActionDone from '@material-ui/icons/Done';
import ActionClear from '@material-ui/icons/Clear';
import dataProvider from '../../dataProvider';
import { refreshView } from 'ra-core';
import { withStyles } from '@material-ui/core/styles';

const styles = {
  publishedBtn: { color: 'white', backgroundColor: 'blue' },
  unpublishedBtn: { color: 'white', backgroundColor: 'red' }
};

class PublishButton extends Component {

    handleClick = () => {
      const { record, showNotification } = this.props;
      var data = { published: !record.published }

      dataProvider(UPDATE, 'courses', { id: record.id, data: data })
        .then(() => {
          showNotification('Course updated');
          this.props.refreshView()
        })
        .catch((e) => {
          console.error(e);
          showNotification('Error: could not update course', 'warning')
        });
    }

    render() {
        const { record, classes } = this.props;
        var label = record.published ? "Published" : "Unpublished"
        var icon  = record.published ? <ActionDone /> : <ActionClear />
        var buttonColor = record.published ? classes.publishedBtn : classes.unpublishedBtn

        return (
          <Button className={buttonColor} label={label} onClick={this.handleClick}>{icon}</Button>
        )
    }
}

export default connect(null, {
    showNotification,
    refreshView
})(withStyles(styles)(PublishButton));
