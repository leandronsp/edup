import React, { Component } from 'react';
import { Button, showNotification, UPDATE } from 'react-admin';
import { connect } from 'react-redux';
import ActionDone from '@material-ui/icons/Done';
import ActionClear from '@material-ui/icons/Clear';
import dataProvider from './dataProvider';
import { refreshView } from 'ra-core';

class PublishButton extends Component {

    handleClick = () => {
      const { record, showNotification } = this.props;

      if (record.published) {
        const updatedRecord = { published: false };

        dataProvider(UPDATE, 'courses', { id: record.id, data: updatedRecord })
          .then(() => {
            showNotification('Course unpublished');
            this.props.refreshView()
          })
          .catch((e) => {
            console.error(e);
            showNotification('Error: course not unpublished', 'warning')
          });
      } else {
        const updatedRecord = { published: true };

        dataProvider(UPDATE, 'courses', { id: record.id, data: updatedRecord })
          .then(() => {
            showNotification('Course published');
            this.props.refreshView()
          })
          .catch((e) => {
            console.error(e);
            showNotification('Error: course not published', 'warning')
          });
      }
    }

    render() {
        const { record } = this.props;
        if (record.published) {
          var label = "Unpublish"
          var icon = <ActionClear />
        } else {
          label = "Publish"
          icon = <ActionDone />
        }

        return (
          <Button label={label} onClick={this.handleClick}>
            {icon}
          </Button>
        )
    }
}

export default connect(null, {
    showNotification,
    refreshView
})(PublishButton);
