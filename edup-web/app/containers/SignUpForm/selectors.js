import { createSelector } from 'reselect';
import { initialState } from './reducer';

/**
 * Direct selector to the signUpForm state domain
 */

const selectSignUpFormDomain = state => state.get('signUpForm', initialState);

/**
 * Other specific selectors
 */

/**
 * Default selector used by SignUpForm
 */

const makeSelectSignUpForm = () =>
  createSelector(selectSignUpFormDomain, substate => substate.toJS());

export default makeSelectSignUpForm;
export { selectSignUpFormDomain };
