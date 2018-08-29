/**
 *
 * SignUpForm
 *
 */

import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Helmet } from 'react-helmet';
import { FormattedMessage } from 'react-intl';
import { createStructuredSelector } from 'reselect';
import { compose } from 'redux';

import injectSaga from 'utils/injectSaga';
import injectReducer from 'utils/injectReducer';
import makeSelectSignUpForm from './selectors';
import reducer from './reducer';
import saga from './saga';
import messages from './messages';

/* eslint-disable react/prefer-stateless-function */
export class SignUpForm extends React.Component {
  render() {
    return (
      <div>
        <Helmet>
          <title>SignUpForm</title>
          <meta name="description" content="Description of SignUpForm" />
        </Helmet>
        <FormattedMessage {...messages.header} />
      </div>
    );
  }
}

SignUpForm.propTypes = {
  dispatch: PropTypes.func.isRequired,
};

const mapStateToProps = createStructuredSelector({
  signupform: makeSelectSignUpForm(),
});

function mapDispatchToProps(dispatch) {
  return {
    dispatch,
  };
}

const withConnect = connect(
  mapStateToProps,
  mapDispatchToProps,
);

const withReducer = injectReducer({ key: 'signUpForm', reducer });
const withSaga = injectSaga({ key: 'signUpForm', saga });

export default compose(
  withReducer,
  withSaga,
  withConnect,
)(SignUpForm);
