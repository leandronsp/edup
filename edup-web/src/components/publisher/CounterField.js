import React from 'react';
import PropTypes from 'prop-types';

const CounterField = ({ source, record = {} }) => {
  return <span>{record[source].length}</span>
}

CounterField.propTypes = {
    label: PropTypes.string,
    record: PropTypes.object,
    source: PropTypes.string.isRequired,
};

export default CounterField;
